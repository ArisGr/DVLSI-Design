library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
use IEEE.math_real."log2";
use IEEE.math_real."ceil";

entity progress is

generic(N : integer :=32);

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
end progress;

architecture Behavioral of progress is

component signal_counter is
generic(N : integer);
port(
clk,en,rst: in std_logic;
Q: out std_logic_vector(integer(ceil(log2(real(N)))) downto 0));
end component;

component two_bit_counter is
port(
clk,rst: in std_logic;
Q : out std_logic_vector(1 downto 0));
end component;

component Lock is
port(
Sig,rst: in std_logic;
Lock: out std_logic);
end component;

component dff is
port(
D: in std_logic_vector(7 downto 0);
en,rst,clk : in std_logic;
Q : out std_logic_vector(7 downto 0));
end component;

component dff_one_bit is
port(
D: in std_logic;
en,rst,clk : in std_logic;
Q : out std_logic);
end component;

COMPONENT fifo_generator_0
  PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC
  );
END COMPONENT;

constant logN: integer :=integer(ceil(log2(real(N))));
signal Lock_intr,rd_en_top,rd_en_mid,rd_en_bot,clk_2bit_counter,Q_2bit_all,rst_fifo: std_logic;
signal wr_en_mid,wr_en_bot : std_logic;
signal Sig_cntr_Num: std_logic_vector(logN downto 0);
signal dout_top_intr,dout_top_intr0,dout_top_intr1,dout_mid_intr,dout_mid_intr0,dout_bot_intr: std_logic_vector(7 downto 0);
signal Q1_intr,Q2_intr,Q3_intr,Q4_intr,Q5_intr,Q6_intr,Q7_intr,Q8_intr,Q9_intr :std_logic_vector(7 downto 0);
signal Q_2bit_intr: std_logic_vector(1 downto 0);

signal full_top,full_mid,full_bot :std_logic;
signal empty_top_intr,empty_mid_intr,empty_bot_intr :std_logic;

signal en_sig_cntr, rd_en_top_intr, wr_en_mid_intr, rd_en_mid_intr, wr_en_bot_intr, rd_en_bot_intr, to_fsm_intr :std_logic;



begin

rst_fifo <= not rst;

Lock0: Lock port map(en,rst,Lock_intr);

en_sig_cntr <= Lock_intr  and (valid_in or keep_en);

--signal_counter : When the output of this counter is N, into the FIFO enters the Nth-1 pixel.
--This is used to save and gates.
Sig_counter: signal_counter generic map(N) port map(clk,en_sig_cntr,rst,Sig_cntr_Num);

--clk_2bit_counter:This clock becomes 1 only when the Nth-1 element enters into the FIFO)
clk_2bit_counter <= Sig_cntr_Num(logN) and (not Sig_cntr_Num(0)) ;

two_bit: two_bit_counter port map(clk_2bit_counter,rst,Q_2bit_intr);

Lock1: Lock port map(Q_2bit_intr(0),rst,rd_en_top_intr);

rd_en_top <= rd_en_top_intr and (valid_in or keep_en);

F1: fifo_generator_0 port map(clk,rst_fifo,pixel,en_sig_cntr,rd_en_top,dout_top_intr,full_top,empty_top_intr);

Dtop_intr0: dff port map(dout_top_intr,en_sig_cntr,rst,clk,dout_top_intr0);
Dtop_intr1: dff port map(dout_top_intr0,en_sig_cntr,rst,clk,dout_top_intr1);

D1: dff port map(dout_top_intr1,en_sig_cntr,rst,clk,Q1_intr);

D2: dff port map(Q1_intr,en_sig_cntr,rst,clk,Q2_intr);

D3: dff port map(Q2_intr,en_sig_cntr,rst,clk,Q3_intr);

--wr_en_mid must have 1 clock cycle delay with rd_en_top, otherwise the middle FIFO will place a useless 0 in it's 1st place.
Dff1: dff_one_bit port map(rd_en_top_intr,'1',rst,clk,wr_en_mid_intr);

wr_en_mid <= wr_en_mid_intr and (valid_in or keep_en);

Lock2: Lock port map(Q_2bit_intr(1),rst,rd_en_mid_intr);

rd_en_mid <= rd_en_mid_intr and (valid_in or keep_en);

F2: fifo_generator_0 port map(clk,rst_fifo,dout_top_intr,wr_en_mid,rd_en_mid,dout_mid_intr,full_mid,empty_mid_intr);

Dmid_intr: dff port map(dout_mid_intr,en_sig_cntr,rst,clk,dout_mid_intr0);

D4: dff port map(dout_mid_intr0,en_sig_cntr,rst,clk,Q4_intr);

D5: dff port map(Q4_intr,en_sig_cntr,rst,clk,Q5_intr);

D6: dff port map(Q5_intr,en_sig_cntr,rst,clk,Q6_intr);

Q_2bit_all <= Q_2bit_intr(1) and Q_2bit_intr(0);

--wr_en_bot must have 1 clock cycle delay with rd_en_mid, otherwise the bottom FIFO will place a useless 0 in it's 1st place.
Dff2: dff_one_bit port map(rd_en_mid_intr,'1',rst,clk,wr_en_bot_intr);

wr_en_bot <= wr_en_bot_intr and (valid_in or keep_en);

Lock3: Lock port map(Q_2bit_all,rst,rd_en_bot_intr);

rd_en_bot <= rd_en_bot_intr and (valid_in or keep_en);

F3: fifo_generator_0 port map(clk,rst_fifo,dout_mid_intr,wr_en_bot,rd_en_bot,dout_bot_intr,full_bot,empty_bot_intr);

D7: dff port map(dout_bot_intr,en_sig_cntr ,rst,clk,Q7_intr);

D8: dff port map(Q7_intr,en_sig_cntr,rst,clk,Q8_intr);

D9: dff port map(Q8_intr,en_sig_cntr,rst,clk,Q9_intr);

to_fsm_intr <=Q_2bit_intr(1) and Sig_cntr_Num(1) and Sig_cntr_Num(0);

Lock4: Lock port map(to_fsm_intr,rst,to_fsm);

Q1 <= Q1_intr;
Q2 <= Q2_intr;
Q3 <= Q3_intr;
Q4 <= Q4_intr;
Q5 <= Q5_intr;
Q6 <= Q6_intr;
Q7 <= Q7_intr;
Q8 <= Q8_intr;
Q9 <= Q9_intr;

S_counter <= Sig_cntr_Num;
Q_2bit <= Q_2bit_intr;

--Lock_0 <=Lock_intr;

--rd_top <=rd_en_top;
--rd_mid <=rd_en_mid;
--rd_bot <= rd_en_bot;

--empty_top <= empty_top_intr;
--empty_mid <= empty_mid_intr;
--empty_bot <= empty_bot_intr;

end Behavioral;
