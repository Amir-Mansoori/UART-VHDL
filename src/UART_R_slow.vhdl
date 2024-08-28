----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:46:56 03/06/2017 
-- Design Name: 
-- Module Name:    UART_r - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UART_R_slow is
    Port ( RX : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Ack : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (7 downto 0);
           valid : out  STD_LOGIC);
end UART_R_slow;

architecture Behavioral of UART_R_slow is

type state_M is (idle, start, middle, data);
signal state: state_M;
signal sdout: std_logic_vector(7 downto 0);
signal cnt: integer range 0 to 5208:=0;
signal i: integer range 0 to 7:=0;

begin

	process(clk)
	begin
		
		if(clk'event and clk='1') then
			
			case state is
				when idle =>
					if(Ack='1') then
						valid<='0';
					end if;
					if(RX = '0') then
						state<= Start;
					end if;
				when start =>
					cnt<=cnt+1;
					if(cnt=5207) then
						cnt<=0;
						state<=middle;
					end if;
				when middle =>
					cnt<=cnt+1;
					if(cnt=2603) then
						cnt<=0;
						sdout(7)<= RX;
						state<=Data;
					end if;
				when Data =>
					cnt<=cnt+1;
					if(cnt=5207) then
						cnt<=0;
						sdout<=RX & sdout(7 downto 1);
						i<=i+1;
						if(i=7) then
							i<=0;
							Dout<=sdout;
							valid<='1';
							state<=idle;
						end if;
					end if;
			end case;
			
		end if;
		
	end process;

end Behavioral;

