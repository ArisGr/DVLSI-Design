library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tff is
port(
T: in std_logic;
en,rst,clk : in std_logic;
Q : out std_logic);
end tff;

architecture Behavioral of tff is

component dff_one_bit is
port(
D: in std_logic;
en,rst,clk : in std_logic;
Q : out std_logic);
end component;


signal Q_intr,D_intr: std_logic;

begin

D_intr <= Q_intr xor T;

d1: dff_one_bit port map(D_intr,en,rst,clk,Q_intr);

Q <= Q_intr;

end Behavioral;
