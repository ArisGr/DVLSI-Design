library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
use IEEE.math_real."log2";
use IEEE.math_real."ceil";

entity all_together is

generic(N : integer :=32);

port(
clk,rst_n,valid_in,new_image: in std_logic;
pixel : in std_logic_vector(7 downto 0);
image_finished,valid_out : out std_logic;
R,G,B : out std_logic_vector(7 downto 0)
--S_counter: out std_logic_vector(integer(ceil(log2(real(N)))) downto 0);
--Q_2bit:out std_logic_vector(1 downto 0);
--Qline,Qcolumn: out std_logic_vector(integer(ceil(log2(real(N)))) downto 0)
);
end all_together;

architecture Behavioral of all_together is

component progress is

generic(N : integer :=16);

port(

clk,rst,en,valid_in: in std_logic;
pixel : in std_logic_vector(7 downto 0);
Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9 : out std_logic_vector(7 downto 0);
to_fsm: out std_logic;
S_counter: out std_logic_vector(integer(ceil(log2(real(N)))) downto 0);
Q_2bit:out std_logic_vector(1 downto 0);
keep_en : in std_logic
--Lock_0,rd_top,rd_mid,rd_bot,empty_top,empty_mid,empty_bot : out std_logic
);
end component;

component fsm_plus_counters is
generic( N: integer :=32);
port(
clk,en,rst: in std_logic;
Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9 : in std_logic_vector(7 downto 0);
R,G,B : out std_logic_vector(7 downto 0);
Qline,Qcolumn: out std_logic_vector(integer(ceil(log2(real(N)))) downto 0));
end component;

component Lock is
port(
Sig,rst: in std_logic;
Lock: out std_logic);
end component;

component dff_rst_one is
port(
D: in std_logic;
en,rst,clk : in std_logic;
Q : out std_logic);
end component;

component dff_one_bit is
port(
D: in std_logic;
en,rst,clk : in std_logic;
Q : out std_logic);
end component;

constant logN: integer :=integer(ceil(log2(real(N))));
signal Q1_intr,Q2_intr,Q3_intr,Q4_intr,Q5_intr,Q6_intr,Q7_intr,Q8_intr,Q9_intr : std_logic_vector(7 downto 0);
signal to_fsm_intr,en_fsm,keep_en_intr,keep_en,alt_rst_intr,alt_rst,net_rst : std_logic;
signal S_counter_intr : std_logic_vector(logN downto 0);
signal Q_2bit_intr : std_logic_vector(1 downto 0);
signal Qline_intr,Qcolumn_intr: std_logic_vector(logN downto 0);

begin

p1: progress generic map(N) port map(clk,net_rst,new_image,valid_in,pixel,
Q1_intr,Q2_intr,Q3_intr,Q4_intr,Q5_intr,Q6_intr,Q7_intr,Q8_intr,Q9_intr,
to_fsm_intr,S_counter_intr,Q_2bit_intr,keep_en);

en_fsm <= to_fsm_intr and (valid_in or keep_en);

f1: fsm_plus_counters generic map(N) port map(clk,en_fsm,net_rst,
Q1_intr,Q2_intr,Q3_intr,Q4_intr,Q5_intr,Q6_intr,Q7_intr,Q8_intr,Q9_intr,
R,G,B,Qline_intr,Qcolumn_intr);


proc1: process(clk,Qline_intr,Qcolumn_intr) is
begin
  
  if(rising_edge(clk)) then
    if(Qline_intr=N-5 and Qcolumn_intr=N-2) then keep_en_intr <='1';
    else keep_en_intr <='0';
    end if;
    
    if(Qline_intr=N and Qcolumn_intr=N) then alt_rst_intr <='0';
    else alt_rst_intr <='1';
    end if;
  end if;
  
end process proc1;

Lock0: Lock port map(keep_en_intr,net_rst,keep_en);

Dff1: dff_rst_one port map(alt_rst_intr,'1',net_rst,clk,alt_rst);

net_rst <= alt_rst and rst_n;

Dff2: dff_one_bit port map(en_fsm,'1',net_rst,clk,valid_out);

image_finished <= not alt_rst_intr;

--S_counter <= S_counter_intr;
--Q_2bit <= Q_2bit_intr;

--Qline <= Qline_intr;
--Qcolumn <= Qcolumn_intr;

end Behavioral;
