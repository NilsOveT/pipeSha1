library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.b7seg.all;

entity pipeSha1 is
	port(
	
	clock_50 : in std_logic;
	
	hex0 : out std_logic_vector (6 downto 0);
	hex1 : out std_logic_vector (6 downto 0);
	hex2 : out std_logic_vector (6 downto 0);
	hex3 : out std_logic_vector (6 downto 0);
	hex4 : out std_logic_vector (6 downto 0);
	hex5 : out std_logic_vector (6 downto 0);
	
	-----HPS connections-------
	hps_conv_usb_n: inout std_logic;
	hps_ddr3_addr: out std_logic_vector(14 downto 0);
	hps_ddr3_ba: out std_logic_vector(2 downto 0);
	hps_ddr3_cas_n: out std_logic;
	hps_ddr3_cke: out std_logic;
	hps_ddr3_ck_n: out std_logic;
	hps_ddr3_ck_p: out std_logic;
	hps_ddr3_cs_n: out std_logic;
	hps_ddr3_dm: out std_logic_vector(3 downto 0);
	hps_ddr3_dq: inout std_logic_vector(31 downto 0);
	hps_ddr3_dqs_n: inout std_logic_vector(3 downto 0);
	hps_ddr3_dqs_p: inout std_logic_vector(3 downto 0);
	hps_ddr3_odt: out std_logic;
	hps_ddr3_ras_n: out std_logic;
	hps_ddr3_reset_n: out std_logic;
	hps_ddr3_rzq: in std_logic;
	hps_ddr3_we_n: out std_logic;
	hps_enet_gtx_clk: out std_logic;
	hps_enet_int_n: inout std_logic;
	hps_enet_mdc: out std_logic;
	hps_enet_mdio: inout std_logic;
	hps_enet_rx_clk: in std_logic;
	hps_enet_rx_data: in std_logic_vector (3 downto 0);
	hps_enet_rx_dv: in std_logic;
	hps_enet_tx_data: out std_logic_vector(3 downto 0);
	hps_enet_tx_en: out std_logic;
	hps_key: inout std_logic;
	hps_sd_clk: out std_logic;
	hps_sd_cmd: inout std_logic;
	hps_sd_data: inout std_logic_vector(3 downto 0);
	hps_uart_rx: in std_logic;
	hps_uart_tx: out std_logic;
	hps_usb_clkout: in std_logic;
	hps_usb_data: inout std_logic_vector(7 downto 0);
	hps_usb_dir: in std_logic;
	hps_usb_nxt: in std_logic;
	hps_usb_stp: out std_logic);
end pipeSha1;

architecture main of pipeSha1 is
	
	 component soc_system is
        port (
            clk_clk                                 : in    std_logic                     := 'X';             -- clk
            hps_0_h2f_reset_reset_n                 : out   std_logic;                                        -- reset_n
            hps_io_hps_io_emac1_inst_TX_CLK         : out   std_logic;                                        -- hps_io_emac1_inst_TX_CLK
            hps_io_hps_io_emac1_inst_TXD0           : out   std_logic;                                        -- hps_io_emac1_inst_TXD0
            hps_io_hps_io_emac1_inst_TXD1           : out   std_logic;                                        -- hps_io_emac1_inst_TXD1
            hps_io_hps_io_emac1_inst_TXD2           : out   std_logic;                                        -- hps_io_emac1_inst_TXD2
            hps_io_hps_io_emac1_inst_TXD3           : out   std_logic;                                        -- hps_io_emac1_inst_TXD3
            hps_io_hps_io_emac1_inst_RXD0           : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD0
            hps_io_hps_io_emac1_inst_MDIO           : inout std_logic                     := 'X';             -- hps_io_emac1_inst_MDIO
            hps_io_hps_io_emac1_inst_MDC            : out   std_logic;                                        -- hps_io_emac1_inst_MDC
            hps_io_hps_io_emac1_inst_RX_CTL         : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CTL
            hps_io_hps_io_emac1_inst_TX_CTL         : out   std_logic;                                        -- hps_io_emac1_inst_TX_CTL
            hps_io_hps_io_emac1_inst_RX_CLK         : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CLK
            hps_io_hps_io_emac1_inst_RXD1           : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD1
            hps_io_hps_io_emac1_inst_RXD2           : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD2
            hps_io_hps_io_emac1_inst_RXD3           : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD3
            hps_io_hps_io_sdio_inst_CMD             : inout std_logic                     := 'X';             -- hps_io_sdio_inst_CMD
            hps_io_hps_io_sdio_inst_D0              : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D0
            hps_io_hps_io_sdio_inst_D1              : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D1
            hps_io_hps_io_sdio_inst_CLK             : out   std_logic;                                        -- hps_io_sdio_inst_CLK
            hps_io_hps_io_sdio_inst_D2              : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D2
            hps_io_hps_io_sdio_inst_D3              : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D3
            hps_io_hps_io_usb1_inst_D0              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D0
            hps_io_hps_io_usb1_inst_D1              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D1
            hps_io_hps_io_usb1_inst_D2              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D2
            hps_io_hps_io_usb1_inst_D3              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D3
            hps_io_hps_io_usb1_inst_D4              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D4
            hps_io_hps_io_usb1_inst_D5              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D5
            hps_io_hps_io_usb1_inst_D6              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D6
            hps_io_hps_io_usb1_inst_D7              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D7
            hps_io_hps_io_usb1_inst_CLK             : in    std_logic                     := 'X';             -- hps_io_usb1_inst_CLK
            hps_io_hps_io_usb1_inst_STP             : out   std_logic;                                        -- hps_io_usb1_inst_STP
            hps_io_hps_io_usb1_inst_DIR             : in    std_logic                     := 'X';             -- hps_io_usb1_inst_DIR
            hps_io_hps_io_usb1_inst_NXT             : in    std_logic                     := 'X';             -- hps_io_usb1_inst_NXT
            hps_io_hps_io_uart0_inst_RX             : in    std_logic                     := 'X';             -- hps_io_uart0_inst_RX
            hps_io_hps_io_uart0_inst_TX             : out   std_logic;                                        -- hps_io_uart0_inst_TX
            memory_mem_a                            : out   std_logic_vector(14 downto 0);                    -- mem_a
            memory_mem_ba                           : out   std_logic_vector(2 downto 0);                     -- mem_ba
            memory_mem_ck                           : out   std_logic;                                        -- mem_ck
            memory_mem_ck_n                         : out   std_logic;                                        -- mem_ck_n
            memory_mem_cke                          : out   std_logic;                                        -- mem_cke
            memory_mem_cs_n                         : out   std_logic;                                        -- mem_cs_n
            memory_mem_ras_n                        : out   std_logic;                                        -- mem_ras_n
            memory_mem_cas_n                        : out   std_logic;                                        -- mem_cas_n
            memory_mem_we_n                         : out   std_logic;                                        -- mem_we_n
            memory_mem_reset_n                      : out   std_logic;                                        -- mem_reset_n
            memory_mem_dq                           : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
            memory_mem_dqs                          : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
            memory_mem_dqs_n                        : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
            memory_mem_odt                          : out   std_logic;                                        -- mem_odt
            memory_mem_dm                           : out   std_logic_vector(3 downto 0);                     -- mem_dm
            memory_oct_rzqin                        : in    std_logic                     := 'X';             -- oct_rzqin
            reset_reset_n                           : in    std_logic                     := 'X';             -- reset_n
            snddoutcount_external_connection_export : out   std_logic_vector(3 downto 0);                     -- export
            result_external_connection_export       : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
            snddincount_external_connection_export  : in    std_logic_vector(3 downto 0)  := (others => '1'); -- export
            hash0_external_connection_export        : out   std_logic_vector(31 downto 0)                    -- export
            );
    end component soc_system;
	
	--A signal for resetting the hps connection, it is not used.
	signal hps_h2f_rst: std_logic;
	
	--Different datablocks connected to sending and recieveing information.
	signal hash : unsigned(159 downto 0) := (others => '0');
	signal dataBlock : unsigned(511 downto 0) := (others => '0');
	signal dataSend : unsigned(511 downto 0) := (others => '0');
	signal dataTest : unsigned(511 downto 0) := (others => '0');
	signal hashTest: unsigned (159 downto 0) := (others => '0');
	
	--Constants from the sha-1 pseudocode
	constant h0 : unsigned(31 downto 0) := x"67452301";
	constant h1 : unsigned(31 downto 0) := x"EFCDAB89";
	constant h2 : unsigned(31 downto 0) := x"98BADCFE";
	constant h3 : unsigned(31 downto 0) := x"10325476";
	constant h4 : unsigned(31 downto 0) := x"C3D2E1F0";
	constant K0: unsigned(31 downto 0) := x"5A827999";
	constant K1: unsigned(31 downto 0) := x"6ED9EBA1";
	constant K2: unsigned(31 downto 0) := x"8F1BBCDC";
	constant K3: unsigned(31 downto 0) := x"CA62C1D6";
	
	--Variables used to keep track of the current length of the tested data.
	signal dataLength : integer range 0 to 56 := 1;
	signal lengthCount : unsigned(63 downto 0) := (others => '0');
	
	--A big datablock for storing the different alphabets connected to different locations.
	subtype letter is unsigned (7 downto 0);
	type alphabet is array (6399 downto 0) of letter;
	signal alphabets: alphabet := (others => (others => '0'));
	
	--Variables used for keeping track of the current tested letter in a given location.
	subtype int128 is integer range 0 to 127;
	type byteCount_array is array (56 downto 0) of int128;
	signal byteCounts: byteCount_array;
	
	--dataSignal keeps track of the initial datablock for a given step in the pipeline,
	--wordBlock is the 16 words used for calculating in the given step in the pipeline.
	subtype block_type is unsigned(511 downto 0);
	type blockArray is array(79 downto 0) of block_type;
	signal dataSignal: blockArray := (others=> (others => '0'));
	signal wordBlock: blockArray := (others=> (others => '0'));
	
	--lengthBorder keeps track of when the dataLength should change.
	--charCount keeps track of when a letter at a given location should change.
	subtype unsign64 is unsigned (63 downto 0);
	type unsignLengthArr is array(55 downto 0) of unsign64;
	signal lengthBorder: unsignLengthArr := (others=> (others => '0'));
	signal charCount: unsignLengthArr := (others=> (others => '0'));
	
	--alphabetLength is the recieved lengths of the alphabets at the different locations.
	subtype bit_usage is integer range 0 to 128;
	type lengthArray is array(55 downto 0) of bit_usage;
	signal alphabetLength: lengthArray := (others => 0);
	
	--The signals A-F keeps track of the variables A-F at different steps in the calculations.
	subtype word_type is unsigned(31 downto 0);
	type wordArray is array(79 downto 0) of word_type;
		signal A: wordArray := (others=> (others => '0'));
		signal B: wordArray := (others=> (others => '0'));
		signal C: wordArray := (others=> (others => '0'));
		signal D: wordArray := (others=> (others => '0'));
		signal E: wordArray := (others=> (others => '0'));
		signal F: wordArray := (others=> (others => '0'));
	
	--The state machine
	type state_type is (start, fillAlphabets, newHash, checkHash, waitAlphabets, alphLength, waitForStart, mainLoop, conclude, send, sendRounds);
	signal state : state_type := start;
		
	--The signals used to communicate with the HPS
	signal hash_in: std_logic_vector (31 downto 0):= (others => '0');	
	signal word: std_logic_vector (31 downto 0) := (others => '0');
	signal sndInCount: std_logic_vector (3 downto 0):= (others => '0');
	signal sndOutCount: std_logic_vector (3 downto 0):= (others => '0');
	
	--Different counters used when recieveing and sending information. 
	signal sndCount: integer range 0 to 56 := 0;
	signal alphCount: integer range 0 to 56 := 0;
	signal lettAlphCount: integer range 0 to 31 := 0;
	
begin
	
	u0 : component soc_system
        port map (
            clk_clk                               => clock_50,                               --                        clk.clk
            hps_0_h2f_reset_reset_n               => hps_h2f_rst,               --            hps_0_h2f_reset.reset_n
            hps_io_hps_io_emac1_inst_TX_CLK => hps_enet_gtx_clk, --               hps_0_hps_io.hps_io_emac1_inst_TX_CLK
            hps_io_hps_io_emac1_inst_TXD0   => hps_enet_tx_data(0),   --                           .hps_io_emac1_inst_TXD0
            hps_io_hps_io_emac1_inst_TXD1   => hps_enet_tx_data(1),   --                           .hps_io_emac1_inst_TXD1
            hps_io_hps_io_emac1_inst_TXD2   => hps_enet_tx_data(2),   --                           .hps_io_emac1_inst_TXD2
            hps_io_hps_io_emac1_inst_TXD3   => hps_enet_tx_data(3),   --                           .hps_io_emac1_inst_TXD3
            hps_io_hps_io_emac1_inst_RXD0   => hps_enet_rx_data(0),   --                           .hps_io_emac1_inst_RXD0
            hps_io_hps_io_emac1_inst_MDIO   => hps_enet_mdio,   --                           .hps_io_emac1_inst_MDIO
            hps_io_hps_io_emac1_inst_MDC    => hps_enet_mdc,    --                           .hps_io_emac1_inst_MDC
            hps_io_hps_io_emac1_inst_RX_CTL => hps_enet_rx_dv, --                           .hps_io_emac1_inst_RX_CTL
            hps_io_hps_io_emac1_inst_TX_CTL => hps_enet_tx_en, --                           .hps_io_emac1_inst_TX_CTL
            hps_io_hps_io_emac1_inst_RX_CLK => hps_enet_rx_clk, --                           .hps_io_emac1_inst_RX_CLK
            hps_io_hps_io_emac1_inst_RXD1   => hps_enet_rx_data(1),   --                           .hps_io_emac1_inst_RXD1
            hps_io_hps_io_emac1_inst_RXD2   => hps_enet_rx_data(2),   --                           .hps_io_emac1_inst_RXD2
            hps_io_hps_io_emac1_inst_RXD3   => hps_enet_rx_data(3),   --                           .hps_io_emac1_inst_RXD3
            hps_io_hps_io_sdio_inst_CMD     => hps_sd_cmd,     --                           .hps_io_sdio_inst_CMD
            hps_io_hps_io_sdio_inst_D0      => hps_sd_data(0),      --                           .hps_io_sdio_inst_D0
            hps_io_hps_io_sdio_inst_D1      => hps_sd_data(1),      --                           .hps_io_sdio_inst_D1
            hps_io_hps_io_sdio_inst_CLK     => hps_sd_clk,     --                           .hps_io_sdio_inst_CLK
            hps_io_hps_io_sdio_inst_D2      => hps_sd_data(2),      --                           .hps_io_sdio_inst_D2
            hps_io_hps_io_sdio_inst_D3      => hps_sd_data(3),      --                           .hps_io_sdio_inst_D3
            hps_io_hps_io_usb1_inst_D0      => hps_usb_data(0),      --                           .hps_io_usb1_inst_D0
            hps_io_hps_io_usb1_inst_D1      => hps_usb_data(1),      --                           .hps_io_usb1_inst_D1
            hps_io_hps_io_usb1_inst_D2      => hps_usb_data(2),      --                           .hps_io_usb1_inst_D2
            hps_io_hps_io_usb1_inst_D3      => hps_usb_data(3),      --                           .hps_io_usb1_inst_D3
            hps_io_hps_io_usb1_inst_D4      => hps_usb_data(4),      --                           .hps_io_usb1_inst_D4
            hps_io_hps_io_usb1_inst_D5      => hps_usb_data(5),      --                           .hps_io_usb1_inst_D5
            hps_io_hps_io_usb1_inst_D6      => hps_usb_data(6),      --                           .hps_io_usb1_inst_D6
            hps_io_hps_io_usb1_inst_D7      => hps_usb_data(7),      --                           .hps_io_usb1_inst_D7
            hps_io_hps_io_usb1_inst_CLK     => hps_usb_clkout,     --                           .hps_io_usb1_inst_CLK
            hps_io_hps_io_usb1_inst_STP     => hps_usb_stp,     --                           .hps_io_usb1_inst_STP
            hps_io_hps_io_usb1_inst_DIR     => hps_usb_dir,     --                           .hps_io_usb1_inst_DIR
            hps_io_hps_io_usb1_inst_NXT     => hps_usb_nxt,     --                           .hps_io_usb1_inst_NXT
            hps_io_hps_io_uart0_inst_RX     => hps_uart_rx,     --                           .hps_io_uart0_inst_RX
            hps_io_hps_io_uart0_inst_TX     => hps_uart_tx,     --                           .hps_io_uart0_inst_TX
            memory_mem_a                          => hps_ddr3_addr,                          --                     memory.mem_a
            memory_mem_ba                         => hps_ddr3_ba,                         --                           .mem_ba
            memory_mem_ck                         => hps_ddr3_ck_p,                         --                           .mem_ck
            memory_mem_ck_n                       => hps_ddr3_ck_n,                       --                           .mem_ck_n
            memory_mem_cke                        => hps_ddr3_cke,                        --                           .mem_cke
            memory_mem_cs_n                       => hps_ddr3_cs_n,                       --                           .mem_cs_n
            memory_mem_ras_n                      => hps_ddr3_ras_n,                      --                           .mem_ras_n
            memory_mem_cas_n                      => hps_ddr3_cas_n,                      --                           .mem_cas_n
            memory_mem_we_n                       => hps_ddr3_we_n,                       --                           .mem_we_n
            memory_mem_reset_n                    => hps_ddr3_reset_n,                    --                           .mem_reset_n
            memory_mem_dq                         => hps_ddr3_dq,                         --                           .mem_dq
            memory_mem_dqs                        => hps_ddr3_dqs_p,                        --                           .mem_dqs
            memory_mem_dqs_n                      => hps_ddr3_dqs_n,                      --                           .mem_dqs_n
            memory_mem_odt                        => hps_ddr3_odt,                        --                           .mem_odt
            memory_mem_dm                         => hps_ddr3_dm,                         --                           .mem_dm
            memory_oct_rzqin                      => hps_ddr3_rzq,                      --                           .oct_rzqin
            reset_reset_n                         => '1',                         --                      reset.reset_n
            hash0_external_connection_export        => hash_in,        --        hash0_external_connection.export
            snddincount_external_connection_export  => sndInCount,  --  snddincount_external_connection.export
            result_external_connection_export     => word,      -- result_external_connection.export
				snddoutcount_external_connection_export => sndOutCount  -- snddoutcount_external_connection.export
        );
	
	process(clock_50)
	variable rounds: unsigned(63 downto 0) := (others => '0');
	
	begin
		if(rising_edge(clock_50))then
			case state is
				when start =>
				--Mostly resetting of different variables and signals 
					rounds := (others => '0');
					sndInCount <= std_logic_vector(to_unsigned(15, 4));
					dataLength <= 1;
					--This makes the program test the one instance where the length is 0 before 
					--it is able to start testing with the given parameters.
					dataBlock(511 downto 508) <= x"8";
					dataBlock(507 downto 0) <= (others => '0');
					lengthBorder(0)(3 downto 0) <= x"1";
					state <= newHash;
				when newHash =>
				--The state when it recieves the hash to be cracked
					if (to_integer(unsigned(sndOutCount)) > 12)then
						null;
					elsif(to_integer(unsigned(sndOutCount)) > 4)then
						sndInCount <= sndOutCount;
						state <= checkHash;
					else
						if (to_integer(unsigned(sndOutCount)) < 5)then
						--This just displays the last six hex digits on the 7-segmented displays
						--of the recieved part of the hash.
							hex0 <= hex_to7seg(hash((to_integer(unsigned(sndInCount)) * 32) + 3 downto (to_integer(unsigned(sndInCount)) * 32)));
							hex1 <= hex_to7seg(hash((to_integer(unsigned(sndInCount)) * 32) + 7 downto (to_integer(unsigned(sndInCount)) * 32) + 4));
							hex2 <= hex_to7seg(hash((to_integer(unsigned(sndInCount)) * 32) + 11 downto (to_integer(unsigned(sndInCount)) * 32) + 8));
							hex3 <= hex_to7seg(hash((to_integer(unsigned(sndInCount)) * 32) + 15 downto (to_integer(unsigned(sndInCount)) * 32) + 12));
							hex4 <= hex_to7seg(hash((to_integer(unsigned(sndInCount)) * 32) + 19 downto (to_integer(unsigned(sndInCount)) * 32) + 16));
							hex5 <= hex_to7seg(hash((to_integer(unsigned(sndInCount)) * 32) + 23 downto (to_integer(unsigned(sndInCount)) * 32) + 20));
						end if;
						if(sndInCount = sndOutCount)then
							null;
						else
							sndCount <= sndCount +1;
							if (sndCount = 16)then
								hash((to_integer(unsigned(sndOutCount)) * 32) + 31 downto (to_integer(unsigned(sndOutCount)) * 32)) <= unsigned(hash_in);						
								sndInCount <= sndOutCount;
								sndCount <= 0;
							end if;
						end if;
					end if;
				when checkHash =>
				--A kind of redundant double check that the recieved hash is the hash that was typed.
					if (to_integer(unsigned(sndOutCount)) < 5) then
						word <= std_logic_vector(hash((to_integer(unsigned(sndOutCount)) * 32) + 31 downto (to_integer(unsigned(sndOutCount)) * 32)));
						sndInCount <= sndOutCount;
					elsif(to_integer(unsigned(sndOutCount)) < 14)then
						null;
					elsif(to_integer(unsigned(sndOutCount)) < 15)then
						state <= start;
					else
						state <= waitAlphabets;
					end if;
					when waitAlphabets =>
					--The program waits for sndOutCount to not be 1111, as that signal would put the program in to the wrong state.
						if (to_integer(unsigned(sndOutCount)) = 0)then
							state <= fillAlphabets;
						end if;					
					when fillAlphabets =>
					--The alphabets to be used at the different locations is recieved.
					if (to_integer(unsigned(sndOutCount)) < 14)then
						if(sndInCount = sndOutCount)then
							null;
						else
							sndCount <= sndCount +1;
							if (sndCount = 16)then
							--The maximum size of each alphabet is 128, so a different alphCount indicates a new alphabet.
								alphabets((alphCount * 128) + lettAlphCount)	<= unsigned(hash_in(31 downto 24));
								alphabets((alphCount * 128) + lettAlphCount + 1) <= unsigned(hash_in(23 downto 16));
								alphabets((alphCount * 128) + lettAlphCount + 2) <= unsigned(hash_in(15 downto 8));
								alphabets((alphCount * 128) + lettAlphCount + 3) <= unsigned(hash_in(7 downto 0));					
								sndInCount <= sndOutCount;
								sndCount <= 0;
								lettAlphCount <= lettAlphCount + 4;
							end if;
						end if;
					else
						if(sndInCount = sndOutCount)then
							null;
						else
							if(to_integer(unsigned(sndOutCount)) = 14)then
							--sndOutCount = 1110 indicates a new alphabet and alphCount is increased.
								alphCount <= alphCount + 1;
								lettAlphCount <= 0;					
								sndInCount <= sndOutCount;
							else
							--sndOutCount = 1111 indicates that all alphabets are sent and the program is sent to a new state.
								alphCount <= 0;
								lettAlphCount <= 0;
								sndCount <= 0;					
								sndInCount <= sndOutCount;
								state <= alphLength;
							end if;
						end if;
					end if;
				when alphLength =>
					if(sndInCount = sndOutCount)then
						null;
					elsif (to_integer(unsigned(sndOutCount)) > 0)then
					--The length of each alphabet is recieved.
						sndCount <= sndCount +1;
						if (sndCount = 16)then
							alphabetLength(alphCount) <= to_integer(unsigned(hash_in(7 downto 0)));
						elsif sndCount = 20 then
							sndInCount <= sndOutCount;
							sndCount <= 0;
							alphCount <= alphCount + 1;
						end if;
					else 
					--It is calculated from the given lengths of the alphabets when the dataLength should change.
						sndCount <= sndCount +1;
						lengthBorder(sndCount + 1) <= lengthBorder(sndCount)(55 downto 0)*to_unsigned(alphabetLength(sndCount), 8);
						if (sndCount = 54)then
						--The minimum length of the password is recieved and the program moves on to the next state.
							sndInCount <= sndOutCount;
							sndCount <= 0;
							dataLength <= to_integer(unsigned(hash_in));
							state <= waitForStart;
							alphCount <= 0;
							
						end if;
					end if;
				when waitForStart =>
				--This migth be redundant, but it makes sure that both sndInCount and sndOutCount are in the correct 1111 state before starting.
					if (to_integer(unsigned(sndOutCount)) > 14)then
						sndInCount <= sndOutCount;
						state <= mainLoop;
					end if;
					
				when mainLoop =>					
					--This counter is just keeping track of how many 20ns rounds are used by the program.
					rounds := rounds + x"1";
					
					--This if sentence changes the dataLength when needed. 
					if lengthCount + x"1" >= LengthBorder(dataLength) then
						lengthCount <= (others => '0');
						dataLength <= dataLength + 1;
					else lengthCount <= lengthCount + x"1";
					end if;
					
					--This keeps track of which letter is to be tested in position 0
					if byteCounts(0) < alphabetLength(0) - 1 then
							byteCounts(0) <= byteCounts(0) + 1;
					else
							byteCounts(0) <= 0;
					end if;
					
					--The dataBlock is the initial data sent through the program.
					dataBlock(511 downto 504) <= alphabets(byteCounts(0));--Appends the correct letter from the alphabet associated with position 0
					dataBlock(63 downto 0) <= to_unsigned((dataLength * 8), 64);--Appends the length of the data
					--This if sentence appends 10000000 to position 1 if the dataLength is 1, as soon as the dataLength
					--increases it appends a letter from the given alphabet, and changes to the next letter during the correct round. 
					if dataLength > 1 then
						dataBlock(503 downto 496) <= alphabets(byteCounts(1) + 128);
						if charCount(1) + x"1" = lengthBorder(1) then
							charCount(1) <= (others => '0');
							if byteCounts(1) < alphabetLength(1) - 1 then
								byteCounts(1) <= byteCounts(1) + 1;
							else
								byteCounts(1) <= 0;
							end if;
						else charCount(1) <= charCount(1) + x"1";
						end if;
					else
						dataBlock(503 downto 500) <= x"8";
					end if;
					
					--All these if sentences do the same thing, nothing if the dataLength is too small, appends 10000000 to the position if it is at the border and
					--appends a letter from the given alphabet if the dataLength is large enough.
					if(dataLength > 2) then
						dataBlock(495 downto 488) <= alphabets(byteCounts(2) + 128*2);
						if charCount(2) + x"1" = lengthBorder(2) then
							charCount(2) <= (others => '0');
							if byteCounts(2) < alphabetLength(2) - 1 then
								byteCounts(2) <= byteCounts(2) + 1;
							else
								byteCounts(2) <= 0;
							end if;
						else charCount(2) <= charCount(2) + x"1";
						end if;
					elsif (dataLength = 2)then
						dataBlock(495 downto 492) <= x"8";
					end if;
					
					
					if dataLength > 3 then
						dataBlock(487 downto 480) <= alphabets(byteCounts(3) + 128*3);
						if charCount(3) + x"1" = lengthBorder(3) then
							charCount(3) <= (others => '0');
							if byteCounts(3) < alphabetLength(3) - 1 then
								byteCounts(3) <= byteCounts(3) + 1;
							else
								byteCounts(3) <= 0;
							end if;
						else charCount(3) <= charCount(3) + x"1";
						end if;
					elsif dataLength = 3 then
						dataBlock(487 downto 484) <= x"8";
					end if;
					
					if dataLength > 4 then
						dataBlock(479 downto 472) <= alphabets(byteCounts(4) + 128*4);
						if charCount(4) + x"1" = lengthBorder(4) then
							charCount(4) <= (others => '0');
							if byteCounts(4) < alphabetLength(4) - 1 then
								byteCounts(4) <= byteCounts(4) + 1;
							else
								byteCounts(4) <= 0;
							end if;
						else charCount(4) <= charCount(4) + x"1";
						end if;
					elsif dataLength = 4 then
						dataBlock(479 downto 476) <= x"8";
					end if;
					
					if dataLength > 5 then
						dataBlock(471 downto 464) <= alphabets(byteCounts(5) + 128*5);
						if charCount(5) + x"1" = lengthBorder(5) then
							charCount(5) <= (others => '0');
							if byteCounts(5) < alphabetLength(5) - 1 then
								byteCounts(5) <= byteCounts(5) + 1;
							else
								byteCounts(5) <= 0;
							end if;
						else charCount(5) <= charCount(5) + x"1";
						end if;
					elsif dataLength = 5 then
						dataBlock(471 downto 468) <= x"8";
					end if;
					
					if dataLength > 6 then
						dataBlock(463 downto 456) <= alphabets(byteCounts(6) + 128*6);
						if charCount(6) + x"1" = lengthBorder(6) then
							charCount(6) <= (others => '0');
							if byteCounts(6) < alphabetLength(6) - 1 then
								byteCounts(6) <= byteCounts(6) + 1;
							else
								byteCounts(6) <= 0;
							end if;
						else charCount(6) <= charCount(6) + x"1";
						end if;
					elsif dataLength = 6 then
						dataBlock(463 downto 460) <= x"8";
					end if;
					
					if dataLength > 7 then
						dataBlock(455 downto 448) <= alphabets(byteCounts(7) + 128*7);
						if charCount(7) + x"1" = lengthBorder(7) then
							charCount(7) <= (others => '0');
							if byteCounts(7) < alphabetLength(7) - 1 then
								byteCounts(7) <= byteCounts(7) + 1;
							else
								byteCounts(7) <= 0;
							end if;
						else charCount(7) <= charCount(7) + x"1";
						end if;
					elsif dataLength = 7 then
						dataBlock(455 downto 452) <= x"8";
					end if;
					
					if dataLength > 8 then
						dataBlock(447 downto 440) <= alphabets(byteCounts(8) + 128*8);
						if charCount(8) + x"1" = lengthBorder(8) then
							charCount(8) <= (others => '0');
							if byteCounts(8) < alphabetLength(8) - 1 then
								byteCounts(8) <= byteCounts(8) + 1;
							else
								byteCounts(8) <= 0;
							end if;
						else charCount(8) <= charCount(8) + x"1";
						end if;
					elsif dataLength = 8 then
						dataBlock(447 downto 444) <= x"8";
					end if;
					
					if dataLength > 9 then
						dataBlock(439 downto 432) <= alphabets(byteCounts(9) + 128*9);
						if charCount(9) + x"1" = lengthBorder(9) then
							charCount(9) <= (others => '0');
							if byteCounts(9) < alphabetLength(9) - 1 then
								byteCounts(9) <= byteCounts(9) + 1;
							else
								byteCounts(9) <= 0;
							end if;
						else charCount(9) <= charCount(9) + x"1";
						end if;
					elsif dataLength = 9 then
						dataBlock(439 downto 436) <= x"8";
					end if;
					
					if dataLength > 10 then
						dataBlock(431 downto 424) <= alphabets(byteCounts(10) + 128*10);
						if charCount(10) + x"1" = lengthBorder(10) then
							charCount(10) <= (others => '0');
							if byteCounts(10) < alphabetLength(10) - 1 then
								byteCounts(10) <= byteCounts(10) + 1;
							else
								byteCounts(10) <= 0;
							end if;
						else charCount(10) <= charCount(10) + x"1";
						end if;
					elsif dataLength = 10 then
						dataBlock(431 downto 428) <= x"8";
					end if;
					
					if(dataLength > 11) then
						dataBlock(423 downto 416) <= alphabets(byteCounts(11) + 128*11);
						if charCount(11) + x"1" = lengthBorder(11) then
							charCount(11) <= (others => '0');
							if byteCounts(11) < alphabetLength(11) - 1 then
								byteCounts(11) <= byteCounts(11) + 1;
							else
								byteCounts(11) <= 0;
							end if;
						else charCount(11) <= charCount(11) + x"1";
						end if;
					elsif (dataLength = 11)then
						dataBlock(423 downto 420) <= x"8";
					end if;
					
					if(dataLength > 12) then
						dataBlock(415 downto 408) <= alphabets(byteCounts(12) + 128*12);
						if charCount(12) + x"1" = lengthBorder(12) then
							charCount(12) <= (others => '0');
							if byteCounts(12) < alphabetLength(12) - 1 then
								byteCounts(12) <= byteCounts(12) + 1;
							else
								byteCounts(12) <= 0;
							end if;
						else charCount(12) <= charCount(12) + x"1";
						end if;
					elsif (dataLength = 12)then
						dataBlock(415 downto 412) <= x"8";
					end if;
					
					
					if dataLength > 13 then
						dataBlock(407 downto 400) <= alphabets(byteCounts(13) + 128*13);
						if charCount(13) + x"1" = lengthBorder(13) then
							charCount(13) <= (others => '0');
							if byteCounts(13) < alphabetLength(13) - 1 then
								byteCounts(13) <= byteCounts(13) + 1;
							else
								byteCounts(13) <= 0;
							end if;
						else charCount(13) <= charCount(13) + x"1";
						end if;
					elsif dataLength = 13 then
						dataBlock(407 downto 404) <= x"8";
					end if;
					
					if dataLength > 14 then
						dataBlock(399 downto 392) <= alphabets(byteCounts(14) + 128*14);
						if charCount(14) + x"1" = lengthBorder(14) then
							charCount(14) <= (others => '0');
							if byteCounts(14) < alphabetLength(14) - 1 then
								byteCounts(14) <= byteCounts(14) + 1;
							else
								byteCounts(14) <= 0;
							end if;
						else charCount(14) <= charCount(14) + x"1";
						end if;
					elsif dataLength = 14 then
						dataBlock(399 downto 396) <= x"8";
					end if;
					
					if dataLength > 15 then
						dataBlock(391 downto 384) <= alphabets(byteCounts(15) + 128*15);
						if charCount(15) + x"1" = lengthBorder(15) then
							charCount(15) <= (others => '0');
							if byteCounts(15) < alphabetLength(15) - 1 then
								byteCounts(15) <= byteCounts(15) + 1;
							else
								byteCounts(15) <= 0;
							end if;
						else charCount(15) <= charCount(15) + x"1";
						end if;
					elsif dataLength = 15 then
						dataBlock(391 downto 388) <= x"8";
					end if;
					
					if dataLength > 16 then
						dataBlock(383 downto 376) <= alphabets(byteCounts(16) + 128*16);
						if charCount(16) + x"1" = lengthBorder(16) then
							charCount(16) <= (others => '0');
							if byteCounts(16) < alphabetLength(16) - 1 then
								byteCounts(16) <= byteCounts(16) + 1;
							else
								byteCounts(16) <= 0;
							end if;
						else charCount(16) <= charCount(16) + x"1";
						end if;
					elsif dataLength = 16 then
						dataBlock(383 downto 380) <= x"8";
					end if;
					
					if dataLength > 17 then
						dataBlock(375 downto 368) <= alphabets(byteCounts(17) + 128*17);
						if charCount(17) + x"1" = lengthBorder(17) then
							charCount(17) <= (others => '0');
							if byteCounts(17) < alphabetLength(17) - 1 then
								byteCounts(17) <= byteCounts(17) + 1;
							else
								byteCounts(17) <= 0;
							end if;
						else charCount(17) <= charCount(17) + x"1";
						end if;
					elsif dataLength = 17 then
						dataBlock(375 downto 372) <= x"8";
					end if;
					
					if dataLength > 18 then
						dataBlock(367 downto 360) <= alphabets(byteCounts(18) + 128*18);
						if charCount(18) + x"1" = lengthBorder(18) then
							charCount(18) <= (others => '0');
							if byteCounts(18) < alphabetLength(18) - 1 then
								byteCounts(18) <= byteCounts(18) + 1;
							else
								byteCounts(18) <= 0;
							end if;
						else charCount(18) <= charCount(18) + x"1";
						end if;
					elsif dataLength = 18 then
						dataBlock(367 downto 364) <= x"8";
					end if;
					
					if dataLength > 19 then
						dataBlock(359 downto 352) <= alphabets(byteCounts(19) + 128*19);
						if charCount(19) + x"1" = lengthBorder(19) then
							charCount(19) <= (others => '0');
							if byteCounts(19) < alphabetLength(19) - 1 then
								byteCounts(19) <= byteCounts(19) + 1;
							else
								byteCounts(19) <= 0;
							end if;
						else charCount(19) <= charCount(19) + x"1";
						end if;
					elsif dataLength = 19 then
						dataBlock(359 downto 356) <= x"8";
					end if;
					
					if dataLength > 20 then
						dataBlock(351 downto 344) <= alphabets(byteCounts(20) + 128*20);
						if charCount(20) + x"1" = lengthBorder(20) then
							charCount(20) <= (others => '0');
							if byteCounts(20) < alphabetLength(20) - 1 then
								byteCounts(20) <= byteCounts(20) + 1;
							else
								byteCounts(20) <= 0;
							end if;
						else charCount(20) <= charCount(20) + x"1";
						end if;
					elsif dataLength = 20 then
						dataBlock(351 downto 348) <= x"8";
					end if;
					
					if(dataLength > 21) then
						dataBlock(343 downto 336) <= alphabets(byteCounts(21) + 128*21);
						if charCount(21) + x"1" = lengthBorder(21) then
							charCount(21) <= (others => '0');
							if byteCounts(21) < alphabetLength(21) - 1 then
								byteCounts(21) <= byteCounts(21) + 1;
							else
								byteCounts(21) <= 0;
							end if;
						else charCount(21) <= charCount(21) + x"1";
						end if;
					elsif (dataLength = 21)then
						dataBlock(343 downto 340) <= x"8";
					end if;
					
					if(dataLength > 22) then
						dataBlock(335 downto 328) <= alphabets(byteCounts(22) + 128*22);
						if charCount(22) + x"1" = lengthBorder(22) then
							charCount(22) <= (others => '0');
							if byteCounts(22) < alphabetLength(22) - 1 then
								byteCounts(22) <= byteCounts(22) + 1;
							else
								byteCounts(22) <= 0;
							end if;
						else charCount(22) <= charCount(22) + x"1";
						end if;
					elsif (dataLength = 22)then
						dataBlock(335 downto 332) <= x"8";
					end if;
					
					
					if dataLength > 23 then
						dataBlock(327 downto 320) <= alphabets(byteCounts(23) + 128*23);
						if charCount(23) + x"1" = lengthBorder(23) then
							charCount(23) <= (others => '0');
							if byteCounts(23) < alphabetLength(23) - 1 then
								byteCounts(23) <= byteCounts(23) + 1;
							else
								byteCounts(23) <= 0;
							end if;
						else charCount(23) <= charCount(23) + x"1";
						end if;
					elsif dataLength = 23 then
						dataBlock(327 downto 324) <= x"8";
					end if;
					
					if dataLength > 24 then
						dataBlock(319 downto 312) <= alphabets(byteCounts(24) + 128*24);
						if charCount(24) + x"1" = lengthBorder(24) then
							charCount(24) <= (others => '0');
							if byteCounts(24) < alphabetLength(24) - 1 then
								byteCounts(24) <= byteCounts(24) + 1;
							else
								byteCounts(24) <= 0;
							end if;
						else charCount(24) <= charCount(24) + x"1";
						end if;
					elsif dataLength = 24 then
						dataBlock(319 downto 316) <= x"8";
					end if;
					
					if dataLength > 25 then
						dataBlock(311 downto 304) <= alphabets(byteCounts(25) + 128*25);
						if charCount(25) + x"1" = lengthBorder(25) then
							charCount(25) <= (others => '0');
							if byteCounts(25) < alphabetLength(25) - 1 then
								byteCounts(25) <= byteCounts(25) + 1;
							else
								byteCounts(25) <= 0;
							end if;
						else charCount(25) <= charCount(25) + x"1";
						end if;
					elsif dataLength = 25 then
						dataBlock(311 downto 308) <= x"8";
					end if;
					
					if dataLength > 26 then
						dataBlock(303 downto 296) <= alphabets(byteCounts(26) + 128*26);
						if charCount(26) + x"1" = lengthBorder(26) then
							charCount(26) <= (others => '0');
							if byteCounts(26) < alphabetLength(26) - 1 then
								byteCounts(26) <= byteCounts(26) + 1;
							else
								byteCounts(26) <= 0;
							end if;
						else charCount(26) <= charCount(26) + x"1";
						end if;
					elsif dataLength = 26 then
						dataBlock(303 downto 300) <= x"8";
					end if;
					
					if dataLength > 27 then
						dataBlock(295 downto 288) <= alphabets(byteCounts(27) + 128*27);
						if charCount(27) + x"1" = lengthBorder(27) then
							charCount(27) <= (others => '0');
							if byteCounts(27) < alphabetLength(27) - 1 then
								byteCounts(27) <= byteCounts(27) + 1;
							else
								byteCounts(27) <= 0;
							end if;
						else charCount(27) <= charCount(27) + x"1";
						end if;
					elsif dataLength = 27 then
						dataBlock(295 downto 292) <= x"8";
					end if;
					
					if dataLength > 28 then
						dataBlock(287 downto 280) <= alphabets(byteCounts(28) + 128*28);
						if charCount(28) + x"1" = lengthBorder(28) then
							charCount(28) <= (others => '0');
							if byteCounts(28) < alphabetLength(28) - 1 then
								byteCounts(28) <= byteCounts(28) + 1;
							else
								byteCounts(28) <= 0;
							end if;
						else charCount(28) <= charCount(28) + x"1";
						end if;
					elsif dataLength = 28 then
						dataBlock(287 downto 284) <= x"8";
					end if;
					
					if dataLength > 29 then
						dataBlock(279 downto 272) <= alphabets(byteCounts(29) + 128*29);
						if charCount(29) + x"1" = lengthBorder(29) then
							charCount(29) <= (others => '0');
							if byteCounts(29) < alphabetLength(29) - 1 then
								byteCounts(29) <= byteCounts(29) + 1;
							else
								byteCounts(29) <= 0;
							end if;
						else charCount(29) <= charCount(29) + x"1";
						end if;
					elsif dataLength = 29 then
						dataBlock(279 downto 276) <= x"8";
					end if;
					
					if dataLength > 30 then
						dataBlock(271 downto 264) <= alphabets(byteCounts(30) + 128*30);
						if charCount(30) + x"1" = lengthBorder(30) then
							charCount(30) <= (others => '0');
							if byteCounts(30) < alphabetLength(30) - 1 then
								byteCounts(30) <= byteCounts(30) + 1;
							else
								byteCounts(30) <= 0;
							end if;
						else charCount(30) <= charCount(30) + x"1";
						end if;
					elsif dataLength = 30 then
						dataBlock(271 downto 268) <= x"8";
					end if;
					
					if(dataLength > 31) then
						dataBlock(263 downto 256) <= alphabets(byteCounts(31) + 128*31);
						if charCount(31) + x"1" = lengthBorder(31) then
							charCount(31) <= (others => '0');
							if byteCounts(31) < alphabetLength(31) - 1 then
								byteCounts(31) <= byteCounts(31) + 1;
							else
								byteCounts(31) <= 0;
							end if;
						else charCount(31) <= charCount(31) + x"1";
						end if;
					elsif (dataLength = 31)then
						dataBlock(263 downto 260) <= x"8";
					end if;
					
					if(dataLength > 32) then
						dataBlock(255 downto 248) <= alphabets(byteCounts(32) + 128*32);
						if charCount(32) + x"1" = lengthBorder(32) then
							charCount(32) <= (others => '0');
							if byteCounts(32) < alphabetLength(32) - 1 then
								byteCounts(32) <= byteCounts(32) + 1;
							else
								byteCounts(32) <= 0;
							end if;
						else charCount(32) <= charCount(32) + x"1";
						end if;
					elsif (dataLength = 32)then
						dataBlock(255 downto 252) <= x"8";
					end if;
					
					
					if dataLength > 33 then
						dataBlock(247 downto 240) <= alphabets(byteCounts(33) + 128*33);
						if charCount(33) + x"1" = lengthBorder(33) then
							charCount(33) <= (others => '0');
							if byteCounts(33) < alphabetLength(33) - 1 then
								byteCounts(33) <= byteCounts(33) + 1;
							else
								byteCounts(33) <= 0;
							end if;
						else charCount(33) <= charCount(33) + x"1";
						end if;
					elsif dataLength = 33 then
						dataBlock(247 downto 244) <= x"8";
					end if;
					
					if dataLength > 34 then
						dataBlock(239 downto 232) <= alphabets(byteCounts(34) + 128*34);
						if charCount(34) + x"1" = lengthBorder(34) then
							charCount(34) <= (others => '0');
							if byteCounts(34) < alphabetLength(34) - 1 then
								byteCounts(34) <= byteCounts(34) + 1;
							else
								byteCounts(34) <= 0;
							end if;
						else charCount(34) <= charCount(34) + x"1";
						end if;
					elsif dataLength = 34 then
						dataBlock(239 downto 236) <= x"8";
					end if;
					
					if dataLength > 35 then
						dataBlock(231 downto 224) <= alphabets(byteCounts(35) + 128*35);
						if charCount(35) + x"1" = lengthBorder(35) then
							charCount(35) <= (others => '0');
							if byteCounts(35) < alphabetLength(35) - 1 then
								byteCounts(35) <= byteCounts(35) + 1;
							else
								byteCounts(35) <= 0;
							end if;
						else charCount(35) <= charCount(35) + x"1";
						end if;
					elsif dataLength = 35 then
						dataBlock(231 downto 228) <= x"8";
					end if;
					
					if dataLength > 36 then
						dataBlock(223 downto 216) <= alphabets(byteCounts(36) + 128*36);
						if charCount(36) + x"1" = lengthBorder(36) then
							charCount(36) <= (others => '0');
							if byteCounts(36) < alphabetLength(36) - 1 then
								byteCounts(36) <= byteCounts(36) + 1;
							else
								byteCounts(36) <= 0;
							end if;
						else charCount(36) <= charCount(36) + x"1";
						end if;
					elsif dataLength = 36 then
						dataBlock(223 downto 220) <= x"8";
					end if;
					
					if dataLength > 37 then
						dataBlock(215 downto 208) <= alphabets(byteCounts(37) + 128*37);
						if charCount(37) + x"1" = lengthBorder(37) then
							charCount(37) <= (others => '0');
							if byteCounts(37) < alphabetLength(37) - 1 then
								byteCounts(37) <= byteCounts(37) + 1;
							else
								byteCounts(37) <= 0;
							end if;
						else charCount(37) <= charCount(37) + x"1";
						end if;
					elsif dataLength = 37 then
						dataBlock(215 downto 212) <= x"8";
					end if;
					
					if dataLength > 38 then
						dataBlock(207 downto 200) <= alphabets(byteCounts(38) + 128*38);
						if charCount(38) + x"1" = lengthBorder(38) then
							charCount(38) <= (others => '0');
							if byteCounts(38) < alphabetLength(38) - 1 then
								byteCounts(38) <= byteCounts(38) + 1;
							else
								byteCounts(38) <= 0;
							end if;
						else charCount(38) <= charCount(38) + x"1";
						end if;
					elsif dataLength = 38 then
						dataBlock(207 downto 204) <= x"8";
					end if;
					
					if dataLength > 39 then
						dataBlock(199 downto 192) <= alphabets(byteCounts(39) + 128*39);
						if charCount(39) + x"1" = lengthBorder(39) then
							charCount(39) <= (others => '0');
							if byteCounts(39) < alphabetLength(39) - 1 then
								byteCounts(39) <= byteCounts(39) + 1;
							else
								byteCounts(39) <= 0;
							end if;
						else charCount(39) <= charCount(39) + x"1";
						end if;
					elsif dataLength = 39 then
						dataBlock(199 downto 196) <= x"8";
					end if;
					
					if dataLength > 40 then
						dataBlock(191 downto 184) <= alphabets(byteCounts(40) + 128*40);
						if charCount(40) + x"1" = lengthBorder(40) then
							charCount(40) <= (others => '0');
							if byteCounts(40) < alphabetLength(40) - 1 then
								byteCounts(40) <= byteCounts(40) + 1;
							else
								byteCounts(40) <= 0;
							end if;
						else charCount(40) <= charCount(40) + x"1";
						end if;
					elsif dataLength = 40 then
						dataBlock(191 downto 188) <= x"8";
					end if;
					
					if(dataLength > 41) then
						dataBlock(183 downto 176) <= alphabets(byteCounts(41) + 128*41);
						if charCount(41) + x"1" = lengthBorder(41) then
							charCount(41) <= (others => '0');
							if byteCounts(41) < alphabetLength(41) - 1 then
								byteCounts(41) <= byteCounts(41) + 1;
							else
								byteCounts(41) <= 0;
							end if;
						else charCount(41) <= charCount(41) + x"1";
						end if;
					elsif (dataLength = 41)then
						dataBlock(183 downto 180) <= x"8";
					end if;
					
					if(dataLength > 42) then
						dataBlock(175 downto 168) <= alphabets(byteCounts(42) + 128*42);
						if charCount(42) + x"1" = lengthBorder(42) then
							charCount(42) <= (others => '0');
							if byteCounts(42) < alphabetLength(42) - 1 then
								byteCounts(42) <= byteCounts(42) + 1;
							else
								byteCounts(42) <= 0;
							end if;
						else charCount(42) <= charCount(42) + x"1";
						end if;
					elsif (dataLength = 42)then
						dataBlock(175 downto 172) <= x"8";
					end if;
					
					
					if dataLength > 43 then
						dataBlock(167 downto 160) <= alphabets(byteCounts(43) + 128*43);
						if charCount(43) + x"1" = lengthBorder(43) then
							charCount(43) <= (others => '0');
							if byteCounts(43) < alphabetLength(43) - 1 then
								byteCounts(43) <= byteCounts(43) + 1;
							else
								byteCounts(43) <= 0;
							end if;
						else charCount(43) <= charCount(43) + x"1";
						end if;
					elsif dataLength = 43 then
						dataBlock(167 downto 164) <= x"8";
					end if;
					
					if dataLength > 44 then
						dataBlock(159 downto 152) <= alphabets(byteCounts(44) + 128*44);
						if charCount(44) + x"1" = lengthBorder(44) then
							charCount(44) <= (others => '0');
							if byteCounts(44) < alphabetLength(44) - 1 then
								byteCounts(44) <= byteCounts(44) + 1;
							else
								byteCounts(44) <= 0;
							end if;
						else charCount(44) <= charCount(44) + x"1";
						end if;
					elsif dataLength = 44 then
						dataBlock(159 downto 156) <= x"8";
					end if;
					
					if dataLength > 45 then
						dataBlock(151 downto 144) <= alphabets(byteCounts(45) + 128*45);
						if charCount(45) + x"1" = lengthBorder(45) then
							charCount(45) <= (others => '0');
							if byteCounts(45) < alphabetLength(45) - 1 then
								byteCounts(45) <= byteCounts(45) + 1;
							else
								byteCounts(45) <= 0;
							end if;
						else charCount(45) <= charCount(45) + x"1";
						end if;
					elsif dataLength = 45 then
						dataBlock(151 downto 148) <= x"8";
					end if;
					
					if dataLength > 46 then
						dataBlock(143 downto 136) <= alphabets(byteCounts(46) + 128*46);
						if charCount(46) + x"1" = lengthBorder(46) then
							charCount(46) <= (others => '0');
							if byteCounts(46) < alphabetLength(46) - 1 then
								byteCounts(46) <= byteCounts(46) + 1;
							else
								byteCounts(46) <= 0;
							end if;
						else charCount(46) <= charCount(46) + x"1";
						end if;
					elsif dataLength = 46 then
						dataBlock(143 downto 140) <= x"8";
					end if;
					
					if dataLength > 47 then
						dataBlock(135 downto 128) <= alphabets(byteCounts(47) + 128*47);
						if charCount(47) + x"1" = lengthBorder(47) then
							charCount(47) <= (others => '0');
							if byteCounts(47) < alphabetLength(47) - 1 then
								byteCounts(47) <= byteCounts(47) + 1;
							else
								byteCounts(47) <= 0;
							end if;
						else charCount(47) <= charCount(47) + x"1";
						end if;
					elsif dataLength = 47 then
						dataBlock(135 downto 132) <= x"8";
					end if;
					
					if dataLength > 48 then
						dataBlock(127 downto 120) <= alphabets(byteCounts(48) + 128*48);
						if charCount(48) + x"1" = lengthBorder(48) then
							charCount(48) <= (others => '0');
							if byteCounts(48) < alphabetLength(48) - 1 then
								byteCounts(48) <= byteCounts(48) + 1;
							else
								byteCounts(48) <= 0;
							end if;
						else charCount(48) <= charCount(48) + x"1";
						end if;
					elsif dataLength = 48 then
						dataBlock(127 downto 124) <= x"8";
					end if;
					
					if dataLength > 49 then
						dataBlock(119 downto 112) <= alphabets(byteCounts(49) + 128*49);
						if charCount(49) + x"1" = lengthBorder(49) then
							charCount(49) <= (others => '0');
							if byteCounts(49) < alphabetLength(49) - 1 then
								byteCounts(49) <= byteCounts(49) + 1;
							else
								byteCounts(49) <= 0;
							end if;
						else charCount(49) <= charCount(49) + x"1";
						end if;
						dataBlock(111 downto 108) <= x"8";
					elsif dataLength = 49 then
						dataBlock(119 downto 116) <= x"8";
					end if;
					
					--The dataSignal is the initial dataBlock for each step, as it moves to a new step in the calculation 
					--the data follows in the dataSignal.
					dataSignal(0) <= dataBlock;
					dataSignal(1) <= dataSignal(0);
					dataSignal(2) <= dataSignal(1);
					dataSignal(3) <= dataSignal(2);
					dataSignal(4) <= dataSignal(3);
					dataSignal(5) <= dataSignal(4);
					dataSignal(6) <= dataSignal(5);
					dataSignal(7) <= dataSignal(6);
					dataSignal(8) <= dataSignal(7);
					dataSignal(9) <= dataSignal(8);
					dataSignal(10) <= dataSignal(9);
					dataSignal(11) <= dataSignal(10);
					dataSignal(12) <= dataSignal(11);
					dataSignal(13) <= dataSignal(12);
					dataSignal(14) <= dataSignal(13);
					dataSignal(15) <= dataSignal(14);
					dataSignal(16) <= dataSignal(15);
					dataSignal(17) <= dataSignal(16);
					dataSignal(18) <= dataSignal(17);
					dataSignal(19) <= dataSignal(18);
					dataSignal(20) <= dataSignal(19);
					dataSignal(21) <= dataSignal(20);
					dataSignal(22) <= dataSignal(21);
					dataSignal(23) <= dataSignal(22);
					dataSignal(24) <= dataSignal(23);
					dataSignal(25) <= dataSignal(24);
					dataSignal(26) <= dataSignal(25);
					dataSignal(27) <= dataSignal(26);
					dataSignal(28) <= dataSignal(27);
					dataSignal(29) <= dataSignal(28);
					dataSignal(30) <= dataSignal(29);
					dataSignal(31) <= dataSignal(30);
					dataSignal(32) <= dataSignal(31);
					dataSignal(33) <= dataSignal(32);
					dataSignal(34) <= dataSignal(33);
					dataSignal(35) <= dataSignal(34);
					dataSignal(36) <= dataSignal(35);
					dataSignal(37) <= dataSignal(36);
					dataSignal(38) <= dataSignal(37);
					dataSignal(39) <= dataSignal(38);
					dataSignal(40) <= dataSignal(39);
					dataSignal(41) <= dataSignal(40);
					dataSignal(42) <= dataSignal(41);
					dataSignal(43) <= dataSignal(42);
					dataSignal(44) <= dataSignal(43);
					dataSignal(45) <= dataSignal(44);
					dataSignal(46) <= dataSignal(45);
					dataSignal(47) <= dataSignal(46);
					dataSignal(48) <= dataSignal(47);
					dataSignal(49) <= dataSignal(48);
					dataSignal(50) <= dataSignal(49);
					dataSignal(51) <= dataSignal(50);
					dataSignal(52) <= dataSignal(51);
					dataSignal(53) <= dataSignal(52);
					dataSignal(54) <= dataSignal(53);
					dataSignal(55) <= dataSignal(54);
					dataSignal(56) <= dataSignal(55);
					dataSignal(57) <= dataSignal(56);
					dataSignal(58) <= dataSignal(57);
					dataSignal(59) <= dataSignal(58);
					dataSignal(60) <= dataSignal(59);
					dataSignal(61) <= dataSignal(60);
					dataSignal(62) <= dataSignal(61);
					dataSignal(63) <= dataSignal(62);
					dataSignal(64) <= dataSignal(63);
					dataSignal(65) <= dataSignal(64);
					dataSignal(66) <= dataSignal(65);
					dataSignal(67) <= dataSignal(66);
					dataSignal(68) <= dataSignal(67);
					dataSignal(69) <= dataSignal(68);
					dataSignal(70) <= dataSignal(69);
					dataSignal(71) <= dataSignal(70);
					dataSignal(72) <= dataSignal(71);
					dataSignal(73) <= dataSignal(72);
					dataSignal(74) <= dataSignal(73);
					dataSignal(75) <= dataSignal(74);
					dataSignal(76) <= dataSignal(75);
					dataSignal(77) <= dataSignal(76);
					dataSignal(78) <= dataSignal(77);
					dataSignal(79) <= dataSignal(78);
					
					--A new word is calculated from the 16 32-bit words associated with the last step. The oldest word is 
					--"forgotten" since the algorithm never goes farther back than 16 words. 	
					wordBlock(0)(31 downto 0) <= (dataBlock(95 downto 64) xor dataBlock(255 downto 224) xor dataBlock(447 downto 416) xor dataBlock(511 downto 480)) rol 1;
					wordBlock(0)(511 downto 32) <= dataBlock(479 downto 0);
					wordBlock(1)(31 downto 0) <= (wordBlock(0)(95 downto 64) xor wordBlock(0)(255 downto 224) xor wordBlock(0)(447 downto 416) xor wordBlock(0)(511 downto 480)) rol 1;
					wordBlock(1)(511 downto 32) <= wordBlock(0)(479 downto 0);
					wordBlock(2)(31 downto 0) <= (wordBlock(1)(95 downto 64) xor wordBlock(1)(255 downto 224) xor wordBlock(1)(447 downto 416) xor wordBlock(1)(511 downto 480)) rol 1;
					wordBlock(2)(511 downto 32) <= wordBlock(1)(479 downto 0);
					wordBlock(3)(31 downto 0) <= (wordBlock(2)(95 downto 64) xor wordBlock(2)(255 downto 224) xor wordBlock(2)(447 downto 416) xor wordBlock(2)(511 downto 480)) rol 1;
					wordBlock(3)(511 downto 32) <= wordBlock(2)(479 downto 0);
					wordBlock(4)(31 downto 0) <= (wordBlock(3)(95 downto 64) xor wordBlock(3)(255 downto 224) xor wordBlock(3)(447 downto 416) xor wordBlock(3)(511 downto 480)) rol 1;
					wordBlock(4)(511 downto 32) <= wordBlock(3)(479 downto 0);
					wordBlock(5)(31 downto 0) <= (wordBlock(4)(95 downto 64) xor wordBlock(4)(255 downto 224) xor wordBlock(4)(447 downto 416) xor wordBlock(4)(511 downto 480)) rol 1;
					wordBlock(5)(511 downto 32) <= wordBlock(4)(479 downto 0);
					wordBlock(6)(31 downto 0) <= (wordBlock(5)(95 downto 64) xor wordBlock(5)(255 downto 224) xor wordBlock(5)(447 downto 416) xor wordBlock(5)(511 downto 480)) rol 1;
					wordBlock(6)(511 downto 32) <= wordBlock(5)(479 downto 0);
					wordBlock(7)(31 downto 0) <= (wordBlock(6)(95 downto 64) xor wordBlock(6)(255 downto 224) xor wordBlock(6)(447 downto 416) xor wordBlock(6)(511 downto 480)) rol 1;
					wordBlock(7)(511 downto 32) <= wordBlock(6)(479 downto 0);
					wordBlock(8)(31 downto 0) <= (wordBlock(7)(95 downto 64) xor wordBlock(7)(255 downto 224) xor wordBlock(7)(447 downto 416) xor wordBlock(7)(511 downto 480)) rol 1;
					wordBlock(8)(511 downto 32) <= wordBlock(7)(479 downto 0);
					wordBlock(9)(31 downto 0) <= (wordBlock(8)(95 downto 64) xor wordBlock(8)(255 downto 224) xor wordBlock(8)(447 downto 416) xor wordBlock(8)(511 downto 480)) rol 1;
					wordBlock(9)(511 downto 32) <= wordBlock(8)(479 downto 0);
					wordBlock(10)(31 downto 0) <= (wordBlock(9)(95 downto 64) xor wordBlock(9)(255 downto 224) xor wordBlock(9)(447 downto 416) xor wordBlock(9)(511 downto 480)) rol 1;
					wordBlock(10)(511 downto 32) <= wordBlock(9)(479 downto 0);
					wordBlock(11)(31 downto 0) <= (wordBlock(10)(95 downto 64) xor wordBlock(10)(255 downto 224) xor wordBlock(10)(447 downto 416) xor wordBlock(10)(511 downto 480)) rol 1;
					wordBlock(11)(511 downto 32) <= wordBlock(10)(479 downto 0);
					wordBlock(12)(31 downto 0) <= (wordBlock(11)(95 downto 64) xor wordBlock(11)(255 downto 224) xor wordBlock(11)(447 downto 416) xor wordBlock(11)(511 downto 480)) rol 1;
					wordBlock(12)(511 downto 32) <= wordBlock(11)(479 downto 0);
					wordBlock(13)(31 downto 0) <= (wordBlock(12)(95 downto 64) xor wordBlock(12)(255 downto 224) xor wordBlock(12)(447 downto 416) xor wordBlock(12)(511 downto 480)) rol 1;
					wordBlock(13)(511 downto 32) <= wordBlock(12)(479 downto 0);
					wordBlock(14)(31 downto 0) <= (wordBlock(13)(95 downto 64) xor wordBlock(13)(255 downto 224) xor wordBlock(13)(447 downto 416) xor wordBlock(13)(511 downto 480)) rol 1;
					wordBlock(14)(511 downto 32) <= wordBlock(13)(479 downto 0);
					wordBlock(15)(31 downto 0) <= (wordBlock(14)(95 downto 64) xor wordBlock(14)(255 downto 224) xor wordBlock(14)(447 downto 416) xor wordBlock(14)(511 downto 480)) rol 1;
					wordBlock(15)(511 downto 32) <= wordBlock(14)(479 downto 0);
					wordBlock(16)(31 downto 0) <= (wordBlock(15)(95 downto 64) xor wordBlock(15)(255 downto 224) xor wordBlock(15)(447 downto 416) xor wordBlock(15)(511 downto 480)) rol 1;
					wordBlock(16)(511 downto 32) <= wordBlock(15)(479 downto 0);
					wordBlock(17)(31 downto 0) <= (wordBlock(16)(95 downto 64) xor wordBlock(16)(255 downto 224) xor wordBlock(16)(447 downto 416) xor wordBlock(16)(511 downto 480)) rol 1;
					wordBlock(17)(511 downto 32) <= wordBlock(16)(479 downto 0);
					wordBlock(18)(31 downto 0) <= (wordBlock(17)(95 downto 64) xor wordBlock(17)(255 downto 224) xor wordBlock(17)(447 downto 416) xor wordBlock(17)(511 downto 480)) rol 1;
					wordBlock(18)(511 downto 32) <= wordBlock(17)(479 downto 0);
					wordBlock(19)(31 downto 0) <= (wordBlock(18)(95 downto 64) xor wordBlock(18)(255 downto 224) xor wordBlock(18)(447 downto 416) xor wordBlock(18)(511 downto 480)) rol 1;
					wordBlock(19)(511 downto 32) <= wordBlock(18)(479 downto 0);
					wordBlock(20)(31 downto 0) <= (wordBlock(19)(95 downto 64) xor wordBlock(19)(255 downto 224) xor wordBlock(19)(447 downto 416) xor wordBlock(19)(511 downto 480)) rol 1;
					wordBlock(20)(511 downto 32) <= wordBlock(19)(479 downto 0);
					wordBlock(21)(31 downto 0) <= (wordBlock(20)(95 downto 64) xor wordBlock(20)(255 downto 224) xor wordBlock(20)(447 downto 416) xor wordBlock(20)(511 downto 480)) rol 1;
					wordBlock(21)(511 downto 32) <= wordBlock(20)(479 downto 0);
					wordBlock(22)(31 downto 0) <= (wordBlock(21)(95 downto 64) xor wordBlock(21)(255 downto 224) xor wordBlock(21)(447 downto 416) xor wordBlock(21)(511 downto 480)) rol 1;
					wordBlock(22)(511 downto 32) <= wordBlock(21)(479 downto 0);
					wordBlock(23)(31 downto 0) <= (wordBlock(22)(95 downto 64) xor wordBlock(22)(255 downto 224) xor wordBlock(22)(447 downto 416) xor wordBlock(22)(511 downto 480)) rol 1;
					wordBlock(23)(511 downto 32) <= wordBlock(22)(479 downto 0);
					wordBlock(24)(31 downto 0) <= (wordBlock(23)(95 downto 64) xor wordBlock(23)(255 downto 224) xor wordBlock(23)(447 downto 416) xor wordBlock(23)(511 downto 480)) rol 1;
					wordBlock(24)(511 downto 32) <= wordBlock(23)(479 downto 0);
					wordBlock(25)(31 downto 0) <= (wordBlock(24)(95 downto 64) xor wordBlock(24)(255 downto 224) xor wordBlock(24)(447 downto 416) xor wordBlock(24)(511 downto 480)) rol 1;
					wordBlock(25)(511 downto 32) <= wordBlock(24)(479 downto 0);
					wordBlock(26)(31 downto 0) <= (wordBlock(25)(95 downto 64) xor wordBlock(25)(255 downto 224) xor wordBlock(25)(447 downto 416) xor wordBlock(25)(511 downto 480)) rol 1;
					wordBlock(26)(511 downto 32) <= wordBlock(25)(479 downto 0);
					wordBlock(27)(31 downto 0) <= (wordBlock(26)(95 downto 64) xor wordBlock(26)(255 downto 224) xor wordBlock(26)(447 downto 416) xor wordBlock(26)(511 downto 480)) rol 1;
					wordBlock(27)(511 downto 32) <= wordBlock(26)(479 downto 0);
					wordBlock(28)(31 downto 0) <= (wordBlock(27)(95 downto 64) xor wordBlock(27)(255 downto 224) xor wordBlock(27)(447 downto 416) xor wordBlock(27)(511 downto 480)) rol 1;
					wordBlock(28)(511 downto 32) <= wordBlock(27)(479 downto 0);
					wordBlock(29)(31 downto 0) <= (wordBlock(28)(95 downto 64) xor wordBlock(28)(255 downto 224) xor wordBlock(28)(447 downto 416) xor wordBlock(28)(511 downto 480)) rol 1;
					wordBlock(29)(511 downto 32) <= wordBlock(28)(479 downto 0);
					wordBlock(30)(31 downto 0) <= (wordBlock(29)(95 downto 64) xor wordBlock(29)(255 downto 224) xor wordBlock(29)(447 downto 416) xor wordBlock(29)(511 downto 480)) rol 1;
					wordBlock(30)(511 downto 32) <= wordBlock(29)(479 downto 0);
					wordBlock(31)(31 downto 0) <= (wordBlock(30)(95 downto 64) xor wordBlock(30)(255 downto 224) xor wordBlock(30)(447 downto 416) xor wordBlock(30)(511 downto 480)) rol 1;
					wordBlock(31)(511 downto 32) <= wordBlock(30)(479 downto 0);
					wordBlock(32)(31 downto 0) <= (wordBlock(31)(95 downto 64) xor wordBlock(31)(255 downto 224) xor wordBlock(31)(447 downto 416) xor wordBlock(31)(511 downto 480)) rol 1;
					wordBlock(32)(511 downto 32) <= wordBlock(31)(479 downto 0);
					wordBlock(33)(31 downto 0) <= (wordBlock(32)(95 downto 64) xor wordBlock(32)(255 downto 224) xor wordBlock(32)(447 downto 416) xor wordBlock(32)(511 downto 480)) rol 1;
					wordBlock(33)(511 downto 32) <= wordBlock(32)(479 downto 0);
					wordBlock(34)(31 downto 0) <= (wordBlock(33)(95 downto 64) xor wordBlock(33)(255 downto 224) xor wordBlock(33)(447 downto 416) xor wordBlock(33)(511 downto 480)) rol 1;
					wordBlock(34)(511 downto 32) <= wordBlock(33)(479 downto 0);
					wordBlock(35)(31 downto 0) <= (wordBlock(34)(95 downto 64) xor wordBlock(34)(255 downto 224) xor wordBlock(34)(447 downto 416) xor wordBlock(34)(511 downto 480)) rol 1;
					wordBlock(35)(511 downto 32) <= wordBlock(34)(479 downto 0);
					wordBlock(36)(31 downto 0) <= (wordBlock(35)(95 downto 64) xor wordBlock(35)(255 downto 224) xor wordBlock(35)(447 downto 416) xor wordBlock(35)(511 downto 480)) rol 1;
					wordBlock(36)(511 downto 32) <= wordBlock(35)(479 downto 0);
					wordBlock(37)(31 downto 0) <= (wordBlock(36)(95 downto 64) xor wordBlock(36)(255 downto 224) xor wordBlock(36)(447 downto 416) xor wordBlock(36)(511 downto 480)) rol 1;
					wordBlock(37)(511 downto 32) <= wordBlock(36)(479 downto 0);
					wordBlock(38)(31 downto 0) <= (wordBlock(37)(95 downto 64) xor wordBlock(37)(255 downto 224) xor wordBlock(37)(447 downto 416) xor wordBlock(37)(511 downto 480)) rol 1;
					wordBlock(38)(511 downto 32) <= wordBlock(37)(479 downto 0);
					wordBlock(39)(31 downto 0) <= (wordBlock(38)(95 downto 64) xor wordBlock(38)(255 downto 224) xor wordBlock(38)(447 downto 416) xor wordBlock(38)(511 downto 480)) rol 1;
					wordBlock(39)(511 downto 32) <= wordBlock(38)(479 downto 0);
					wordBlock(40)(31 downto 0) <= (wordBlock(39)(95 downto 64) xor wordBlock(39)(255 downto 224) xor wordBlock(39)(447 downto 416) xor wordBlock(39)(511 downto 480)) rol 1;
					wordBlock(40)(511 downto 32) <= wordBlock(39)(479 downto 0);
					wordBlock(41)(31 downto 0) <= (wordBlock(40)(95 downto 64) xor wordBlock(40)(255 downto 224) xor wordBlock(40)(447 downto 416) xor wordBlock(40)(511 downto 480)) rol 1;
					wordBlock(41)(511 downto 32) <= wordBlock(40)(479 downto 0);
					wordBlock(42)(31 downto 0) <= (wordBlock(41)(95 downto 64) xor wordBlock(41)(255 downto 224) xor wordBlock(41)(447 downto 416) xor wordBlock(41)(511 downto 480)) rol 1;
					wordBlock(42)(511 downto 32) <= wordBlock(41)(479 downto 0);
					wordBlock(43)(31 downto 0) <= (wordBlock(42)(95 downto 64) xor wordBlock(42)(255 downto 224) xor wordBlock(42)(447 downto 416) xor wordBlock(42)(511 downto 480)) rol 1;
					wordBlock(43)(511 downto 32) <= wordBlock(42)(479 downto 0);
					wordBlock(44)(31 downto 0) <= (wordBlock(43)(95 downto 64) xor wordBlock(43)(255 downto 224) xor wordBlock(43)(447 downto 416) xor wordBlock(43)(511 downto 480)) rol 1;
					wordBlock(44)(511 downto 32) <= wordBlock(43)(479 downto 0);
					wordBlock(45)(31 downto 0) <= (wordBlock(44)(95 downto 64) xor wordBlock(44)(255 downto 224) xor wordBlock(44)(447 downto 416) xor wordBlock(44)(511 downto 480)) rol 1;
					wordBlock(45)(511 downto 32) <= wordBlock(44)(479 downto 0);
					wordBlock(46)(31 downto 0) <= (wordBlock(45)(95 downto 64) xor wordBlock(45)(255 downto 224) xor wordBlock(45)(447 downto 416) xor wordBlock(45)(511 downto 480)) rol 1;
					wordBlock(46)(511 downto 32) <= wordBlock(45)(479 downto 0);
					wordBlock(47)(31 downto 0) <= (wordBlock(46)(95 downto 64) xor wordBlock(46)(255 downto 224) xor wordBlock(46)(447 downto 416) xor wordBlock(46)(511 downto 480)) rol 1;
					wordBlock(47)(511 downto 32) <= wordBlock(46)(479 downto 0);
					wordBlock(48)(31 downto 0) <= (wordBlock(47)(95 downto 64) xor wordBlock(47)(255 downto 224) xor wordBlock(47)(447 downto 416) xor wordBlock(47)(511 downto 480)) rol 1;
					wordBlock(48)(511 downto 32) <= wordBlock(47)(479 downto 0);
					wordBlock(49)(31 downto 0) <= (wordBlock(48)(95 downto 64) xor wordBlock(48)(255 downto 224) xor wordBlock(48)(447 downto 416) xor wordBlock(48)(511 downto 480)) rol 1;
					wordBlock(49)(511 downto 32) <= wordBlock(48)(479 downto 0);
					wordBlock(50)(31 downto 0) <= (wordBlock(49)(95 downto 64) xor wordBlock(49)(255 downto 224) xor wordBlock(49)(447 downto 416) xor wordBlock(49)(511 downto 480)) rol 1;
					wordBlock(50)(511 downto 32) <= wordBlock(49)(479 downto 0);
					wordBlock(51)(31 downto 0) <= (wordBlock(50)(95 downto 64) xor wordBlock(50)(255 downto 224) xor wordBlock(50)(447 downto 416) xor wordBlock(50)(511 downto 480)) rol 1;
					wordBlock(51)(511 downto 32) <= wordBlock(50)(479 downto 0);
					wordBlock(52)(31 downto 0) <= (wordBlock(51)(95 downto 64) xor wordBlock(51)(255 downto 224) xor wordBlock(51)(447 downto 416) xor wordBlock(51)(511 downto 480)) rol 1;
					wordBlock(52)(511 downto 32) <= wordBlock(51)(479 downto 0);
					wordBlock(53)(31 downto 0) <= (wordBlock(52)(95 downto 64) xor wordBlock(52)(255 downto 224) xor wordBlock(52)(447 downto 416) xor wordBlock(52)(511 downto 480)) rol 1;
					wordBlock(53)(511 downto 32) <= wordBlock(52)(479 downto 0);
					wordBlock(54)(31 downto 0) <= (wordBlock(53)(95 downto 64) xor wordBlock(53)(255 downto 224) xor wordBlock(53)(447 downto 416) xor wordBlock(53)(511 downto 480)) rol 1;
					wordBlock(54)(511 downto 32) <= wordBlock(53)(479 downto 0);
					wordBlock(55)(31 downto 0) <= (wordBlock(54)(95 downto 64) xor wordBlock(54)(255 downto 224) xor wordBlock(54)(447 downto 416) xor wordBlock(54)(511 downto 480)) rol 1;
					wordBlock(55)(511 downto 32) <= wordBlock(54)(479 downto 0);
					wordBlock(56)(31 downto 0) <= (wordBlock(55)(95 downto 64) xor wordBlock(55)(255 downto 224) xor wordBlock(55)(447 downto 416) xor wordBlock(55)(511 downto 480)) rol 1;
					wordBlock(56)(511 downto 32) <= wordBlock(55)(479 downto 0);
					wordBlock(57)(31 downto 0) <= (wordBlock(56)(95 downto 64) xor wordBlock(56)(255 downto 224) xor wordBlock(56)(447 downto 416) xor wordBlock(56)(511 downto 480)) rol 1;
					wordBlock(57)(511 downto 32) <= wordBlock(56)(479 downto 0);
					wordBlock(58)(31 downto 0) <= (wordBlock(57)(95 downto 64) xor wordBlock(57)(255 downto 224) xor wordBlock(57)(447 downto 416) xor wordBlock(57)(511 downto 480)) rol 1;
					wordBlock(58)(511 downto 32) <= wordBlock(57)(479 downto 0);
					wordBlock(59)(31 downto 0) <= (wordBlock(58)(95 downto 64) xor wordBlock(58)(255 downto 224) xor wordBlock(58)(447 downto 416) xor wordBlock(58)(511 downto 480)) rol 1;
					wordBlock(59)(511 downto 32) <= wordBlock(58)(479 downto 0);
					wordBlock(60)(31 downto 0) <= (wordBlock(59)(95 downto 64) xor wordBlock(59)(255 downto 224) xor wordBlock(59)(447 downto 416) xor wordBlock(59)(511 downto 480)) rol 1;
					wordBlock(60)(511 downto 32) <= wordBlock(59)(479 downto 0);
					wordBlock(61)(31 downto 0) <= (wordBlock(60)(95 downto 64) xor wordBlock(60)(255 downto 224) xor wordBlock(60)(447 downto 416) xor wordBlock(60)(511 downto 480)) rol 1;
					wordBlock(61)(511 downto 32) <= wordBlock(60)(479 downto 0);
					wordBlock(62)(31 downto 0) <= (wordBlock(61)(95 downto 64) xor wordBlock(61)(255 downto 224) xor wordBlock(61)(447 downto 416) xor wordBlock(61)(511 downto 480)) rol 1;
					wordBlock(62)(511 downto 32) <= wordBlock(61)(479 downto 0);
					wordBlock(63)(31 downto 0) <= (wordBlock(62)(95 downto 64) xor wordBlock(62)(255 downto 224) xor wordBlock(62)(447 downto 416) xor wordBlock(62)(511 downto 480)) rol 1;
					wordBlock(63)(511 downto 32) <= wordBlock(62)(479 downto 0);
					wordBlock(64) <= wordBlock(63);
					wordBlock(65) <= wordBlock(64);
					wordBlock(66) <= wordBlock(65);
					wordBlock(67) <= wordBlock(66);
					wordBlock(68) <= wordBlock(67);
					wordBlock(69) <= wordBlock(68);
					wordBlock(70) <= wordBlock(69);
					wordBlock(71) <= wordBlock(70);
					wordBlock(72) <= wordBlock(71);
					wordBlock(73) <= wordBlock(72);
					wordBlock(74) <= wordBlock(73);
					wordBlock(75) <= wordBlock(74);
					wordBlock(76) <= wordBlock(75);
					wordBlock(77) <= wordBlock(76);
					wordBlock(78) <= wordBlock(77);
					
					--The calculations for temp and F is calculated directly in the A calculations
					A(0) <= (h0 rol 5) + ((h1 and h2) or ((not h1) and h3)) + h4 + K0 + dataBlock(511 downto 480);
					A(1) <= (A(0) rol 5) + ((B(0) and C(0)) or ((not B(0)) and D(0))) + E(0) + K0 + wordBlock(0)(511 downto 480);
					A(2) <= (A(1) rol 5) + ((B(1) and C(1)) or ((not B(1)) and D(1))) + E(1) + K0 + wordBlock(1)(511 downto 480);
					A(3) <= (A(2) rol 5) + ((B(2) and C(2)) or ((not B(2)) and D(2))) + E(2) + K0 + wordBlock(2)(511 downto 480);
					A(4) <= (A(3) rol 5) + ((B(3) and C(3)) or ((not B(3)) and D(3))) + E(3) + K0 + wordBlock(3)(511 downto 480);
					A(5) <= (A(4) rol 5) + ((B(4) and C(4)) or ((not B(4)) and D(4))) + E(4) + K0 + wordBlock(4)(511 downto 480);
					A(6) <= (A(5) rol 5) + ((B(5) and C(5)) or ((not B(5)) and D(5))) + E(5) + K0 + wordBlock(5)(511 downto 480);
					A(7) <= (A(6) rol 5) + ((B(6) and C(6)) or ((not B(6)) and D(6))) + E(6) + K0 + wordBlock(6)(511 downto 480);
					A(8) <= (A(7) rol 5) + ((B(7) and C(7)) or ((not B(7)) and D(7))) + E(7) + K0 + wordBlock(7)(511 downto 480);
					A(9) <= (A(8) rol 5) + ((B(8) and C(8)) or ((not B(8)) and D(8))) + E(8) + K0 + wordBlock(8)(511 downto 480);
					A(10) <= (A(9) rol 5) + ((B(9) and C(9)) or ((not B(9)) and D(9))) + E(9) + K0 + wordBlock(9)(511 downto 480);
					A(11) <= (A(10) rol 5) + ((B(10) and C(10)) or ((not B(10)) and D(10))) + E(10) + K0 + wordBlock(10)(511 downto 480);
					A(12) <= (A(11) rol 5) + ((B(11) and C(11)) or ((not B(11)) and D(11))) + E(11) + K0 + wordBlock(11)(511 downto 480);
					A(13) <= (A(12) rol 5) + ((B(12) and C(12)) or ((not B(12)) and D(12))) + E(12) + K0 + wordBlock(12)(511 downto 480);
					A(14) <= (A(13) rol 5) + ((B(13) and C(13)) or ((not B(13)) and D(13))) + E(13) + K0 + wordBlock(13)(511 downto 480);
					A(15) <= (A(14) rol 5) + ((B(14) and C(14)) or ((not B(14)) and D(14))) + E(14) + K0 + wordBlock(14)(511 downto 480);
					A(16) <= (A(15) rol 5) + ((B(15) and C(15)) or ((not B(15)) and D(15))) + E(15) + K0 + wordBlock(15)(511 downto 480);
					A(17) <= (A(16) rol 5) + ((B(16) and C(16)) or ((not B(16)) and D(16))) + E(16) + K0 + wordBlock(16)(511 downto 480);
					A(18) <= (A(17) rol 5) + ((B(17) and C(17)) or ((not B(17)) and D(17))) + E(17) + K0 + wordBlock(17)(511 downto 480);
					A(19) <= (A(18) rol 5) + ((B(18) and C(18)) or ((not B(18)) and D(18))) + E(18) + K0 + wordBlock(18)(511 downto 480);
					A(20) <= (A(19) rol 5) + (B(19) xor C(19) xor D(19)) + E(19) + K1 + wordBlock(19)(511 downto 480);
					A(21) <= (A(20) rol 5) + (B(20) xor C(20) xor D(20)) + E(20) + K1 + wordBlock(20)(511 downto 480);
					A(22) <= (A(21) rol 5) + (B(21) xor C(21) xor D(21)) + E(21) + K1 + wordBlock(21)(511 downto 480);
					A(23) <= (A(22) rol 5) + (B(22) xor C(22) xor D(22)) + E(22) + K1 + wordBlock(22)(511 downto 480);
					A(24) <= (A(23) rol 5) + (B(23) xor C(23) xor D(23)) + E(23) + K1 + wordBlock(23)(511 downto 480);
					A(25) <= (A(24) rol 5) + (B(24) xor C(24) xor D(24)) + E(24) + K1 + wordBlock(24)(511 downto 480);
					A(26) <= (A(25) rol 5) + (B(25) xor C(25) xor D(25)) + E(25) + K1 + wordBlock(25)(511 downto 480);
					A(27) <= (A(26) rol 5) + (B(26) xor C(26) xor D(26)) + E(26) + K1 + wordBlock(26)(511 downto 480);
					A(28) <= (A(27) rol 5) + (B(27) xor C(27) xor D(27)) + E(27) + K1 + wordBlock(27)(511 downto 480);
					A(29) <= (A(28) rol 5) + (B(28) xor C(28) xor D(28)) + E(28) + K1 + wordBlock(28)(511 downto 480);
					A(30) <= (A(29) rol 5) + (B(29) xor C(29) xor D(29)) + E(29) + K1 + wordBlock(29)(511 downto 480);
					A(31) <= (A(30) rol 5) + (B(30) xor C(30) xor D(30)) + E(30) + K1 + wordBlock(30)(511 downto 480);
					A(32) <= (A(31) rol 5) + (B(31) xor C(31) xor D(31)) + E(31) + K1 + wordBlock(31)(511 downto 480);
					A(33) <= (A(32) rol 5) + (B(32) xor C(32) xor D(32)) + E(32) + K1 + wordBlock(32)(511 downto 480);
					A(34) <= (A(33) rol 5) + (B(33) xor C(33) xor D(33)) + E(33) + K1 + wordBlock(33)(511 downto 480);
					A(35) <= (A(34) rol 5) + (B(34) xor C(34) xor D(34)) + E(34) + K1 + wordBlock(34)(511 downto 480);
					A(36) <= (A(35) rol 5) + (B(35) xor C(35) xor D(35)) + E(35) + K1 + wordBlock(35)(511 downto 480);
					A(37) <= (A(36) rol 5) + (B(36) xor C(36) xor D(36)) + E(36) + K1 + wordBlock(36)(511 downto 480);
					A(38) <= (A(37) rol 5) + (B(37) xor C(37) xor D(37)) + E(37) + K1 + wordBlock(37)(511 downto 480);
					A(39) <= (A(38) rol 5) + (B(38) xor C(38) xor D(38)) + E(38) + K1 + wordBlock(38)(511 downto 480);
					A(40) <= (A(39) rol 5) + ((B(39) and C(39)) or (B(39) and D(39)) or (C(39) and D(39))) + E(39) + K2 + wordBlock(39)(511 downto 480);
					A(41) <= (A(40) rol 5) + ((B(40) and C(40)) or (B(40) and D(40)) or (C(40) and D(40))) + E(40) + K2 + wordBlock(40)(511 downto 480);
					A(42) <= (A(41) rol 5) + ((B(41) and C(41)) or (B(41) and D(41)) or (C(41) and D(41))) + E(41) + K2 + wordBlock(41)(511 downto 480);
					A(43) <= (A(42) rol 5) + ((B(42) and C(42)) or (B(42) and D(42)) or (C(42) and D(42))) + E(42) + K2 + wordBlock(42)(511 downto 480);
					A(44) <= (A(43) rol 5) + ((B(43) and C(43)) or (B(43) and D(43)) or (C(43) and D(43))) + E(43) + K2 + wordBlock(43)(511 downto 480);
					A(45) <= (A(44) rol 5) + ((B(44) and C(44)) or (B(44) and D(44)) or (C(44) and D(44))) + E(44) + K2 + wordBlock(44)(511 downto 480);
					A(46) <= (A(45) rol 5) + ((B(45) and C(45)) or (B(45) and D(45)) or (C(45) and D(45))) + E(45) + K2 + wordBlock(45)(511 downto 480);
					A(47) <= (A(46) rol 5) + ((B(46) and C(46)) or (B(46) and D(46)) or (C(46) and D(46))) + E(46) + K2 + wordBlock(46)(511 downto 480);
					A(48) <= (A(47) rol 5) + ((B(47) and C(47)) or (B(47) and D(47)) or (C(47) and D(47))) + E(47) + K2 + wordBlock(47)(511 downto 480);
					A(49) <= (A(48) rol 5) + ((B(48) and C(48)) or (B(48) and D(48)) or (C(48) and D(48))) + E(48) + K2 + wordBlock(48)(511 downto 480);
					A(50) <= (A(49) rol 5) + ((B(49) and C(49)) or (B(49) and D(49)) or (C(49) and D(49))) + E(49) + K2 + wordBlock(49)(511 downto 480);
					A(51) <= (A(50) rol 5) + ((B(50) and C(50)) or (B(50) and D(50)) or (C(50) and D(50))) + E(50) + K2 + wordBlock(50)(511 downto 480);
					A(52) <= (A(51) rol 5) + ((B(51) and C(51)) or (B(51) and D(51)) or (C(51) and D(51))) + E(51) + K2 + wordBlock(51)(511 downto 480);
					A(53) <= (A(52) rol 5) + ((B(52) and C(52)) or (B(52) and D(52)) or (C(52) and D(52))) + E(52) + K2 + wordBlock(52)(511 downto 480);
					A(54) <= (A(53) rol 5) + ((B(53) and C(53)) or (B(53) and D(53)) or (C(53) and D(53))) + E(53) + K2 + wordBlock(53)(511 downto 480);
					A(55) <= (A(54) rol 5) + ((B(54) and C(54)) or (B(54) and D(54)) or (C(54) and D(54))) + E(54) + K2 + wordBlock(54)(511 downto 480);
					A(56) <= (A(55) rol 5) + ((B(55) and C(55)) or (B(55) and D(55)) or (C(55) and D(55))) + E(55) + K2 + wordBlock(55)(511 downto 480);
					A(57) <= (A(56) rol 5) + ((B(56) and C(56)) or (B(56) and D(56)) or (C(56) and D(56))) + E(56) + K2 + wordBlock(56)(511 downto 480);
					A(58) <= (A(57) rol 5) + ((B(57) and C(57)) or (B(57) and D(57)) or (C(57) and D(57))) + E(57) + K2 + wordBlock(57)(511 downto 480);
					A(59) <= (A(58) rol 5) + ((B(58) and C(58)) or (B(58) and D(58)) or (C(58) and D(58))) + E(58) + K2 + wordBlock(58)(511 downto 480);
					A(60) <= (A(59) rol 5) + (B(59) xor C(59) xor D(59)) + E(59) + K3 + wordBlock(59)(511 downto 480);
					A(61) <= (A(60) rol 5) + (B(60) xor C(60) xor D(60)) + E(60) + K3 + wordBlock(60)(511 downto 480);
					A(62) <= (A(61) rol 5) + (B(61) xor C(61) xor D(61)) + E(61) + K3 + wordBlock(61)(511 downto 480);
					A(63) <= (A(62) rol 5) + (B(62) xor C(62) xor D(62)) + E(62) + K3 + wordBlock(62)(511 downto 480);
					A(64) <= (A(63) rol 5) + (B(63) xor C(63) xor D(63)) + E(63) + K3 + wordBlock(63)(511 downto 480);
					A(65) <= (A(64) rol 5) + (B(64) xor C(64) xor D(64)) + E(64) + K3 + wordBlock(64)(479 downto 448);
					A(66) <= (A(65) rol 5) + (B(65) xor C(65) xor D(65)) + E(65) + K3 + wordBlock(65)(447 downto 416);
					A(67) <= (A(66) rol 5) + (B(66) xor C(66) xor D(66)) + E(66) + K3 + wordBlock(66)(415 downto 384);
					A(68) <= (A(67) rol 5) + (B(67) xor C(67) xor D(67)) + E(67) + K3 + wordBlock(67)(383 downto 352);
					A(69) <= (A(68) rol 5) + (B(68) xor C(68) xor D(68)) + E(68) + K3 + wordBlock(68)(351 downto 320);
					A(70) <= (A(69) rol 5) + (B(69) xor C(69) xor D(69)) + E(69) + K3 + wordBlock(69)(319 downto 288);
					A(71) <= (A(70) rol 5) + (B(70) xor C(70) xor D(70)) + E(70) + K3 + wordBlock(70)(287 downto 256);
					A(72) <= (A(71) rol 5) + (B(71) xor C(71) xor D(71)) + E(71) + K3 + wordBlock(71)(255 downto 224);
					A(73) <= (A(72) rol 5) + (B(72) xor C(72) xor D(72)) + E(72) + K3 + wordBlock(72)(223 downto 192);
					A(74) <= (A(73) rol 5) + (B(73) xor C(73) xor D(73)) + E(73) + K3 + wordBlock(73)(191 downto 160);
					A(75) <= (A(74) rol 5) + (B(74) xor C(74) xor D(74)) + E(74) + K3 + wordBlock(74)(159 downto 128);
					A(76) <= (A(75) rol 5) + (B(75) xor C(75) xor D(75)) + E(75) + K3 + wordBlock(75)(127 downto 96);
					A(77) <= (A(76) rol 5) + (B(76) xor C(76) xor D(76)) + E(76) + K3 + wordBlock(76)(95 downto 64);
					A(78) <= (A(77) rol 5) + (B(77) xor C(77) xor D(77)) + E(77) + K3 + wordBlock(77)(63 downto 32);
					A(79) <= (A(78) rol 5) + (B(78) xor C(78) xor D(78)) + E(78) + K3 + wordBlock(78)(31 downto 0);
				
					--The A variable is the B variable for the next step. 
					B(0) <= h0;
					B(1) <= A(0); 
					B(2) <= A(1);
					B(3) <= A(2);
					B(4) <= A(3);
					B(5) <= A(4);
					B(6) <= A(5);
					B(7) <= A(6);
					B(8) <= A(7);
					B(9) <= A(8);
					B(10) <= A(9);
					B(11) <= A(10); 
					B(12) <= A(11);
					B(13) <= A(12);
					B(14) <= A(13);
					B(15) <= A(14);
					B(16) <= A(15);
					B(17) <= A(16);
					B(18) <= A(17);
					B(19) <= A(18);
					B(20) <= A(19);
					B(21) <= A(20); 
					B(22) <= A(21);
					B(23) <= A(22);
					B(24) <= A(23);
					B(25) <= A(24);
					B(26) <= A(25);
					B(27) <= A(26);
					B(28) <= A(27);
					B(29) <= A(28);
					B(30) <= A(29);
					B(31) <= A(30); 
					B(32) <= A(31);
					B(33) <= A(32);
					B(34) <= A(33);
					B(35) <= A(34);
					B(36) <= A(35);
					B(37) <= A(36);
					B(38) <= A(37);
					B(39) <= A(38);
					B(40) <= A(39);
					B(41) <= A(40); 
					B(42) <= A(41);
					B(43) <= A(42);
					B(44) <= A(43);
					B(45) <= A(44);
					B(46) <= A(45);
					B(47) <= A(46);
					B(48) <= A(47);
					B(49) <= A(48);
					B(50) <= A(49);
					B(51) <= A(50); 
					B(52) <= A(51);
					B(53) <= A(52);
					B(54) <= A(53);
					B(55) <= A(54);
					B(56) <= A(55);
					B(57) <= A(56);
					B(58) <= A(57);
					B(59) <= A(58);
					B(60) <= A(59);
					B(61) <= A(60); 
					B(62) <= A(61);
					B(63) <= A(62);
					B(64) <= A(63);
					B(65) <= A(64);
					B(66) <= A(65);
					B(67) <= A(66);
					B(68) <= A(67);
					B(69) <= A(68);
					B(70) <= A(69);
					B(71) <= A(70); 
					B(72) <= A(71);
					B(73) <= A(72);
					B(74) <= A(73);
					B(75) <= A(74);
					B(76) <= A(75);
					B(77) <= A(76);
					B(78) <= A(77);
					B(79) <= A(78);
					
					--A 30 times left rotated B variable is the C variable for the next step.
					C(0) <= h1 rol 30;
					C(1) <= B(0) rol 30;
					C(2) <= B(1) rol 30;
					C(3) <= B(2) rol 30;
					C(4) <= B(3) rol 30;
					C(5) <= B(4) rol 30;
					C(6) <= B(5) rol 30;
					C(7) <= B(6) rol 30;
					C(8) <= B(7) rol 30;
					C(9) <= B(8) rol 30;
					C(10) <= B(9) rol 30;
					C(11) <= B(10) rol 30;
					C(12) <= B(11) rol 30;
					C(13) <= B(12) rol 30;
					C(14) <= B(13) rol 30;
					C(15) <= B(14) rol 30;
					C(16) <= B(15) rol 30;
					C(17) <= B(16) rol 30;
					C(18) <= B(17) rol 30;
					C(19) <= B(18) rol 30;
					C(20) <= B(19) rol 30;
					C(21) <= B(20) rol 30;
					C(22) <= B(21) rol 30;
					C(23) <= B(22) rol 30;
					C(24) <= B(23) rol 30;
					C(25) <= B(24) rol 30;
					C(26) <= B(25) rol 30;
					C(27) <= B(26) rol 30;
					C(28) <= B(27) rol 30;
					C(29) <= B(28) rol 30;
					C(30) <= B(29) rol 30;
					C(31) <= B(30) rol 30;
					C(32) <= B(31) rol 30;
					C(33) <= B(32) rol 30;
					C(34) <= B(33) rol 30;
					C(35) <= B(34) rol 30;
					C(36) <= B(35) rol 30;
					C(37) <= B(36) rol 30;
					C(38) <= B(37) rol 30;
					C(39) <= B(38) rol 30;
					C(40) <= B(39) rol 30;
					C(41) <= B(40) rol 30;
					C(42) <= B(41) rol 30;
					C(43) <= B(42) rol 30;
					C(44) <= B(43) rol 30;
					C(45) <= B(44) rol 30;
					C(46) <= B(45) rol 30;
					C(47) <= B(46) rol 30;
					C(48) <= B(47) rol 30;
					C(49) <= B(48) rol 30;
					C(50) <= B(49) rol 30;
					C(51) <= B(50) rol 30;
					C(52) <= B(51) rol 30;
					C(53) <= B(52) rol 30;
					C(54) <= B(53) rol 30;
					C(55) <= B(54) rol 30;
					C(56) <= B(55) rol 30;
					C(57) <= B(56) rol 30;
					C(58) <= B(57) rol 30;
					C(59) <= B(58) rol 30;
					C(60) <= B(59) rol 30;
					C(61) <= B(60) rol 30;
					C(62) <= B(61) rol 30;
					C(63) <= B(62) rol 30;
					C(64) <= B(63) rol 30;
					C(65) <= B(64) rol 30;
					C(66) <= B(65) rol 30;
					C(67) <= B(66) rol 30;
					C(68) <= B(67) rol 30;
					C(69) <= B(68) rol 30;
					C(70) <= B(69) rol 30;
					C(71) <= B(70) rol 30;
					C(72) <= B(71) rol 30;
					C(73) <= B(72) rol 30;
					C(74) <= B(73) rol 30;
					C(75) <= B(74) rol 30;
					C(76) <= B(75) rol 30;
					C(77) <= B(76) rol 30;
					C(78) <= B(77) rol 30;
					C(79) <= B(78) rol 30;
					
					--The C variable is the D variable for the next step.
					D(0) <= h2;
					D(1) <= C(0);
					D(2) <= C(1);
					D(3) <= C(2);
					D(4) <= C(3);
					D(5) <= C(4);
					D(6) <= C(5);
					D(7) <= C(6);
					D(8) <= C(7);
					D(9) <= C(8);
					D(10) <= C(9);
					D(11) <= C(10);
					D(12) <= C(11);
					D(13) <= C(12);
					D(14) <= C(13);
					D(15) <= C(14);
					D(16) <= C(15);
					D(17) <= C(16);
					D(18) <= C(17);
					D(19) <= C(18);
					D(20) <= C(19);
					D(21) <= C(20);
					D(22) <= C(21);
					D(23) <= C(22);
					D(24) <= C(23);
					D(25) <= C(24);
					D(26) <= C(25);
					D(27) <= C(26);
					D(28) <= C(27);
					D(29) <= C(28);
					D(30) <= C(29);
					D(31) <= C(30);
					D(32) <= C(31);
					D(33) <= C(32);
					D(34) <= C(33);
					D(35) <= C(34);
					D(36) <= C(35);
					D(37) <= C(36);
					D(38) <= C(37);
					D(39) <= C(38);
					D(40) <= C(39);
					D(41) <= C(40);
					D(42) <= C(41);
					D(43) <= C(42);
					D(44) <= C(43);
					D(45) <= C(44);
					D(46) <= C(45);
					D(47) <= C(46);
					D(48) <= C(47);
					D(49) <= C(48);
					D(50) <= C(49);
					D(51) <= C(50);
					D(52) <= C(51);
					D(53) <= C(52);
					D(54) <= C(53);
					D(55) <= C(54);
					D(56) <= C(55);
					D(57) <= C(56);
					D(58) <= C(57);
					D(59) <= C(58);
					D(60) <= C(59);
					D(61) <= C(60);
					D(62) <= C(61);
					D(63) <= C(62);
					D(64) <= C(63);
					D(65) <= C(64);
					D(66) <= C(65);
					D(67) <= C(66);
					D(68) <= C(67);
					D(69) <= C(68);
					D(70) <= C(69);
					D(71) <= C(70);
					D(72) <= C(71);
					D(73) <= C(72);
					D(74) <= C(73);
					D(75) <= C(74);
					D(76) <= C(75);
					D(77) <= C(76);
					D(78) <= C(77);
					D(79) <= C(78);
					
					--The D variable is the E variable for the next step.
					E(0) <= h3;
					E(1) <= D(0);
					E(2) <= D(1);
					E(3) <= D(2);
					E(4) <= D(3);
					E(5) <= D(4);
					E(6) <= D(5);
					E(7) <= D(6);
					E(8) <= D(7);
					E(9) <= D(8);
					E(10) <= D(9);
					E(11) <= D(10);
					E(12) <= D(11);
					E(13) <= D(12);
					E(14) <= D(13);
					E(15) <= D(14);
					E(16) <= D(15);
					E(17) <= D(16);
					E(18) <= D(17);
					E(19) <= D(18);
					E(20) <= D(19);
					E(21) <= D(20);
					E(22) <= D(21);
					E(23) <= D(22);
					E(24) <= D(23);
					E(25) <= D(24);
					E(26) <= D(25);
					E(27) <= D(26);
					E(28) <= D(27);
					E(29) <= D(28);
					E(30) <= D(29);
					E(31) <= D(30);
					E(32) <= D(31);
					E(33) <= D(32);
					E(34) <= D(33);
					E(35) <= D(34);
					E(36) <= D(35);
					E(37) <= D(36);
					E(38) <= D(37);
					E(39) <= D(38);
					E(40) <= D(39);
					E(41) <= D(40);
					E(42) <= D(41);
					E(43) <= D(42);
					E(44) <= D(43);
					E(45) <= D(44);
					E(46) <= D(45);
					E(47) <= D(46);
					E(48) <= D(47);
					E(49) <= D(48);
					E(50) <= D(49);
					E(51) <= D(50);
					E(52) <= D(51);
					E(53) <= D(52);
					E(54) <= D(53);
					E(55) <= D(54);
					E(56) <= D(55);
					E(57) <= D(56);
					E(58) <= D(57);
					E(59) <= D(58);
					E(60) <= D(59);
					E(61) <= D(60);
					E(62) <= D(61);
					E(63) <= D(62);
					E(64) <= D(63);
					E(65) <= D(64);
					E(66) <= D(65);
					E(67) <= D(66);
					E(68) <= D(67);
					E(69) <= D(68);
					E(70) <= D(69);
					E(71) <= D(70);
					E(72) <= D(71);
					E(73) <= D(72);
					E(74) <= D(73);
					E(75) <= D(74);
					E(76) <= D(75);
					E(77) <= D(76);
					E(78) <= D(77);
					E(79) <= D(78);
					
					
					dataTest <= dataSignal(79);	
					--The hash is gathered after the calculations.
					hashTest (159 downto 128) <= (A(79) + h0);
					hashTest (127 downto 96) <= (B(79) + h1);
					hashTest (95 downto 64) <= (C(79) + h2);
					hashTest (63 downto 32) <= (D(79) + h3);
					hashTest (31 downto 0) <= (E(79) + h4);
					
					--If it is the correct hash then the connected dataBlock is sent back to the HPS
					if (hash = hashTest)then
						dataSend <= dataTest;
						state <= conclude;
					end if;
				
				when conclude =>
					if (to_integer(unsigned(sndOutCount)) < 15)then
						state <= send;
					end if;
				when send =>
					--The sending of the 512-bit data block
					if (to_integer(unsigned(sndOutCount)) < 15) then
						word <= std_logic_vector(dataSend((to_integer(unsigned(sndOutCount)) * 32) + 31 downto (to_integer(unsigned(sndOutCount)) * 32)));
						sndInCount <= sndOutCount;
					else 
						word <= std_logic_vector(dataSend((to_integer(unsigned(sndOutCount)) * 32) + 31 downto (to_integer(unsigned(sndOutCount)) * 32)));
						sndInCount <= sndOutCount;
						state <= sendRounds;
					end if;
				when sendRounds =>
				--The rounds are used to calculate how much time the program used.
					if (to_integer(unsigned(sndOutCount)) < 1) then
						word <= std_logic_vector(rounds((to_integer(unsigned(sndOutCount)) * 32) + 31 downto (to_integer(unsigned(sndOutCount)) * 32)));
						sndInCount <= sndOutCount;
					elsif (to_integer(unsigned(sndOutCount)) < 2) then
						word <= std_logic_vector(rounds((to_integer(unsigned(sndOutCount)) * 32) + 31 downto (to_integer(unsigned(sndOutCount)) * 32)));
						sndInCount <= sndOutCount;
						state <= start;
					end if;
				when others =>
					state <= start;
			end case;		
		end if;
	end process;
end main;