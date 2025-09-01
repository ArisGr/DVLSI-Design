library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff is
port(
D: in std_logic_vector(7 downto 0);
en,rst,clk : in std_logic;
Q : out std_logic_vector(7 downto 0));
end dff;

architecture Behavioral of dff is

begin

proc1: process(D,en,rst,clk) is
begin

if(rst='0') then Q <=(others =>'0');
else
  if(rising_edge(clk)) then
    if(en='1') then
      Q <= D;
    end if;  
  end if;    
end if;

end process proc1;

end Behavioral;
