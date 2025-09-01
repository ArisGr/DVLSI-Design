library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real."log2";
use IEEE.math_real."ceil";

entity show_line_column is
generic( N: integer :=32);
port(
clk,en,rst: in std_logic;
Qline,Qcolumn: out std_logic_vector(integer(ceil(log2(real(N)))) downto 0));
end show_line_column;

architecture Behavioral of show_line_column is

component Sync_counter is
generic(N : integer :=32);
port(
clk,en,rst: in std_logic;
Q: out std_logic_vector(integer(ceil(log2(real(N)))) downto 0));
end component;

constant logN: integer :=integer(ceil(log2(real(N))));
signal Qline_intr : std_logic_vector(logN downto 0);
signal Qcolumn_intr : std_logic_vector(logN downto 0);
signal s_line,s_column: std_logic_vector(logN downto 1);
signal first_line,first_column: std_logic;
begin

Line: Sync_counter generic map(N) port map( clk=>clk,en=>en,rst=>rst,Q=>Qline_intr);

s_line(1) <= not Qline_intr(1);

Loop1: for i in 1 to ( logN -1) generate
s_line(i+1) <= s_line(i) and (not Qline_intr(i+1));
end generate Loop1;

first_line <= s_line(logN) and Qline_intr(0);

Column: Sync_counter generic map(N) port map( clk=>first_line,en=>en,rst=>rst,Q=>Qcolumn);

Qline <= Qline_intr;

end Behavioral;
