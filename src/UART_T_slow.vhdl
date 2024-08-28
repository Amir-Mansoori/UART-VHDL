----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:40:49 03/05/2017 
-- Design Name: 
-- Module Name:    uart - Behavioral 
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

entity UART_T_slow is
    Port ( clk  : in  STD_LOGIC;
           tx   : out STD_LOGIC;
           din  : in  STD_LOGIC_vector(7 downto 0);
           busy : out STD_LOGIC;
           en   : in  STD_LOGIC);
end UART_T_slow;

architecture Behavioral of UART_T_slow is
type state_m is (idle,start,data,stop);
signal state:state_m;
signal sdin  : STD_LOGIC_vector(7 downto 0);
signal cnt  : integer range 0 to 5208;
signal i  : integer range 0 to 7;
begin
	process(clk)
		begin
		if(clk'event and clk='1')then
			case state is
				when idle=>
					if(en='1')then
						state<=start;
						busy<='1';
						cnt<=0;
						i<=0;
						sdin<=din;
					end if;
				when start=>
					cnt<=cnt+1;
					tx<='0';
					if(cnt=5207)then
						state<=data;
						cnt<=0;
					end if;
				when data=>
					cnt<=cnt+1;
					tx<=sdin(0);
					if(cnt=5207)then
						cnt<=0;
						sdin<='0' & sdin(7 downto 1);
						i<=i+1;
						if(i=7)then
							state<=stop;
							i<=0;
						end if;
					end if;
				when stop=>
					cnt<=cnt+1;
					tx<='1';
					if(cnt=5207)then
						state<=idle;
						cnt<=0;
						busy<='0';
					end if;
			end case;
		end if;
	end process;

end Behavioral;

