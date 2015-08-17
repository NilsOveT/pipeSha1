#include <stdio.h>
#include <unistd.h>
#include <fcntl.h> 
#include <sys/mman.h> 
#include <stdint.h>
#include <string.h>
#include <time.h>
#include "hwlib.h" 
#include "soc_a10/socal/socal.h"
#include "soc_a10/socal/hps.h" 
#include "soc_a10/socal/alt_gpio.h"
#include "hps_0.h"


#define REG_BASE 0xFF200000
#define REG_SPAN 0x00200000
#define REG_MASK ( REG_SPAN - 1 )

void* virtual_base;
void* result_addr;
void* hash0_addr;
void* snddincount_addr;
void* snddoutcount_addr;
int fd;
int count;
int st;
int i;
uint32_t hash[5];
uint32_t hashRec[5];
int corr;
uint32_t output[16];
uint32_t rounds[2];
time_t start,end;
double dif;
uint32_t length_min;
uint32_t length_max;
uint32_t length_alphabet[32];
uint32_t alphabet_part;
uint64_t rounds64;

int main (){
	if( ( fd = open( "/dev/mem", ( O_RDWR | O_SYNC ) ) ) == -1 ) {
		printf( "ERROR: could not open \"/dev/mem\"...\n" );
		return( 1 );
	}
	virtual_base=mmap(NULL,REG_SPAN,(PROT_READ|PROT_WRITE),MAP_SHARED,fd,REG_BASE);
	if( virtual_base == MAP_FAILED ) {
			printf( "ERROR: mmap() failed...\n" );
			close( fd );
			return( 1 );
		}

result_addr=virtual_base + ( ( unsigned long  )( RESULT_BASE ) & ( unsigned long)( REG_MASK ) );
hash0_addr=virtual_base + ( ( unsigned long  )( HASH0_BASE ) & ( unsigned long)( REG_MASK ) );
snddincount_addr=virtual_base + ( ( unsigned long  )( SNDDINCOUNT_BASE ) & ( unsigned long)( REG_MASK ) );
snddoutcount_addr=virtual_base + ( ( unsigned long  )( SNDDOUTCOUNT_BASE ) & ( unsigned long)( REG_MASK ) );

while(1){
	if(st == 1){
		*(uint32_t *)snddoutcount_addr = count;
		if(count == *(uint32_t *)snddincount_addr){
			hashRec[count] = *(uint32_t *)result_addr;
			printf("Received hash part %i\r\n", count);
			count = count + 1;
		}
		if(count >= 5){
		st = 0;
		count = 0;
		printf("%x %x %x %x %x\n", hashRec[4], hashRec[3], hashRec[2], hashRec[1], hashRec[0]);
		
			if (hashRec[4] == hash[4] && hashRec[3] == hash[3] && hashRec[2] == hash[2] && hashRec[1] == hash[1] && hashRec[0] == hash[0]){
				printf("Recieved hash is correct. \r\n");
				st = 2;
				count = 0;
				*(uint32_t *)snddoutcount_addr = 15;
			}
			else{
			
			printf("Hash from the FPGA is not the same as the hash from the input, restarting. \r\n");
			*(uint32_t *)snddoutcount_addr = 14;
			st = 0;
			}
		}
	
	}

	else if(st == 2){
		if (count == 0){
			printf("What is the minimum amount of characters in the password? \r\n");
			scanf("%i", &length_min);
			if(length_min > 32 || length_min < 1){
				printf("Character count out of bounds, minimum length set to 1.");
				length_min = 1;}
			printf("What is the maximum amount of characters in the password? \r\n");
			scanf("%i", &length_max);
			if(length_max > 32 || length_max < length_min){
				printf("Character count out of bounds, maximum length set to 32.");
				length_max = 32;}
		}
		if (count < length_max){
			printf("What size will the alphabet for position %i be? \r\n", count);
			scanf("%i", &length_alphabet[count]);
			if(length_alphabet[count] > 128){printf("Alphabet size is too large, 128 characters is the maximum. ");}
			else if(length_alphabet[count] < 1){printf("Alphabet size is too small, 1 character is the minimum. ");}
			else{
				for (i = 0; i*4 < length_alphabet[count]; i = i + 1){
					printf("Write the character code, in hex, for characters %i to %i in the alphabet with position %i. \r\n", i*4, i*4 + 3, count);
					scanf("%x", &alphabet_part);
					*(uint32_t *)hash0_addr = alphabet_part;
					if(i < 12){
					*(uint32_t *)snddoutcount_addr = i;}
					else if(i < 24){
					*(uint32_t *)snddoutcount_addr = i - 12;}
					else if(i < 34){
					*(uint32_t *)snddoutcount_addr = i - 24;}
					else if(i < 44){
					*(uint32_t *)snddoutcount_addr = i - 34;}
					else{*(uint32_t *)snddoutcount_addr = i - 44;}
				}
				*(uint32_t *)snddoutcount_addr = 14;
				count = count + 1;
			}
		}
		else{
			*(uint32_t *)snddoutcount_addr = 15;
			count = 0;
			i = 1;
			st = 3;
		}
	}
	
	else if(st == 3){
		if (count < length_max){
			*(uint32_t *)hash0_addr = length_alphabet[count];
			*(uint32_t *)snddoutcount_addr = i;
			if(i == *(uint32_t *)snddincount_addr){
				printf("Length information for part %i is sent. %i. \r\n", count, length_alphabet[count]);
				count = count + 1;
				if(i < 14){ i = i + 1;}
				else {i = 1;}
			}
		}
		else {
			*(uint32_t *)snddoutcount_addr = 0;
			*(uint32_t *)hash0_addr = length_min;
			if (0 == *(uint32_t *)snddincount_addr){
				*(uint32_t *)snddoutcount_addr = 15;
				st = 4;
				count = 0;
				time (&start);
				printf("Done gathering information, starting. \r\n");
			}
		}
	}
		
	else if(st == 4){
		*(uint32_t *)snddoutcount_addr = count;
		if(count == *(uint32_t *)snddincount_addr){
			output[count] = *(uint32_t *)result_addr;
			printf("Received part %i\r\n", count);
			count = count + 1;
		}
		if(count >= 16){
		st = 5;
		count = 0;
		time (&end);
		dif = difftime (end,start);
		printf("%x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x\n", output[15], output[14], output[13], output[12], output[11], output[10], output[9], output[8], output[7], output[6], output[5], output[4], output[3], output[2], output[1], output[0]);		
		}
	}
	
	else if (st == 5){
		*(uint32_t *)snddoutcount_addr = count;
		if(count == *(uint32_t *)snddincount_addr){
			rounds[count] = *(uint32_t *)result_addr;
			count = count + 1;
		}
		if (count == 2){
			rounds64 = (uint64_t) rounds[1] << 32 | rounds[0];
			printf("Number of 20 ns rounds used to find the correct hash: %g\r\n", (double)rounds64);
			printf("That equals to %g seconds \r\n", (double)rounds64*0.00000002);
			printf("This program measured %g seconds from confirmed hash to received result. \r\n", dif);
			st = 0;
		}
		
	}
	else {
		printf("From the left, enter the first 8 digits of the hash: \r\n");
		scanf("%x", &hash[4]);
		*(uint32_t *)hash0_addr = hash[4];
		*(uint32_t *)snddoutcount_addr = 4;
		printf("Enter next 8 digits of the hash: \r\n");
		scanf("%x", &hash[3]);
		*(uint32_t *)hash0_addr = hash[3];
		*(uint32_t *)snddoutcount_addr = 3;
		printf("Enter next 8 digits of the hash: \r\n");
		scanf("%x", &hash[2]);
		*(uint32_t *)hash0_addr = hash[2];
		*(uint32_t *)snddoutcount_addr = 2;
		printf("Enter next 8 digits of the hash: \r\n");
		scanf("%x", &hash[1]);
		*(uint32_t *)hash0_addr = hash[1];
		*(uint32_t *)snddoutcount_addr = 1;
		printf("Enter last 8 digits of the hash: \r\n");
		scanf("%x", &hash[0]);
		*(uint32_t *)hash0_addr = hash[0];
		*(uint32_t *)snddoutcount_addr = 0;

		printf("%x %x %x %x %x\n", hash[4], hash[3], hash[2], hash[1], hash[0]);
		
			st = 1;
			count = 0;
			*(uint32_t *)snddoutcount_addr = 10;
			corr = 0;
		
	}
}
return 0;




}