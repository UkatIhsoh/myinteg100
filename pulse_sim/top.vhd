----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:29:46 10/29/2020 
-- Design Name: 
-- Module Name:    top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( clk : in  STD_LOGIC;
			  rst : in	STD_LOGIC;
			  led : out STD_LOGIC;
           data_1 : in  STD_LOGIC;
			  data_out  : out STD_LOGIC_VECTOR(15 downto 0);
			  data_2 : in STD_LOGIC;
           ref_1 : in  STD_LOGIC;
			  ref_2 : in  STD_LOGIC;
           timing_1 : in  STD_LOGIC;
			  timing_2 : in  STD_LOGIC;
			  through_1 : in STD_LOGIC;
			  through_2 : in STD_LOGIC;
			  pulse_1 : out  STD_LOGIC;
           pulse_2 : out  STD_LOGIC);
end top;

architecture Behavioral of top is

component clk_gen is
	port(	CLK_IN1 : in STD_LOGIC;
			CLK_OUT1 : out STD_LOGIC);
end component;

signal clk_10M : std_logic;

signal counter_1 : std_logic_vector(15 downto 0):=X"0000";
signal counter_2 : std_logic_vector(15 downto 0):=X"0000";

signal bit_count_1 : std_logic_vector(3 downto 0);
signal bit_count_2 : std_logic_vector(3 downto 0):=X"0";

signal already_set_1 : std_logic:='0';
signal already_set_2 : std_logic:='0';

signal already_high_1 : std_logic:='0';
signal already_high_2 : std_logic:='0';

signal timing_on_1 : std_logic:='0';
signal timing_on_2 : std_logic:='0';

signal preset_1 : std_logic:='0';
signal preset_2 : std_logic:='0';

type reg_1 is record
	count_data_1 : std_logic_vector(15 downto 0);
end record;
 
signal p : reg_1; --posi
signal n : reg_1; --nega

type reg_2 is record
	count_data_2 : std_logic_vector(15 downto 0);
end record;

signal s : reg_2; --sun
signal m : reg_2; --moon

signal trigger_1 : std_logic:='0';
signal trigger_2 : std_logic:='0';

signal pulse_out_1 : std_logic:='0';
signal pulse_out_2 : std_logic:='0';

signal led_blink : std_logic:='0';
--led_blink <= not led_blink; --led test

signal one : std_logic;
signal two : std_logic;
--signal three : std_logic;
--signal four : std_logic;
--signal five : std_logic;
--signal six : std_logic;
--signal seven : std_logic;
--signal eight : std_logic;
--signal nine : std_logic;
--signal ten : std_logic;
--signal eleven : std_logic;
--signal twelve : std_logic;
--signal thirteen : std_logic;
--signal fourteen : std_logic;
--signal fifteen : std_logic;
--signal sixteen : std_logic;

begin

count_clk : clk_gen
	port map(	CLK_IN1 => clk,
					CLK_OUT1 => clk_10M);
					
process(clk_10M,rst) --クロック同期式バージョン
begin
	if rst = '1' then
		counter_1 <= (others => '0');
		counter_2 <= (others => '0');
		bit_count_1 <= (others => '0');
		bit_count_2 <= (others => '0');
		already_set_1 <= '0';
		already_set_2 <= '0';
		already_high_1 <= '0';
		already_high_2 <= '0';
		timing_on_1 <= '0';
		timing_on_2 <= '0';
		preset_1 <= '0';
		preset_2 <= '0';
		trigger_1 <= '0';
		trigger_2 <= '0';
		pulse_out_1 <= '0';
		pulse_out_2 <= '0';
		led_blink <= '0';
	elsif clk_10M'event and clk_10M = '1' then
	--RF pulse
		if timing_1 = '1' then
			if timing_on_1 = '0' then
				trigger_1 <= '1';
				timing_on_1 <= '1';
			end if;
		else
			timing_on_1 <= '0';
		end if;
		if trigger_1 = '1' then
			if counter_1 = p.count_data_1 then
				pulse_out_1 <= '0';
				trigger_1 <= '0';
				p <= n;
			else
				pulse_out_1 <= '1';
				counter_1 <= counter_1 +1;
			end if;
		else
			counter_1 <= (others => '0');
			pulse_out_1 <= '0';
		end if;
		if ref_1 = '1' then
			if already_high_1 = '0' then
				already_set_1 <= '0';
				already_high_1 <= '1';
				if data_1 = '1' then
					one <= '1';
				else
					one <= '0';
				end if;
			end if;
		else
			if already_set_1 = '0' then
				already_high_1 <= '0';
				already_set_1 <= '1';
				if preset_1 = '0' then
					if bit_count_1 = X"0" then
						p.count_data_1(0) <= one;
						bit_count_1 <= X"1";
					elsif bit_count_1 = X"1" then
						p.count_data_1(15) <= one;
						bit_count_1 <= X"2";
					elsif bit_count_1 = X"2" then
						p.count_data_1(14) <= one;
						bit_count_1 <= X"3";
					elsif bit_count_1 = X"3" then
						p.count_data_1(13) <= one;
						bit_count_1 <= X"4";
					elsif bit_count_1 = X"4" then
						p.count_data_1(12) <= one;
						bit_count_1 <= X"5";
					elsif bit_count_1 = X"5" then
						p.count_data_1(11) <= one;
						bit_count_1 <= X"6";
					elsif bit_count_1 = X"6" then
						p.count_data_1(10) <= one;
						bit_count_1 <= X"7";
					elsif bit_count_1 = X"7" then
						p.count_data_1(9) <= one;
						bit_count_1 <= X"8";
					elsif bit_count_1 = X"8" then
						p.count_data_1(8) <= one;
						bit_count_1 <= X"9";
					elsif bit_count_1 = X"9" then
						p.count_data_1(7) <= one;
						bit_count_1 <= X"A";
					elsif bit_count_1 = X"A" then
						p.count_data_1(6) <= one;
						bit_count_1 <= X"B";
					elsif bit_count_1 = X"B" then
						p.count_data_1(5) <= one;
						bit_count_1 <= X"C";
					elsif bit_count_1 = X"C" then
						p.count_data_1(4) <= one;
						bit_count_1 <= X"D";
					elsif bit_count_1 = X"D" then
						p.count_data_1(3) <= one;
						bit_count_1 <= X"E";
					elsif bit_count_1 = X"E" then
						p.count_data_1(2) <= one;
						bit_count_1 <= X"F";
					elsif bit_count_1 = X"F" then
						p.count_data_1(1) <= one;
						bit_count_1 <= X"0";
						preset_1 <= '1';
					end if;
				else
					if bit_count_1 = X"0" then
						n.count_data_1(0) <= one;
						bit_count_1 <= X"1";
					elsif bit_count_1 = X"1" then
						n.count_data_1(15) <= one;
						bit_count_1 <= X"2";
					elsif bit_count_1 = X"2" then
						n.count_data_1(14) <= one;
						bit_count_1 <= X"3";
					elsif bit_count_1 = X"3" then
						n.count_data_1(13) <= one;
						bit_count_1 <= X"4";
					elsif bit_count_1 = X"4" then
						n.count_data_1(12) <= one;
						bit_count_1 <= X"5";
					elsif bit_count_1 = X"5" then
						n.count_data_1(11) <= one;
						bit_count_1 <= X"6";
					elsif bit_count_1 = X"6" then
						n.count_data_1(10) <= one;
						bit_count_1 <= X"7";
					elsif bit_count_1 = X"7" then
						n.count_data_1(9) <= one;
						bit_count_1 <= X"8";
					elsif bit_count_1 = X"8" then
						n.count_data_1(8) <= one;
						bit_count_1 <= X"9";
					elsif bit_count_1 = X"9" then
						n.count_data_1(7) <= one;
						bit_count_1 <= X"A";
					elsif bit_count_1 = X"A" then
						n.count_data_1(6) <= one;
						bit_count_1 <= X"B";
					elsif bit_count_1 = X"B" then
						n.count_data_1(5) <= one;
						bit_count_1 <= X"C";
					elsif bit_count_1 = X"C" then
						n.count_data_1(4) <= one;
						bit_count_1 <= X"D";
					elsif bit_count_1 = X"D" then
						n.count_data_1(3) <= one;
						bit_count_1 <= X"E";
					elsif bit_count_1 = X"E" then
						n.count_data_1(2) <= one;
						bit_count_1 <= X"F";
					elsif bit_count_1 = X"F" then
						n.count_data_1(1) <= one;
						bit_count_1 <= X"0";
					end if;
				end if;
			end if;
		end if;	
	--AD
--		if timing_2 = '1' then
--			if timing_on_2 = '0' then
--				trigger_2 <= '1';
--				timing_on_2 <= '1';
--			end if;
--		else
--			timing_on_2 <= '0';
--		end if;
--		if trigger_2 = '1' then
--			if counter_2 = s.count_data_2 then
--				pulse_out_2 <= '0';
--				trigger_2 <= '0';
--				p <= n;
--			else
--				pulse_out_2 <= '1';
--				counter_2 <= counter_2 +1;
--			end if;
--		else
--			counter_2 <= (others => '0');
--			pulse_out_2 <= '0';
--		end if;
--		if ref_2 = '1' then
--			if already_high_2 = '0' then
--				already_set_2 <= '0';
--				already_high_2 <= '1';
--				if data_2 = '1' then
--					two <= '1';
--				else
--					two <= '0';
--				end if;
--			end if;
--		else
--			if already_set_2 = '0' then
--				already_high_2 <= '0';
--				already_set_2 <= '1';
--				if preset_2 = '0' then
--					if bit_count_2 = X"0" then
--						s.count_data_2(0) <= two;
--						bit_count_2 <= X"1";
--					elsif bit_count_2 = X"1" then
--						s.count_data_2(15) <= two;
--						bit_count_2 <= X"2";
--					elsif bit_count_2 = X"2" then
--						s.count_data_2(14) <= two;
--						bit_count_2 <= X"3";
--					elsif bit_count_2 = X"3" then
--						s.count_data_2(13) <= two;
--						bit_count_2 <= X"4";
--					elsif bit_count_2 = X"4" then
--						s.count_data_2(12) <= two;
--						bit_count_2 <= X"5";
--					elsif bit_count_2 = X"5" then
--						s.count_data_2(11) <= two;
--						bit_count_2 <= X"6";
--					elsif bit_count_2 = X"6" then
--						s.count_data_2(10) <= two;
--						bit_count_2 <= X"7";
--					elsif bit_count_2 = X"7" then
--						s.count_data_2(9) <= two;
--						bit_count_2 <= X"8";
--					elsif bit_count_2 = X"8" then
--						s.count_data_2(8) <= two;
--						bit_count_2 <= X"9";
--					elsif bit_count_2 = X"9" then
--						s.count_data_2(7) <= two;
--						bit_count_2 <= X"A";
--					elsif bit_count_2 = X"A" then
--						s.count_data_2(6) <= two;
--						bit_count_2 <= X"B";
--					elsif bit_count_2 = X"B" then
--						s.count_data_2(5) <= two;
--						bit_count_2 <= X"C";
--					elsif bit_count_2 = X"C" then
--						s.count_data_2(4) <= two;
--						bit_count_2 <= X"D";
--					elsif bit_count_2 = X"D" then
--						s.count_data_2(3) <= two;
--						bit_count_2 <= X"E";
--					elsif bit_count_2 = X"E" then
--						s.count_data_2(2) <= two;
--						bit_count_2 <= X"F";
--					elsif bit_count_2 = X"F" then
--						s.count_data_2(1) <= two;
--						bit_count_2 <= X"0";
--						preset_2 <= '1';
--					end if;
--				else
--					if bit_count_2 = X"0" then
--						m.count_data_2(0) <= two;
--						bit_count_2 <= X"1";
--					elsif bit_count_2 = X"1" then
--						m.count_data_2(15) <= two;
--						bit_count_2 <= X"2";
--					elsif bit_count_2 = X"2" then
--						m.count_data_2(14) <= two;
--						bit_count_2 <= X"3";
--					elsif bit_count_2 = X"3" then
--						m.count_data_2(13) <= two;
--						bit_count_2 <= X"4";
--					elsif bit_count_2 = X"4" then
--						m.count_data_2(12) <= two;
--						bit_count_2 <= X"5";
--					elsif bit_count_2 = X"5" then
--						m.count_data_2(11) <= two;
--						bit_count_2 <= X"6";
--					elsif bit_count_2 = X"6" then
--						m.count_data_2(10) <= two;
--						bit_count_2 <= X"7";
--					elsif bit_count_2 = X"7" then
--						m.count_data_2(9) <= two;
--						bit_count_2 <= X"8";
--					elsif bit_count_2 = X"8" then
--						m.count_data_2(8) <= two;
--						bit_count_2 <= X"9";
--					elsif bit_count_2 = X"9" then
--						m.count_data_2(7) <= two;
--						bit_count_2 <= X"A";
--					elsif bit_count_2 = X"A" then
--						m.count_data_2(6) <= two;
--						bit_count_2 <= X"B";
--					elsif bit_count_2 = X"B" then
--						m.count_data_2(5) <= two;
--						bit_count_2 <= X"C";
--					elsif bit_count_2 = X"C" then
--						m.count_data_2(4) <= two;
--						bit_count_2 <= X"D";
--					elsif bit_count_2 = X"D" then
--						m.count_data_2(3) <= two;
--						bit_count_2 <= X"E";
--					elsif bit_count_2 = X"E" then
--						m.count_data_2(2) <= two;
--						bit_count_2 <= X"F";
--					elsif bit_count_2 = X"F" then
--						m.count_data_2(1) <= two;
--						bit_count_2 <= X"0";
--					end if;
--				end if;
--			end if;
--		end if;
	end if;

end process;

pulse_1 <= pulse_out_1 or through_1;
pulse_2 <= pulse_out_2 or through_2;

data_out <= p.count_data_1;
led <= timing_1;

end Behavioral;

