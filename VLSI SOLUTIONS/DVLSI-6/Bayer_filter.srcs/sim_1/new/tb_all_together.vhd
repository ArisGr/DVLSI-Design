library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
use IEEE.math_real."log2";
use IEEE.math_real."ceil";

use IEEE.std_logic_textio.all;

library std;
use std.textio.all;

entity tb_all_together is
end tb_all_together;

architecture Behavioral of tb_all_together is

component all_together is

generic(N : integer :=16);

port(
clk,rst_n,valid_in,new_image: in std_logic;
pixel : in std_logic_vector(7 downto 0);
image_finished,valid_out : out std_logic;
R,G,B : out std_logic_vector(7 downto 0)
--S_counter: out std_logic_vector(integer(ceil(log2(real(N)))) downto 0);
--Q_2bit:out std_logic_vector(1 downto 0);
--Qline,Qcolumn: out std_logic_vector(integer(ceil(log2(real(N)))) downto 0)
);

end component;

signal clk,valid_in,new_image,image_finished,valid_out: std_logic :='0';
signal rst_n: std_logic :='1';
signal pixel,R,G,B: std_logic_vector(7 downto 0) :=(others =>'0');

--signal S_counter:  std_logic_vector(5 downto 0) :="000000";
--signal Q_2bit: std_logic_vector(1 downto 0) := "00";
--signal Qline,Qcolumn : std_logic_vector(5 downto 0) :="000000";

file input_buf: text;

begin


A: all_together generic map(16) port map(clk,rst_n,valid_in,new_image,pixel,image_finished,valid_out,R,G,B); 

proc1: process is
begin

wait for 0.5ns;
clk <= '1';
wait for 0.5ns;
clk <= '0';

end process proc1;

proc2: process is
begin

wait for 0.5ns;
rst_n <='0';
wait for 0.5ns; 
rst_n <='1';
wait;

end process proc2;

proc3: process is
begin

wait for 1ns;
valid_in <='1';
wait for 256ns;
valid_in <='0';
wait;

end process proc3;

proc4: process is
begin

wait for 1ns;
new_image <='1';
wait for 1ns;
new_image <='0';
wait;

end process proc4;

tb: process is

variable read_from_input: line;
variable value: integer;
variable space : character;

begin



file_open(input_buf, "C:\Users\rekaf\Downloads\Bayer_filter\Bayer_filter\Bayer_filter.srcs\sim_1\new\test_inputs.txt", READ_MODE); 

wait for 1ns;

while (not endfile(input_buf)) loop

readline(input_buf , read_from_input);

for i in 1 to 16 loop

read(read_from_input , value);
read(read_from_input , space);

pixel <= std_logic_vector(to_unsigned(value, 8));

wait for 1ns;

end loop;

end loop;

file_close(input_buf);

pixel <= (others =>'0');

wait;

end process tb;

end Behavioral;
