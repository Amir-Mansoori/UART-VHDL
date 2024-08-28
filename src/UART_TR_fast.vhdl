----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:23:15 03/06/2017 
-- Design Name: 
-- Module Name:    UART_TR - Behavioral 
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

entity UART_TR_fast is
    Port ( clk  : in  STD_LOGIC;
           tx   : out STD_LOGIC;
			  RX : in  STD_LOGIC;
			  Ack : in  STD_LOGIC;
           din  : in  STD_LOGIC_vector(7 downto 0);
			  Dout : out  STD_LOGIC_VECTOR (7 downto 0);
           busy : out STD_LOGIC;
           en   : in  STD_LOGIC;
			  valid : out  STD_LOGIC);
end UART_TR_fast;

architecture Behavioral of UART_TR_slow is

component UART_T_fast is
    Port ( clk  : in  STD_LOGIC;
           tx   : out STD_LOGIC;
           din  : in  STD_LOGIC_vector(7 downto 0);
           busy : out STD_LOGIC;
           en   : in  STD_LOGIC);
end component;

component UART_R_fast is
    Port ( RX : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Ack : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (7 downto 0);
           valid : out  STD_LOGIC);
end component;

begin

u1: UART_T_fast port map
(
clk =>clk,
tx  => tx,
din =>din,
busy => busy,
en  => en
);

u2: UART_R_fast port map
(
RX =>   RX,
clk =>  clk,
Ack =>  Ack,
Dout => Dout,
valid => valid
);

end Behavioral;

