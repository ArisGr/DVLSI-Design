library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
use IEEE.math_real."log2";
use IEEE.math_real."ceil";


entity ALU is
generic( N: integer );
  Port (
  
  clk : in std_logic;
  alu_init : in  std_logic;
  Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9 : in std_logic_vector(7 downto 0);
  xcounter,ycounter : in std_logic_vector(integer(ceil(log2(real(N)))) downto 0);
  R,G,B : out std_logic_vector(7 downto 0);
  rst : in std_logic
  );
end ALU;

architecture Behavioral of ALU is

constant logN: integer :=integer(ceil(log2(real(N))));
signal sig : integer; 
signal sig1 : integer; 
signal one_binary : std_logic_vector(logN downto 0);
signal N_binary : std_logic_vector(logN downto 0);
begin

one_binary(logN downto 1) <= (others =>'0');
one_binary(0) <= '1';

N_binary(logN) <='1';
N_binary(logN - 1 downto 0) <= (others =>'0');

process(clk,alu_init,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,xcounter,ycounter,rst)

begin

if rst = '0' then
    R <= (others => '0');
    G <= (others => '0');
    B <= (others => '0');
        
else
if(rising_edge(clk)) then
  if(alu_init='1') then

        if(ycounter = one_binary) then
            if(xcounter = one_binary) then
                G <= Q5;
               -- sig <= conv_integer(Q2) / 2;
                R <= std_logic_vector(to_unsigned(conv_integer(Q2) / 2, 8));
                --sig1 <= conv_integer(Q4) / 2;
                B <= std_logic_vector(to_unsigned(conv_integer(Q4) / 2, 8)); 
                
            elsif(xcounter = N_binary) then
                B <= Q5;
                --sig1 <= conv_integer(Q3) /4;
                R <= std_logic_vector(to_unsigned(conv_integer(Q3) /4, 8));
                --sig <= (conv_integer(Q2) + conv_integer(Q6)) / 4;
                G <= std_logic_vector(to_unsigned((conv_integer(Q2) + conv_integer(Q6)) / 4, 8));
             
            elsif(xcounter(0) = '1' and xcounter /= one_binary) then
                G <= Q5;
                --sig1 <= conv_integer(Q2)/2;
                R <= std_logic_vector(to_unsigned(conv_integer(Q2)/2, 8));
                --sig <= (conv_integer(Q4) + conv_integer(Q6)) / 2;
                B <= std_logic_vector(to_unsigned((conv_integer(Q4) + conv_integer(Q6)) / 2, 8));
            
            elsif(xcounter(0) = '0' and xcounter /= N_binary) then 
                B <= Q5;
                --sig <= (conv_integer(Q1) + conv_integer(Q3)) / 4;
                R <= std_logic_vector(to_unsigned((conv_integer(Q1) + conv_integer(Q3)) / 4, 8));
                --sig1 <= (conv_integer(Q2) + conv_integer(Q4) + conv_integer(Q6)) / 4;
                G <= std_logic_vector(to_unsigned((conv_integer(Q2) + conv_integer(Q4) + conv_integer(Q6)) / 4, 8));   
            end if;
            
        elsif(ycounter = N_binary) then   
                    if(xcounter = one_binary) then
                        R <= Q5;
                        --sig1 <= conv_integer(Q7)/4;
                        B <= std_logic_vector(to_unsigned(conv_integer(Q7)/4, 8));
                        --sig <= (conv_integer(Q4) + conv_integer(Q8)) / 4;
                        G <= std_logic_vector(to_unsigned((conv_integer(Q4) + conv_integer(Q8)) / 4, 8));
                        
                    elsif(xcounter = N_binary) then
                        G <= Q5;
                        --sig <= conv_integer(Q6) /2;
                        R <= std_logic_vector(to_unsigned(conv_integer(Q6) /2, 8));  
                        --sig1 <= conv_integer(Q8) /2;               
                        B <= std_logic_vector(to_unsigned(conv_integer(Q8) /2, 8));
                      
                    elsif(xcounter(0) = '1' and xcounter /= one_binary) then
                        R <= Q5;
                        --sig <= (conv_integer(Q7) + conv_integer(Q9)) / 4;
                        B <= std_logic_vector(to_unsigned((conv_integer(Q7) + conv_integer(Q9)) / 4, 8));
                        --sig1 <= (conv_integer(Q4) + conv_integer(Q6) + conv_integer(Q8)) / 4;
                        G <= std_logic_vector(to_unsigned((conv_integer(Q4) + conv_integer(Q6) + conv_integer(Q8)) / 4, 8));
                    
                    elsif(xcounter(0) = '0' and xcounter /= N_binary) then
                        G <= Q5;
                        --sig1 <= conv_integer(Q8) /2;
                        B <= std_logic_vector(to_unsigned(conv_integer(Q8) /2, 8));
                        --sig <= (conv_integer(Q4) + conv_integer(Q6)) / 2;
                        R <= std_logic_vector(to_unsigned((conv_integer(Q4) + conv_integer(Q6)) / 2, 8));
                    end if;    
                    
        elsif (ycounter(0) = '1' and ycounter /= one_binary) then         
                        if(xcounter = one_binary) then
                            G <= Q5;
                            --sig <= (conv_integer(Q2) + conv_integer(Q8)) / 4;
                            R <= std_logic_vector(to_unsigned((conv_integer(Q2) + conv_integer(Q8)) / 2, 8));
                            --sig1 <= conv_integer(Q4)/2;
                            B <= std_logic_vector(to_unsigned(conv_integer(Q4)/2, 8));
                            
                        elsif(xcounter = N_binary) then
                            B <= Q5;
                            --sig <= (conv_integer(Q3) + conv_integer(Q9)) / 4;
                            R <= std_logic_vector(to_unsigned((conv_integer(Q3) + conv_integer(Q9)) / 4, 8));
                            --sig1 <= (conv_integer(Q2) + conv_integer(Q8) + conv_integer(Q6)) / 4;
                            G <= std_logic_vector(to_unsigned((conv_integer(Q2) + conv_integer(Q8) + conv_integer(Q6)) / 4, 8));
                          
                        elsif(xcounter(0) = '1' and xcounter /= one_binary) then
                            G <= Q5;
                            --sig <= (conv_integer(Q2) + conv_integer(Q8)) / 2;
                            R <= std_logic_vector(to_unsigned((conv_integer(Q2) + conv_integer(Q8)) / 2, 8));
                            --sig1 <= (conv_integer(Q4) + conv_integer(Q6)) / 2;
                            B <= std_logic_vector(to_unsigned((conv_integer(Q4) + conv_integer(Q6)) / 2, 8));
                        
                        elsif(xcounter(0) = '0' and xcounter /= N_binary) then
                            B <= Q5;
                            --sig <= (conv_integer(Q2) + conv_integer(Q8) + conv_integer(Q4) + conv_integer(Q6)) / 4;
                            G <= std_logic_vector(to_unsigned((conv_integer(Q2) + conv_integer(Q8) + conv_integer(Q4) + conv_integer(Q6)) / 4, 8));
                            --sig1 <= (conv_integer(Q1) + conv_integer(Q3) + conv_integer(Q7) + conv_integer(Q9)) / 4;
                            R <= std_logic_vector(to_unsigned((conv_integer(Q1) + conv_integer(Q3) + conv_integer(Q7) + conv_integer(Q9)) / 4, 8));   
                        end if;     
                    
        elsif (ycounter(0) = '0' and ycounter /= N_binary) then 
                                    if(xcounter = one_binary) then
                                        R <= Q5;
                                        --sig <= (conv_integer(Q2) + conv_integer(Q8) + conv_integer(Q4)) / 4;
                                        G <= std_logic_vector(to_unsigned((conv_integer(Q2) + conv_integer(Q8) + conv_integer(Q4)) / 4, 8));
                                        --sig1 <= (conv_integer(Q1) + conv_integer(Q7)) / 4;
                                        B <= std_logic_vector(to_unsigned((conv_integer(Q1) + conv_integer(Q7)) / 4, 8));
                                        
                                    elsif(xcounter = N_binary) then
                                        G <= Q5;
                                        --sig <= (conv_integer(Q2) + conv_integer(Q8)) / 2;
                                        B <= std_logic_vector(to_unsigned((conv_integer(Q2) + conv_integer(Q8)) / 2, 8));
                                        --sig1 <= conv_integer(Q6)/2;
                                        R <= std_logic_vector(to_unsigned(conv_integer(Q6)/2, 8));
                                      
                                    elsif(xcounter(0) = '0' and xcounter /= N_binary) then
                                        G <= Q5;
                                        --sig <= (conv_integer(Q2) + conv_integer(Q8)) / 2;
                                        B <= std_logic_vector(to_unsigned((conv_integer(Q2) + conv_integer(Q8)) / 2, 8));
                                        --sig1 <= (conv_integer(Q4) + conv_integer(Q6)) / 2;
                                        R <= std_logic_vector(to_unsigned((conv_integer(Q4) + conv_integer(Q6)) / 2, 8));
                                    
                                    elsif(xcounter(0) = '1' and xcounter /= one_binary) then 
                                        R <= Q5;
                                        --sig <= (conv_integer(Q2) + conv_integer(Q8) + conv_integer(Q4) + conv_integer(Q6)) / 4;
                                        G <= std_logic_vector(to_unsigned((conv_integer(Q2) + conv_integer(Q8) + conv_integer(Q4) + conv_integer(Q6)) / 4, 8));
                                        --sig1 <= (conv_integer(Q1) + conv_integer(Q3) + conv_integer(Q7) + conv_integer(Q9)) / 4;
                                        B <= std_logic_vector(to_unsigned((conv_integer(Q1) + conv_integer(Q3) + conv_integer(Q7) + conv_integer(Q9)) / 4, 8));   
                                    end if; 
        end if;
      end if;
    end if;
  end if;  
                          
end process;                
                   

end Behavioral;
