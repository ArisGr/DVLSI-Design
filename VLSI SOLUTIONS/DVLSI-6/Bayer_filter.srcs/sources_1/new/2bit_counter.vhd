library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity two_bit_counter is
port(
clk,rst: in std_logic;
Q : out std_logic_vector(1 downto 0));
end two_bit_counter;

architecture Behavioral of two_bit_counter is

component tff is
port(
T: in std_logic;
en,rst,clk : in std_logic;
Q : out std_logic);
end component;

signal q0,not_q0: std_logic;

begin

t0: tff port map( '1','1',rst,clk,q0);

Q(0) <= q0;
not_q0 <= not q0;

t1: tff port map( '1','1',rst,not_q0,Q(1));


end Behavioral;
