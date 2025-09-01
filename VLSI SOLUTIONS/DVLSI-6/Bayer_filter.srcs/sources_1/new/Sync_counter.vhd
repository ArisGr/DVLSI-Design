library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.math_real."log2";
use IEEE.math_real."ceil";


entity Sync_counter is
generic(N : integer :=32);
port(
clk,en,rst: in std_logic;
Q: out std_logic_vector(integer(ceil(log2(real(N)))) downto 0));
end Sync_counter;

architecture Behavioral of Sync_counter is

constant logN: integer :=integer(ceil(log2(real(N))));
signal intr: std_logic_vector(logN downto 0);
signal max : std_logic_vector(logN downto 0);

begin

max(logN) <='1';
max(logN-1 downto 0) <= (others =>'0');

proc1: process(clk,en,rst,intr) is
begin

if (rst='0') then

intr(logN downto 1) <= (others => '0');
intr(0) <='1';

else
  if(rising_edge(clk)) then
    if(en='1') then
      if(intr=max) then
      
      intr(logN downto 1) <= (others => '0');
      intr(0) <='1';

      else
      
      intr <= intr+1;
      
      end if;    
    end if;
  end if;
end if;    
end process proc1;

Q <= intr;

end Behavioral;
