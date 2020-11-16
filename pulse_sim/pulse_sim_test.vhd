--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:20:05 10/29/2020
-- Design Name:   
-- Module Name:   E:/hoshino_Data/SotsuKen/ISE/myinteg100/pulse_sim/pulse_sim_test.vhd
-- Project Name:  pulse_sim
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY pulse_sim_test IS
END pulse_sim_test;
 
ARCHITECTURE behavior OF pulse_sim_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         clk : IN  std_logic;
			rst : in	STD_LOGIC;
			led : out STD_LOGIC;
         data_1 : IN  std_logic;
         data_2 : IN  std_logic;
			data_out  : out STD_LOGIC_VECTOR(15 downto 0);
         ref_1 : IN  std_logic;
         ref_2 : IN  std_logic;
         timing_1 : IN  std_logic;
         timing_2 : IN  std_logic;
         pulse_1 : OUT  std_logic;
         pulse_2 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
	signal rst : std_logic := '0';
   signal data_1 : std_logic := '0';
   signal data_2 : std_logic := '0';
   signal ref_1 : std_logic := '0';
   signal ref_2 : std_logic := '0';
   signal timing_1 : std_logic := '0';
   signal timing_2 : std_logic := '0';

 	--Outputs
	signal led : std_logic;
	signal data_out : std_logic_vector(15 downto 0);
   signal pulse_1 : std_logic;
   signal pulse_2 : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          clk => clk,
			 rst => rst,
			 led => led,
			 data_out => data_out,
          data_1 => data_1,
          data_2 => data_2,
          ref_1 => ref_1,
          ref_2 => ref_2,
          timing_1 => timing_1,
          timing_2 => timing_2,
          pulse_1 => pulse_1,
          pulse_2 => pulse_2
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	
	
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period;

      -- insert stimulus here 
		data_1 <= '0';
		
		wait for clk_period;
		
		ref_1 <= '1';
		
		wait for clk_period;
		
		ref_1 <= '0';
		
		wait for clk_period;
		
		ref_1 <= '1';
		
		wait for clk_period;
		
		ref_1 <= '0';
		
		wait for clk_period;
		
		ref_1 <= '1';
		
		wait for clk_period;
		
		ref_1 <= '0';
		
		wait for clk_period;
		
		ref_1 <= '1';
		
		wait for clk_period;
		
		ref_1 <= '0';
		
		wait for clk_period;
		
		ref_1 <= '1';
		
		wait for clk_period;
		
		ref_1 <= '0';
		
		wait for clk_period;
		
		ref_1 <= '1';
		
		wait for clk_period;
		
		ref_1 <= '0';
		
		wait for clk_period;
		
		ref_1 <= '1';
		
		wait for clk_period;
		
		ref_1 <= '0';
		
		wait for clk_period;
		
		ref_1 <= '1';
		
		wait for clk_period;
		
		ref_1 <= '0';
		
		wait for clk_period;
		
		ref_1 <= '1';
		
		wait for clk_period;
		
		ref_1 <= '0';
		
		wait for clk_period;
		
		ref_1 <= '1';
		
		wait for clk_period;
		
		ref_1 <= '0';
		
		wait for clk_period;
		
		ref_1 <= '1';
		
		wait for clk_period;
		
		ref_1 <= '0';
		
		wait for clk_period;
		
		ref_1 <= '1';
		
		wait for clk_period;
		
		ref_1 <= '0';
		
		data_1 <= '1';
		
		wait for clk_period;
		
		ref_1 <= '1';
		
		wait for clk_period;
		
		data_1 <= '0';
		
		ref_1 <= '0';
		
		wait for clk_period;
		
		ref_1 <= '1';
		
		wait for clk_period;
		
		ref_1 <= '0';
		
		data_1 <= '1';
		
		wait for clk_period;
		
		ref_1 <= '1';
		
		wait for clk_period;
		
		data_1 <= '0';
		
		ref_1 <= '0';
		
		wait for clk_period;
		
		ref_1 <= '1';
		
		wait for clk_period;
		
		ref_1 <= '0';
		
		wait for clk_period;
		
		timing_1 <= '1';
		
		wait for clk_period;
		
		timing_1 <= '0';
		
		wait for clk_period*5;
		
      wait;
   end process;

END;
