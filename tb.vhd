LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use std.textio.all;
use ieee.std_logic_textio.all; -- require for writing std_logic etc.
 
ENTITY tb IS
END tb;
 
ARCHITECTURE behavior OF tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ATM 
    PORT(
         Clk : IN  std_logic;
         btns : IN  std_logic;
         btnu : IN  std_logic;
         btnd : IN  std_logic;
         btnl : IN  std_logic;
         btnr : IN  std_logic;
         switch : IN  std_logic_vector(7 downto 0);
         sevsegout1 : OUT  std_logic_vector(6 downto 0);
         sevsegout2 : OUT  std_logic_vector(6 downto 0);
         sevsegout3 : OUT  std_logic_vector(6 downto 0);
         sevsegout4 : OUT  std_logic_vector(6 downto 0);
         LED : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal btns : std_logic := '0';
   signal btnu : std_logic := '0';
   signal btnd : std_logic := '0';
   signal btnl : std_logic := '0';
   signal btnr : std_logic := '0';
   signal switch : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal sevsegout1 : std_logic_vector(6 downto 0);
   signal sevsegout2 : std_logic_vector(6 downto 0);
   signal sevsegout3 : std_logic_vector(6 downto 0);
   signal sevsegout4 : std_logic_vector(6 downto 0);
   signal LED : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
	
	file output_buf : text; 
 
BEGIN
 
		tb : PROCESS
		variable wb : line;
		
	BEGIN
		
		file_open(output_buf, "./write_file_ex.txt",  write_mode);
-------------------------------------------------------------------------------------------------------		
		wait for 10 ns;
      write( wb, string'("01"));write( wb, btns);write( wb, btnu);write( wb, btnd);write( wb, btnl);write( wb, btnr);write( wb, sevsegout1);write( wb, sevsegout2);write( wb, sevsegout3);write( wb, sevsegout4);write( wb, LED);writeline(output_buf,  wb); 
		
		wait for 30 ns;
		btns <= '1';
		
      write( wb, string'("03"));write( wb, btns);write( wb, btnu);write( wb, btnd);write( wb, btnl);write( wb, btnr);write( wb, sevsegout1);write( wb, sevsegout2);write( wb, sevsegout3);write( wb, sevsegout4);write( wb, LED);writeline(output_buf,  wb); 
		
		wait for 10 ns;
		btns <= '0';
		
      write( wb, string'("01"));write( wb, btns);write( wb, btnu);write( wb, btnd);write( wb, btnl);write( wb, btnr);write( wb, sevsegout1);write( wb, sevsegout2);write( wb, sevsegout3);write( wb, sevsegout4);write( wb, LED);writeline(output_buf,  wb); 

		wait for 50 ns;
		btns <= '1';
		
      write( wb, string'("05"));write( wb, btns);write( wb, btnu);write( wb, btnd);write( wb, btnl);write( wb, btnr);write( wb, sevsegout1);write( wb, sevsegout2);write( wb, sevsegout3);write( wb, sevsegout4);write( wb, LED);writeline(output_buf,  wb); 
		
		wait for 10 ns;
		btns <= '0';
		
      write( wb, string'("01"));write( wb, btns);write( wb, btnu);write( wb, btnd);write( wb, btnl);write( wb, btnr);write( wb, sevsegout1);write( wb, sevsegout2);write( wb, sevsegout3);write( wb, sevsegout4);write( wb, LED);writeline(output_buf,  wb); 

		wait for 20 ns;
		btnd <= '1';
		
      write( wb, string'("02"));write( wb, btns);write( wb, btnu);write( wb, btnd);write( wb, btnl);write( wb, btnr);write( wb, sevsegout1);write( wb, sevsegout2);write( wb, sevsegout3);write( wb, sevsegout4);write( wb, LED);writeline(output_buf,  wb); 
 
		wait for 10 ns;
		btnd <= '0';
		
		write( wb, string'("01"));write( wb, btns);write( wb, btnu);write( wb, btnd);write( wb, btnl);write( wb, btnr);write( wb, sevsegout1);write( wb, sevsegout2);write( wb, sevsegout3);write( wb, sevsegout4);write( wb, LED);writeline(output_buf,  wb); 
	
		wait for 30 ns;	
		btns <= '1';
		
      write( wb, string'("03"));write( wb, btns);write( wb, btnu);write( wb, btnd);write( wb, btnl);write( wb, btnr);write( wb, sevsegout1);write( wb, sevsegout2);write( wb, sevsegout3);write( wb, sevsegout4);write( wb, LED);writeline(output_buf,  wb); 
		
		
		wait for 10 ns;
		btns <= '0';
		
      write( wb, string'("01"));write( wb, btns);write( wb, btnu);write( wb, btnd);write( wb, btnl);write( wb, btnr);write( wb, sevsegout1);write( wb, sevsegout2);write( wb, sevsegout3);write( wb, sevsegout4);write( wb, LED);writeline(output_buf,  wb); 
		
		wait for 30 ns;
		btns <= '1';
		
      write( wb, string'("03"));write( wb, btns);write( wb, btnu);write( wb, btnd);write( wb, btnl);write( wb, btnr);write( wb, sevsegout1);write( wb, sevsegout2);write( wb, sevsegout3);write( wb, sevsegout4);write( wb, LED);writeline(output_buf,  wb); 
		
		wait for 10 ns;
		btns <= '0';
		
      write( wb, string'("01"));write( wb, btns);write( wb, btnu);write( wb, btnd);write( wb, btnl);write( wb, btnr);write( wb, sevsegout1);write( wb, sevsegout2);write( wb, sevsegout3);write( wb, sevsegout4);write( wb, LED);writeline(output_buf,  wb); 
		
				wait for 20 ns;
		btnd <= '1';
		
		write( wb, string'("02"));write( wb, btns);write( wb, btnu);write( wb, btnd);write( wb, btnl);write( wb, btnr);write( wb, sevsegout1);write( wb, sevsegout2);write( wb, sevsegout3);write( wb, sevsegout4);write( wb, LED);writeline(output_buf,  wb); 

		wait for 10 ns;
		btnd <= '0';
		
		write( wb, string'("01"));write( wb, btns);write( wb, btnu);write( wb, btnd);write( wb, btnl);write( wb, btnr);write( wb, sevsegout1);write( wb, sevsegout2);write( wb, sevsegout3);write( wb, sevsegout4);write( wb, LED);writeline(output_buf,  wb); 

		wait for 20 ns;
		btnd <= '1';
		
		write( wb, string'("02"));write( wb, btns);write( wb, btnu);write( wb, btnd);write( wb, btnl);write( wb, btnr);write( wb, sevsegout1);write( wb, sevsegout2);write( wb, sevsegout3);write( wb, sevsegout4);write( wb, LED);writeline(output_buf,  wb); 

		wait for 10 ns;
		btnd <= '0';
		
		write( wb, string'("01"));write( wb, btns);write( wb, btnu);write( wb, btnd);write( wb, btnl);write( wb, btnr);write( wb, sevsegout1);write( wb, sevsegout2);write( wb, sevsegout3);write( wb, sevsegout4);write( wb, LED);writeline(output_buf,  wb); 
		
		wait for 30 ns;
		btns <= '1';
		
      write( wb, string'("03"));write( wb, btns);write( wb, btnu);write( wb, btnd);write( wb, btnl);write( wb, btnr);write( wb, sevsegout1);write( wb, sevsegout2);write( wb, sevsegout3);write( wb, sevsegout4);write( wb, LED);writeline(output_buf,  wb); 
		
		wait for 10 ns;
		btns <= '0';
		
		write( wb, string'("01"));write( wb, btns);write( wb, btnu);write( wb, btnd);write( wb, btnl);write( wb, btnr);write( wb, sevsegout1);write( wb, sevsegout2);write( wb, sevsegout3);write( wb, sevsegout4);write( wb, LED);writeline(output_buf,  wb); 

		wait for 30 ns;
		btns <= '1';
		
		write( wb, string'("03"));write( wb, btns);write( wb, btnu);write( wb, btnd);write( wb, btnl);write( wb, btnr);write( wb, sevsegout1);write( wb, sevsegout2);write( wb, sevsegout3);write( wb, sevsegout4);write( wb, LED);writeline(output_buf,  wb); 
	
		wait for 10 ns;
		btns <= '0';
		
		write( wb, string'("01"));write( wb, btns);write( wb, btnu);write( wb, btnd);write( wb, btnl);write( wb, btnr);write( wb, sevsegout1);write( wb, sevsegout2);write( wb, sevsegout3);write( wb, sevsegout4);write( wb, LED);writeline(output_buf,  wb); 

		


		file_close(output_buf);
      wait; -- indefinitely suspend process
   end process;

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ATM PORT MAP (
          Clk => Clk,
          btns => btns,
          btnu => btnu,
          btnd => btnd,
          btnl => btnl,
          btnr => btnr,
          switch => switch,
          sevsegout1 => sevsegout1,
          sevsegout2 => sevsegout2,
          sevsegout3 => sevsegout3,
          sevsegout4 => sevsegout4,
          LED => LED
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
