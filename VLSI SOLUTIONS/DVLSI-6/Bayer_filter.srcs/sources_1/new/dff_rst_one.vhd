library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff_rst_one is
port(
D: in std_logic;
en,rst,clk : in std_logic;
Q : out std_logic);
end dff_rst_one;

architecture Behavioral of dff_rst_one is

begin

proc1: process(D,en,rst,clk) is
begin

if(rst='0') then Q <='1';
else
  if(rising_edge(clk)) then
    if(en='1') then
      Q <= D;
    end if;  
  end if;    
end if;

end process proc1;

end Behavioral;