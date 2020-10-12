----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:23:51 10/18/2019 
-- Design Name: 
-- Module Name:    data_fetch - fetch 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--kopipeyou
--component data_fetch is
--	port( clk : in std_logic;
--			rst : in std_logic;
--			msr_start : in std_logic; 
--			msr_finish : out std_logic;
--			str_adr : in std_logic_vector(19 downto 0);
--			
--			data64 : out std_logic_vector(63 downto 0);
--			fetch_fin : out std_logic; 
--			decode_en : in std_logic;
--			
--			data_req : out std_logic;
--			sdr_adr : out std_logic_vector(19 downto 0);
--			sdr_fin : in std_logic;
--			sdr_data : in std_logic_vector(63 downto 0));	
--end component;
--
--fetch : data_fetch 
--	port map( clk => ,
--				 rst => ,
--				 msr_start => ,
--				 msr_finish => ,
--				 str_adr => ,
--			
--				 data64 => ,
--				 fetch_fin => , 
--				 decode_en => ,
--			
--				 data_req => ,
--				 sdr_adr => ,
--				 sdr_fin => ,
--				 sdr_data => ,);	


entity data_fetch is
	port( clk : in std_logic;
			rst : in std_logic;
			msr_start : in std_logic; 
			msr_finish : out std_logic;
			str_adr : in std_logic_vector(19 downto 0);
			end_adr : in std_logic_vector(19 downto 0);
			
			data64 : out std_logic_vector(63 downto 0);
			fetch_fin : out std_logic; 
			decode_en : in std_logic;
			
			test_pin : out std_logic; --test
			
			data_req : out std_logic;
			sdr_adr : out std_logic_vector(19 downto 0);
			sdr_fin : in std_logic;
			sdr_data : in std_logic_vector(63 downto 0));	
end data_fetch;

architecture fetch of data_fetch is

	type state_t is (idle, dt_wait, dt_aquire, prepare); --��Ԗ��i�A�C�h���A�f�[�^�ҋ@�A�f�[�^�l���A���ւ̏����j

	type reg is record
		data : std_logic_vector(63 downto 0);
		f_fin : std_logic; --fetch����
		d_req : std_logic;
		addr : std_logic_vector(19 downto 0);
		f_run : std_logic;	--fetch��H���쒆
		state : state_t;
		d_num : std_logic_vector(1 downto 0); --�f�[�^�U�S�r�b�g���S����
		start : std_logic; --msr_start�ɑΉ�
		finish : std_logic; --msr_finish�ɑΉ�
		fresh : std_logic; --�ŏ��ɃX�^�[�g�A�h���X��ǂݍ��߂邽��
	end record;

	signal p : reg;
	signal n : reg; 

begin

	data64 <= p.data;
	fetch_fin <= p.f_fin;
	
	data_req <= p.d_req;
	sdr_adr <= p.addr; 
	
	msr_finish <= p.finish;
	
	process(n,p,msr_start,sdr_data,decode_en,n.state)
	begin
		n <= p;
		
		if p.f_run = '0' then
			if msr_start = '1' then
				n.start <= '1';
			else
				if p.addr = end_adr then
					n.start <= '0';
					n.f_fin <= '0';
					if p.finish = '0' then
						n.finish <= '1';
					else
						n.finish <= '0';
						n.fresh <= '0';
						n.addr <= str_adr;
					end if;
				end if;
			end if;
		end if;
		
		if p.start = '1' then
			if p.f_run = '0' then --fetch��H�n��
				n.f_run <= '1';
				if p.fresh = '0' then --fresh�łȂ��Ȃ�start_address��ǂݍ���
					n.addr <= str_adr;
					n.d_req <= '1';	--������am�փ��N�G�X�g
					n.fresh <= '1';
				else
					n.addr <= p.addr +1;
					n.d_req <= '1';	--������am�փ��N�G�X�g
				end if;
				n.state <= dt_wait;
			else
				n.d_req <= '0';
				case p.state is
					when idle =>
						null;
						
					when dt_wait =>
						if sdr_fin = '1' then
							n.state <= dt_aquire;
						end if;
						
					when dt_aquire => 
						if p.d_num = "00" then
							n.data(15 downto 0) <= sdr_data(15 downto 0);
							n.d_num <= "01";
						elsif p.d_num = "01" then
							n.data(31 downto 16) <= sdr_data(31 downto 16);
							n.d_num <= "10";
						elsif p.d_num = "10" then
							n.data(47 downto 32) <= sdr_data(47 downto 32);
							n.d_num <= "11";
						elsif p.d_num = "11" then
							n.data(63 downto 48) <= sdr_data(63 downto 48);
							n.d_num <= "00";
							n.f_fin <= '1';
							n.state <= prepare;
						end if;
						
					when prepare => 
						if decode_en = '1' then
							n.f_run <= '0';
							n.f_fin <= '0';
							n.state <= idle;
						end if;
						
					when others =>
						n.f_run <= '0';
				end case;					
			end if;
		end if;
	
	end process;
	
	process(clk,rst)
	begin
		if rst = '1' then
			p.data <= (others => '0');
			p.f_fin <= '0';
			p.d_req <= '0';
			p.addr <= (others => '0');
			p.f_run <= '0';
			p.state <= idle;
			p.d_num <= "00";
			p.start <= '0';
			p.fresh <= '0';
		elsif clk' event and clk = '1' then
			p <= n;
		end if;
	end process;

end fetch;


