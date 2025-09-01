library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2to1 is
port(
A,B,Sel: in std_logic;
Output: out std_logic);
end mux_2to1;

architecture Behavioral of mux_2to1 is

begin

with Sel select

Output <= A when '0',
          B when '1',
          '0' when others;

end Behavioral;
