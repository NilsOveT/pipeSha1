library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package b7seg is
	function hex_to7seg (a: unsigned) return std_logic_vector;
end b7seg;

package body b7seg is
	function hex_to7seg (a: unsigned) return std_logic_vector is
	variable result: std_logic_vector(6 downto 0);
	variable hex: unsigned(3 downto 0) := (others => '0');
	begin
		hex := a;
		case hex is
			when X"0" => result := "1000000";
			when X"1" => result := "1111001";
			when X"2" => result := "0100100";
			when X"3" => result := "0110000";
			when X"4" => result := "0011001";
			when X"5" => result := "0010010";
			when X"6" => result := "0000010";
			when X"7" => result := "1011000";
			when X"8" => result := "0000000";
			when X"9" => result := "0010000";
			when X"A" => result := "0001000";
			when X"B" => result := "0000011";
			when X"C" => result := "1000110";
			when X"D" => result := "0100001";
			when X"E" => result := "0000110";
			when others => result := "0001110";
		end case;
		
		return result;
	end hex_to7seg;
	
end b7seg;