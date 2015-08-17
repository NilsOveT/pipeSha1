library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_pipeSha1 is
end;

architecture testbench of tb_pipeSha1 is
	
	component pipeSha1 is
		port (
			clock_50: in std_logic;
			HEX0: out std_logic_vector(6 downto 0);
			HEX1: out std_logic_vector(6 downto 0);
			HEX2: out std_logic_vector(6 downto 0);
			HEX3: out std_logic_vector(6 downto 0);
			HEX4: out std_logic_vector(6 downto 0);
			HEX5: out std_logic_vector(6 downto 0));
	end component pipeSha1;
	
	signal clock_50: std_logic;
	signal HEX0: std_logic_vector(6 downto 0);
	signal HEX1: std_logic_vector(6 downto 0);
	signal HEX2: std_logic_vector(6 downto 0);
	signal HEX3: std_logic_vector(6 downto 0);
	signal HEX4: std_logic_vector(6 downto 0);
	signal HEX5: std_logic_vector(6 downto 0);
	constant clock_period : time := 1ns;
	

begin

	UUT: pipeSha1
		port map(
		clock_50 => clock_50,
		HEX0 => HEX0,
		HEX1 => HEX1,
		HEX2 => HEX2,
		HEX3 => HEX3,
		HEX4 => HEX4,
		HEX5 => HEX5);
		
clock_process: process
begin
	clock_50<= '0';
	wait for clock_period/2;
	clock_50<= '1';
	wait for clock_period/2;
end process;

stimuli_process: process
begin
--set '1' as the default values for rst.
wait;


end process stimuli_process;
end architecture testbench;