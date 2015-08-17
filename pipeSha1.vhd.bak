library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.b7seg.all;

entity scSha1 is
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
end scSha1;

architecture main of scSha1 is
	
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
	
	signal hps_h2f_rst: std_logic;
	
	signal hash : unsigned(159 downto 0) := (others => '0');
	
	--Konstanter fra sha-1 pseudokode
	constant h0 : unsigned(31 downto 0) := x"67452301";
	constant h1 : unsigned(31 downto 0) := x"EFCDAB89";
	constant h2 : unsigned(31 downto 0) := x"98BADCFE";
	constant h3 : unsigned(31 downto 0) := x"10325476";
	constant h4 : unsigned(31 downto 0) := x"C3D2E1F0";
	
	
	--Datablokken deles opp i "ord" på 32 bit
	subtype word_type is unsigned(31 downto 0);
	--Ordene plasseres i en array og skaleres opp til 80 ord
	type wordArray is array(79 downto 0) of word_type;
	--Signal ut fra ordene, initielt settes alle ord til 0
	signal wordSignal : wordArray := (others=> (others => '0'));
	
	type state_type is (start, newHash, checkHash, buildBlock, part, fill, mainLoop, collectHash, finished, newValue, checkLength, conclude, send);
	signal state : state_type := start;
		
	signal hash_in: std_logic_vector (31 downto 0):= (others => '0');	
	signal word: std_logic_vector (31 downto 0) := (others => '0');
	
	signal sndInCount: std_logic_vector (3 downto 0):= (others => '0');
	signal sndOutCount: std_logic_vector (3 downto 0):= (others => '0');
	
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
	
	variable sndCount: integer range 0 to 16 := 0;
	variable dataBlock : unsigned(511 downto 0) := (others => '0');
	variable dataLength : integer range 0 to 447 := 0;
	variable preData : unsigned (446 downto 0) := (others => '0');
	variable hashTest: unsigned (159 downto 0);
	
	
		--Variablene som brukes i hoveddelen, de starter med konstantene fra pseudokoden
		variable A: unsigned(31 downto 0) := h0;
		variable B: unsigned(31 downto 0) := h1;
		variable C: unsigned(31 downto 0) := h2;
		variable D: unsigned(31 downto 0) := h3;
		variable E: unsigned(31 downto 0) := h4;
		--I tillegg kommer de variablene som blir brukt inne i if setningene f og k. Blir også brukt en temp variabel.
		variable F: unsigned(31 downto 0) := (others => '0');
		variable K: unsigned(31 downto 0) := (others => '0');
		variable temp: unsigned(31 downto 0) := (others => '0');
	
		variable countWords: integer range 16 to 80 := 16;
		variable mainCount: integer range 0 to 80 := 0;
		--variable loopCount: integer range 0 to 5 := 0;
		--variable nxtLoop: integer range 0 to 1 := 1;
	begin
		if(rising_edge(clock_50))then
			case state is
				when start =>
					sndInCount <= std_logic_vector(to_unsigned(15, 4));
					state <= newHash;
				when newHash =>
					if (to_integer(unsigned(sndOutCount)) > 12)then
						null;
					elsif(to_integer(unsigned(sndOutCount)) > 4)then
						sndInCount <= sndOutCount;
						state <= checkHash;
					else
						if (to_integer(unsigned(sndOutCount)) < 5)then
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
							sndCount := sndCount +1;
							if (sndCount = 16)then
								hash((to_integer(unsigned(sndOutCount)) * 32) + 31 downto (to_integer(unsigned(sndOutCount)) * 32)) <= unsigned(hash_in);						
								sndInCount <= sndOutCount;
								sndCount := 0;
							end if;
						end if;
					end if;
				when checkHash =>
					if (to_integer(unsigned(sndOutCount)) < 5) then
						word <= std_logic_vector(hash((to_integer(unsigned(sndOutCount)) * 32) + 31 downto (to_integer(unsigned(sndOutCount)) * 32)));
						sndInCount <= sndOutCount;
					elsif(to_integer(unsigned(sndOutCount)) < 14)then
						null;
					elsif(to_integer(unsigned(sndOutCount)) < 15)then
						state <= start;
					else
						state <= buildBlock;
					end if;
					
				when buildBlock =>
					if (dataLength = 0) then 
						dataBlock(511 downto 508) := x"8";
					else
						dataBlock(511 downto (512 - dataLength)) := preData((dataLength - 1) downto 0);
						dataBlock((511 - dataLength) downto (508 - dataLength)) := x"8";
						dataBlock(63 downto 0) := to_unsigned(dataLength, 64);
					end if;
					state <= part;
				
				when part =>
					--Fills the wordSignal with 32 bit words from the dataBlock
						wordSignal(0) <= dataBlock(511 downto 480);
						wordSignal(1)<= dataBlock(479 downto 448);
						wordSignal(2) <= dataBlock(447 downto 416);
						wordSignal(3) <= dataBlock(415 downto 384);
						wordSignal(4) <= dataBlock(383 downto 352);
						wordSignal(5) <= dataBlock(351 downto 320);
						wordSignal(6) <= dataBlock(319 downto 288);
						wordSignal(7) <= dataBlock(287 downto 256);
						wordSignal(8) <= dataBlock(255 downto 224);
						wordSignal(9) <= dataBlock(223 downto 192);
						wordSignal(10) <= dataBlock(191 downto 160);
						wordSignal(11) <= dataBlock(159 downto 128);
						wordSignal(12) <= dataBlock(127 downto 96);
						wordSignal(13) <= dataBlock(95 downto 64);
						wordSignal(14) <= dataBlock(63 downto 32);
						wordSignal(15) <= dataBlock(31 downto 0);
						
						state <= mainLoop;
				
				when fill =>
					state <= mainLoop;
				when mainLoop =>
				
					if(countWords<80)then
						wordSignal(countWords) <= (wordSignal(countWords-3) xor wordSignal(countWords-8) xor wordSignal(countWords-14) xor wordSignal(countWords-16)) rol 1;
						countWords := countWords + 1;
					end if;
				
					if(mainCount >= 0 and mainCount <= 19)then
							F := (B and C) or ((not B) and D);
							K := x"5A827999";
							
							temp := (A rol 5) + F + E + K + wordSignal(mainCount);
							
							E := D;
							D := C;
							C := B rol 30;
							B := A;
							A := temp;
							
							mainCount := mainCount + 1;
							
						elsif(mainCount >= 20 and mainCount <= 39)then
							F := B xor C xor D;
							K := x"6ED9EBA1";
							
							temp := (A rol 5) + F + E + K + wordSignal(mainCount);
							
							E := D;
							D := C;
							C := B rol 30;
							B := A;
							A := temp;
							
							mainCount := mainCount + 1;
							
							elsif(mainCount >= 40 and mainCount <= 59)then
							F := (B and C) or (B and D) or (C and D);
							K := x"8F1BBCDC";
							
							temp := (A rol 5) + F + E + K + wordSignal(mainCount);
							
							E := D;
							D := C;
							C := B rol 30;
							B := A;
							A := temp;
							
							mainCount := mainCount + 1;
							
						elsif(mainCount >= 60 and mainCount <= 79)then
							F := B xor C xor D;
							K := x"CA62C1D6";
						
							temp := (A rol 5) + F + E + K + wordSignal(mainCount);
							
							E := D;
							D := C;
							C := B rol 30;
							B := A;
							A := temp;
							
							mainCount := mainCount + 1;
							
						else
							state <= collectHash;
						end if;
						
				when collectHash =>
					--samle til 160 bit
					hashTest (159 downto 128) := (A + h0);
					hashTest (127 downto 96) := (B + h1);
					hashTest (95 downto 64) := (C + h2);
					hashTest (63 downto 32) := (D + h3);
					hashTest (31 downto 0) := (E + h4);
					state <= finished;
				
				when finished =>
					A := h0;
					B := h1;
					C := h2;
					D := h3;
					E := h4;
					F := (others => '0');
					K := (others => '0');
					temp := (others => '0');
				
				--	loopCount := 0;
					countWords := 16;
					mainCount := 0;
					if (hashTest = hash)then
						state <= conclude;
					else 
						state <= newValue;
					end if;
				when newValue =>
					preData := preData + x"1";
					state <= checkLength;
				when checkLength =>
					if(to_integer(preData) < 2**dataLength)then
						state <= buildBlock;
					else
						dataLength := dataLength + 8;
						preData := (others => '0');
						state <= buildBlock;
					end if;
				
				when conclude =>
					if (to_integer(unsigned(sndOutCount)) < 15)then
						state <= send;
					end if;
				when send =>
					if (to_integer(unsigned(sndOutCount)) < 15) then
						word <= std_logic_vector(dataBlock((to_integer(unsigned(sndOutCount)) * 32) + 31 downto (to_integer(unsigned(sndOutCount)) * 32)));
						sndInCount <= sndOutCount;
					else 
						word <= std_logic_vector(dataBlock((to_integer(unsigned(sndOutCount)) * 32) + 31 downto (to_integer(unsigned(sndOutCount)) * 32)));
						sndInCount <= sndOutCount;
						state <= start;
					end if;
				when others =>
					state <= start;
			end case;		
		end if;
	end process;
end main;