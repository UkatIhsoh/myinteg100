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

signal bit_count_1 : std_logic_vector(3 downto 0):=X"0";
signal bit_count_2 : std_logic_vector(3 downto 0):=X"0";

signal already_set_1 : std_logic:='0';
signal already_set_2 : std_logic:='0';

signal already_high_1 : std_logic:='0';
signal already_high_2 : std_logic:='0';

type reg_1 is record
	count_data_1 : std_logic_vector(15 downto 0);
end record;

signal p : reg_1;
signal n : reg_1;

type reg_2 is record
	count_data_2 : std_logic_vector(15 downto 0);
end record;

signal s : reg_2;
signal m : reg_2;

signal trigger_1 : std_logic:='0';
signal trigger_2 : std_logic:='0';

signal pulse_out_1 : std_logic:='0';
signal pulse_out_2 : std_logic:='0';

signal led_blink : std_logic:='0';
--led_blink <= not led_blink; --led test

begin

count_clk : clk_gen
	port map(	CLK_IN1 => clk,
					CLK_OUT1 => clk_10M);

process(clk_10M,rst,data_1,ref_1,timing_1,trigger_1)
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
		trigger_1 <= '0';
		trigger_2 <= '0';
		pulse_out_1 <= '0';
		pulse_out_2 <= '0';
		led_blink <= '0';
	elsif clk_10M'event and clk_10M = '1' then
		if trigger_1 = '1' then
			if counter_1 = X"000A" then--p.count_data_1 then
				pulse_out_1 <= '0';
				trigger_1 <= '0';
			else
				pulse_out_1 <= '1';
				counter_1 <= counter_1 +1;
			end if;
		else
			counter_1 <= (others => '0');
			pulse_out_1 <= '0';
		end if;
	end if;

--データの格納（ラズパイからの参照信号が立ち上がった時に、ラズパイからデータピンに入力されているビットを読み込み記憶する）
	if ref_1 = '1' then
		if already_set_1 = '0' then
			case bit_count_1 is
				when "0000" =>
					n.count_data_1(15) <= data_1;
					bit_count_1 <= "0001";
					already_set_1 <= '1'; 
				when "0001" =>
					n.count_data_1(14) <= data_1;
					bit_count_1 <= "0010";
					already_set_1 <= '1';
				when "0010" =>
					n.count_data_1(13) <= data_1;
					bit_count_1 <= "0011";
					already_set_1 <= '1';
				when "0011" =>
					n.count_data_1(12) <= data_1;
					bit_count_1 <= "0100";
					already_set_1 <= '1';
				when "0100" =>
					n.count_data_1(11) <= data_1;
					bit_count_1 <= "0101";
					already_set_1 <= '1';
				when "0101" =>
					n.count_data_1(10) <= data_1;
					bit_count_1 <= "0110";
					already_set_1 <= '1';
				when "0110" =>
					n.count_data_1(9) <= data_1;
					bit_count_1 <= "0111";
					already_set_1 <= '1';
				when "0111" =>
					n.count_data_1(8) <= data_1;
					bit_count_1 <= X"8";
					already_set_1 <= '1';
				when X"8" =>
					n.count_data_1(7) <= data_1;
					bit_count_1 <= X"9";
					already_set_1 <= '1';
				when X"9" =>
					n.count_data_1(6) <= data_1;
					bit_count_1 <= X"A";
					already_set_1 <= '1';
				when X"A" =>
					n.count_data_1(5) <= data_1;
					bit_count_1 <= X"B";
					already_set_1 <= '1';
				when X"B" =>
					n.count_data_1(4) <= data_1;
					bit_count_1 <= X"C";
					already_set_1 <= '1';
				when X"C" =>
					n.count_data_1(3) <= data_1;
					bit_count_1 <= X"D";
					already_set_1 <= '1';
				when X"D" =>
					n.count_data_1(2) <= data_1;
					bit_count_1 <= X"E";
					already_set_1 <= '1';
				when X"E" =>
					n.count_data_1(1) <= data_1;
					bit_count_1 <= X"F";
					already_set_1 <= '1';
				when X"F" =>
					n.count_data_1(0) <= data_1;
					bit_count_1 <= "0000";
					already_set_1 <= '1';
				when others =>
					bit_count_1 <= "0000";
			end case;
		end if;
	else
		already_set_1 <= '0';
	end if;
	
--ラズパイからカウント開始のトリガーを受け取ったらカウント開始
	if timing_1 = '1' then
		trigger_1 <= '1';
		p <= n;
--		if already_high_1 = '0' then
--			trigger_1 <= '1';
--			p <= n;
--			already_high_1 <= '1';
--		end if;
--	else
--		already_high_1 <= '0';
	end if;

end process;

pulse_1 <= pulse_out_1;
pulse_2 <= pulse_out_2;

data_out <= n.count_data_1;
led <= timing_1;

end Behavioral;

