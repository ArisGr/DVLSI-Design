library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Lock is
port(
Sig,rst: in std_logic;
Lock: out std_logic);
end Lock;

architecture Behavioral of Lock is

component tff is
port(
T: in std_logic;
en,rst,clk : in std_logic;
Q : out std_logic);
end component;

component mux_2to1 is
port(
A,B,Sel: in std_logic;
Output: out std_logic);
end component;

signal Lock_intr,mux_out: std_logic;

begin

M: mux_2to1 port map(Sig,'0',Lock_intr,mux_out);

T: tff port map('1','1',rst,mux_out,Lock_intr);

Lock <= Lock_intr;


end Behavioral;
