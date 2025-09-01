library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
use IEEE.math_real."log2";
use IEEE.math_real."ceil";

entity fsm_plus_counters is
generic( N: integer :=32);
port(
clk,en,rst: in std_logic;
Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9 : in std_logic_vector(7 downto 0);
R,G,B : out std_logic_vector(7 downto 0);
Qline,Qcolumn: out std_logic_vector(integer(ceil(log2(real(N)))) downto 0));
end fsm_plus_counters;

architecture Behavioral of fsm_plus_counters is

component show_line_column is
generic( N: integer :=32);
port(
clk,en,rst: in std_logic;
Qline,Qcolumn: out std_logic_vector(integer(ceil(log2(real(N)))) downto 0));
end component;

component ALU is
generic( N: integer :=32);
  Port (
  
  clk : in std_logic;
  alu_init : in  std_logic;
  Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9 : in std_logic_vector(7 downto 0);
  xcounter,ycounter : in std_logic_vector(integer(ceil(log2(real(N)))) downto 0);
  R,G,B : out std_logic_vector(7 downto 0);
  rst : in std_logic
  );
end component;

constant logN: integer :=integer(ceil(log2(real(N))));
signal xcounter_intr, ycounter_intr : std_logic_vector(logN downto 0);

begin

slc: show_line_column generic map(N) port map(clk,en,rst,xcounter_intr,ycounter_intr);
alu1: alu generic map(N) port map(clk,en,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,xcounter_intr,ycounter_intr,R,G,B,rst);

Qline <= xcounter_intr;
Qcolumn <= ycounter_intr;
end Behavioral;
