
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;   ---------*** NWE ADDED  ****------ 


entity ATM is
    Port ( Clk : in  STD_LOGIC;
			  
			  btns : in STD_LOGIC := '0';                                  -- enter for in & out --
			  btnu : in STD_LOGIC := '0';									        -- up --
			  btnd : in STD_LOGIC := '0';									        -- down --
			  btnl : in STD_LOGIC := '0';									        -- left --
			  btnr : in STD_LOGIC := '0';									        -- right --
			  
			  switch : in STD_LOGIC_VECTOR (7 downto 0);		        -- 7 switch that we have as an input --
			  
			  
			  sevsegout1 : out STD_LOGIC_VECTOR (6 downto 0);		  -- first 7segment from left --
			  sevsegout2 : out STD_LOGIC_VECTOR (6 downto 0);		  -- second 7segment from left --
			  sevsegout3 : out STD_LOGIC_VECTOR (6 downto 0);		  -- third 7segment from left --
			  sevsegout4 : out STD_LOGIC_VECTOR (6 downto 0);		  -- last 7segment from left --
						
			  LED : out STD_LOGIC_VECTOR (7 downto 0)  := (others => '0'));--------*** NWE ADDED  ****------
			  
end ATM;

architecture Behavioral of ATM is
signal q : STD_LOGIC_VECTOR (14 downto 0);						-- for timer --

signal delayen3 : STD_LOGIC;											-- for 3s --
signal delayen5 : STD_LOGIC;											-- for 5s --

-- start 7seg1 --			---------*** NWE ADDED  ****------
signal sevsegin1 : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
-- end 7seg1 -- 

-- start 7seg2 --			---------*** NWE ADDED  ****------
signal sevsegin2 : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
-- end 7seg2 --

-- start 7seg3 --			---------*** NWE ADDED  ****------
signal sevsegin3 : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
-- end 7seg3 --

-- start 7seg4 --			---------*** NWE ADDED  ****------
signal sevsegin4 : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
-- end 7seg4 --
														---------*** NWE ADDED  ****------ 
signal parten : STD_LOGIC_VECTOR(5 downto 1) := (others => '0');		-- part enable flag --

signal pincor : STD_LOGIC := '1';															-- check if pin is correct or not --

signal res : STD_LOGIC;																-- reset while btnl & btnr both pushed --

SIGNAL account_balance  : INTEGER := 100;    ---------*** NWE ADDED  ****-------- account balance is equal to 100$ for first time
  
SIGNAL deposit_cash_amount  : INTEGER := 0;  ---------*** NWE ADDED  ****-------- amount of cash that will deposit
  
SIGNAL flg_btns_cin  : INTEGER RANGE 0 TO 3; ---------*** NWE ADDED  ****-------- used for detect correct time to go out from CIN
 
SIGNAL flg_blink_cin : STD_LOGIC := '0';---------*** NWE ADDED  ****--------used for blinking in cin position 

SIGNAL flg_check_deposit_cin : STD_LOGIC := '0';---------*** NWE ADDED  ****--------used for validation of deposit amount in cin position

SIGNAL on_off_blink_cin : STD_LOGIC := '0';---------*** NWE ADDED  ****--------used for blinking in cin position

begin
	
	--  start timer for 1s == q(14)  -- 
	process(Clk,res)
	variable i : integer range 0 to ((2**15)-1);
	begin
		if(res='1')then
			i:=0;
		elsif(Clk' event and Clk='1')then
			i:=i+1;
		end if;
		q<= conv_STD_LOGIC_VECTOR(i,15);
		
	end process;
	-- end timer --
	

	
	
	
	-- start counter for 3s & 5s delay --
	process(q(14),res)
	variable j : integer range 1 to 5;	
	begin
		if(res='1')then
			j:=1;
		elsif(q(14)' event and q(14)='1')then
			if(delayen3='1')then       								
				j:=j+1;
				if(j>3)then 
					j:=1;
					--------------*** NEW ADDED ***-----------------
					delayen3 <= '0';
				end if;
			elsif(delayen5='1')then
				j:=j+1;
				if(j>5)then
					j:=1;
					--------------*** NEW ADDED ***-----------------
					delayen5 <= '0';
				end if;
			end if;
		end if;
	end process;
	
	-- end counter --
	
	---------------------------//////////////////////-------------------------------
	
	-- start 7447 --
	
	-- 7seg1 --
	sevsegout1<=("1111110") when sevsegin1=x"0" else
				   ("0110000") when sevsegin1=x"1" else
				   ("1101101") when sevsegin1=x"2" else
				   ("0110011") when sevsegin1=x"3" else
				   ("0110011") when sevsegin1=x"4" else
				   ("1011011") when sevsegin1=x"5" else
				   ("1011111") when sevsegin1=x"6" else
				   ("1110000") when sevsegin1=x"7" else
				   ("1111111") when sevsegin1=x"8" else
				   ("1111011") when sevsegin1=x"9" else
					("0011111") when sevsegin1=x"A" else             --  for showing "b"-- **etit**--
					("1001110") when sevsegin1=x"B" else				 --  for showing "C"	-- **etit**--			
				   ("1100111") when sevsegin1=x"C" else				 --  for showing "P"
					("0011101") when sevsegin1=x"D" else				 --  for showing "o"
					("0000000") when sevsegin1=x"F";  ---------*** NWE ADDED  ****------  -- for turn off

	-- 7seg2 --
	sevsegout2<=("1111110") when sevsegin2=x"0" else
				   ("0110000") when sevsegin2=x"1" else
				   ("1101101") when sevsegin2=x"2" else
				   ("0110011") when sevsegin2=x"3" else
				   ("0110011") when sevsegin2=x"4" else
				   ("1011011") when sevsegin2=x"5" else
				   ("1011111") when sevsegin2=x"6" else
				   ("1110000") when sevsegin2=x"7" else
				   ("1111111") when sevsegin2=x"8" else
				   ("1111011") when sevsegin2=x"9" else
					("0011101") when sevsegin2=x"A" else				-- for showing "o" 
					("0000110") when sevsegin2=x"B" else				-- for showing "I"
					("0110111") when sevsegin2=x"C" else				-- for showing "H"
					("1100111") when sevsegin2=x"D" else				-- for showing "P"
				   ("0011101") when sevsegin2=x"E" else				-- for showing "a"
					("1111101") when sevsegin2=x"10" else				-- for showing "d"---------*** NWE ADDED  ****------ 
					("0000000") when sevsegin1=x"F"; ---------*** NWE ADDED  ****------  -- for turn off
	
	
	-- 7seg3 --
	sevsegout3<=("1111110") when sevsegin3=x"0" else
				   ("0110000") when sevsegin3=x"1" else
				   ("1101101") when sevsegin3=x"2" else
				   ("0110011") when sevsegin3=x"3" else
				   ("0110011") when sevsegin3=x"4" else
				   ("1011011") when sevsegin3=x"5" else
				   ("1011111") when sevsegin3=x"6" else
				   ("1110000") when sevsegin3=x"7" else
				   ("1111111") when sevsegin3=x"8" else
				   ("1111011") when sevsegin3=x"9" else
					("0001110") when sevsegin3=x"A" else				-- for showing "L"
					("0011100") when sevsegin3=x"B" else				-- for showing "u"
				   ("0010101") when sevsegin3=x"C" else				-- for showing "n"
					("1001111") when sevsegin3=x"D" else				-- for showing "E"
					("0000110") when sevsegin3=x"E" else				--	for showing "I"
					("1100111") when sevsegin3=x"10" else				--	for showing "P"---------*** NWE ADDED  ****------ 
					("0000000") when sevsegin1=x"F"; ---------*** NWE ADDED  ****------  -- for turn off
			
	-- 7seg4 --
	sevsegout4<=("1111110") when sevsegin4=x"0" else
				   ("0110000") when sevsegin4=x"1" else
				   ("1101101") when sevsegin4=x"2" else
				   ("0110011") when sevsegin4=x"3" else
				   ("0110011") when sevsegin4=x"4" else
				   ("1011011") when sevsegin4=x"5" else
				   ("1011111") when sevsegin4=x"6" else
				   ("1110000") when sevsegin4=x"7" else
				   ("1111111") when sevsegin4=x"8" else
				   ("1111011") when sevsegin4=x"9" else
					("1111011") when sevsegin4=x"A" else				-- for showing "t"
					("1111011") when sevsegin4=x"B" else				--	for showing "c"
					("1111011") when sevsegin4=x"C" else				-- for showing "n"
				   ("0000000") when sevsegin4=x"F"; ---------*** NWE ADDED  ****------  -- for turn off
					
	----------------------///////////////----------------------------
	
	
	
	
	
	
	
	
	
	
	
	---------------------option part---------------------------------

								---** NEW ADDED**----
		process(res,btnu,btnd,btns,clk)
		variable cursor : integer range 1 to 5;
		begin
		
		if(res='1')then          -- res --
			cursor:=1;
		end if;
		
		
		if(pincor='1')then
			
			---------....cursor=1....----------
			
			if(cursor=1)then 
			
---------------------------------------*** NWE ADDED  ****-------------------------------------------------
				
				
				
				------------------ When the user chooses Balance Inquiry ------------------
				IF(parten(1)='1') THEN
					IF (account_balance <= 9 and RISING_EDGE(clk)) THEN
						LED(2) <= '1';
						
						sevsegin4 <= STD_LOGIC_VECTOR(TO_UNSIGNED(account_balance MOD 10, 4));
						sevsegin3 <= X"0F";
						sevsegin2 <= X"0F";
						sevsegin1 <= X"F";
						
					ELSIF((account_balance >= 10) AND (account_balance <= 99) and RISING_EDGE(clk)) THEN
						LED(2) <= '1';
						
						sevsegin4 <= STD_LOGIC_VECTOR(TO_UNSIGNED(account_balance MOD 10, 4));
						sevsegin3 <= STD_LOGIC_VECTOR(TO_UNSIGNED((account_balance / 10) MOD 10, 8));
						sevsegin2 <= X"0F";
						sevsegin1 <= X"F";
						
					ELSIF((account_balance <= 999) AND (account_balance >= 100) and RISING_EDGE(clk)) THEN
						LED(2) <= '1';
						
						sevsegin4 <= STD_LOGIC_VECTOR(TO_UNSIGNED(account_balance MOD 10, 4));
						sevsegin3 <= STD_LOGIC_VECTOR(TO_UNSIGNED((account_balance / 10) MOD 10, 8));
						sevsegin2 <= STD_LOGIC_VECTOR(TO_UNSIGNED((account_balance / 100) MOD 10, 8));
						sevsegin1 <= X"F";
					
					ELSIF(RISING_EDGE(clk)) THEN
						LED(2) <= '1';
						
						sevsegin4 <= STD_LOGIC_VECTOR(TO_UNSIGNED(account_balance MOD 10, 4));
						sevsegin3 <= STD_LOGIC_VECTOR(TO_UNSIGNED((account_balance / 10) MOD 10, 8));
						sevsegin2 <= STD_LOGIC_VECTOR(TO_UNSIGNED((account_balance / 100) MOD 10, 8));
						sevsegin1 <= STD_LOGIC_VECTOR(TO_UNSIGNED((account_balance / 1000) MOD 10, 4));
						
					END IF;
				
				
				--///////--showing "baL"--///////--
				ELSE 
					sevsegin1<= x"A";
					sevsegin2<= x"0E";
					sevsegin3<= x"0A";
					sevsegin4<= x"F";
				END IF;
-----------------------------------------------***  *** ---------------------------------------------------
				if(btns='1' and RISING_EDGE(clk))then
				 
					if(parten(1) = '0') then
						parten(1) <= '1';
						LED(1) <= '1';
					else 
						parten(1) <= '0';
						LED(1) <= '0';
					end if;
				end if;
				---------------------------------
				if(btnu='1')then
					cursor:=5;
					parten(1) <= '0';
					LED(1) <= '0';
				end if;
				
				if(btnd='1')then
					cursor:=3;
					parten(1) <= '0';
					LED(1) <= '0';
				end if;
				
			end if;
			
		
			
			-----------......cursor=3......--------------
			
			if(cursor=3)then 
			
---------------------------------------*** NWE ADDED  ****-------------------------------------------------
			
				------------------ When the user chooses Cash Deposit ------------------
				--///////--showing "baL"--///////--
				IF(flg_btns_cin = 0) THEN
					sevsegin1<= x"B";
					sevsegin2<= x"0B";
					sevsegin3<= x"0C";
					sevsegin4<= x"F";
					
				ELSIF(flg_btns_cin = 1) THEN
					IF (deposit_cash_amount <= 9) THEN
						sevsegin4 <= STD_LOGIC_VECTOR(TO_UNSIGNED(deposit_cash_amount MOD 10, 4));
						sevsegin3 <= X"0F";
						sevsegin2 <= X"0F";
						sevsegin1 <= X"F";
						
					ELSIF((deposit_cash_amount >= 10) AND (deposit_cash_amount <= 99)) THEN
						sevsegin4 <= STD_LOGIC_VECTOR(TO_UNSIGNED(deposit_cash_amount MOD 10, 4));
						sevsegin3 <= STD_LOGIC_VECTOR(TO_UNSIGNED((deposit_cash_amount / 10) MOD 10, 8));
						sevsegin2 <= X"0F";
						sevsegin1 <= X"F";
						
					ELSE
						sevsegin4 <= STD_LOGIC_VECTOR(TO_UNSIGNED(deposit_cash_amount MOD 10, 4));
						sevsegin3 <= STD_LOGIC_VECTOR(TO_UNSIGNED((deposit_cash_amount / 10) MOD 10, 8));
						sevsegin2 <= STD_LOGIC_VECTOR(TO_UNSIGNED((deposit_cash_amount / 100) MOD 10, 8));
						sevsegin1 <= X"F";
						
					END IF;
				
				ELSIF((flg_btns_cin = 2) AND (flg_blink_cin = '0') AND (flg_check_deposit_cin = '0')) THEN
					on_off_blink_cin <= '0';
					IF(deposit_cash_amount + account_balance > 1500) THEN
						flg_check_deposit_cin <= '1';
						delayen5 <= '1';
					ELSE
						flg_blink_cin <= '1';
						delayen5 <= '1';
					END IF;
					
				ELSIF(flg_btns_cin = 3) THEN
					flg_btns_cin <= 0;
				
				END IF;
				
				------------- blinking or display ODP---------------------
				IF(flg_btns_cin = 2) THEN
				
				-------- blinking --------
					IF(flg_blink_cin = '1') THEN
						IF(delayen5 = '1') THEN
							IF((on_off_blink_cin = '0') AND q(13) = '1') THEN
								sevsegin1<= x"F";
								sevsegin2<= x"0F";
								sevsegin3<= x"0F";
								sevsegin4<= x"F";
								on_off_blink_cin <= '1';
							ELSE
								IF (account_balance <= 9) THEN
									sevsegin4 <= STD_LOGIC_VECTOR(TO_UNSIGNED(account_balance MOD 10, 4));
									sevsegin3 <= X"0F";
									sevsegin2 <= X"0F";
									sevsegin1 <= X"F";
									
								ELSIF((account_balance >= 10) AND (account_balance <= 99)) THEN
									sevsegin4 <= STD_LOGIC_VECTOR(TO_UNSIGNED(account_balance MOD 10, 4));
									sevsegin3 <= STD_LOGIC_VECTOR(TO_UNSIGNED((account_balance / 10) MOD 10, 8));
									sevsegin2 <= X"0F";
									sevsegin1 <= X"F";
									
								ELSIF((account_balance <= 999) AND (account_balance >= 100)) THEN
									sevsegin4 <= STD_LOGIC_VECTOR(TO_UNSIGNED(account_balance MOD 10, 4));
									sevsegin3 <= STD_LOGIC_VECTOR(TO_UNSIGNED((account_balance / 10) MOD 10, 8));
									sevsegin2 <= STD_LOGIC_VECTOR(TO_UNSIGNED((account_balance / 100) MOD 10, 8));
									sevsegin1 <= X"F";
								
								ELSE
									sevsegin4 <= STD_LOGIC_VECTOR(TO_UNSIGNED(account_balance MOD 10, 4));
									sevsegin3 <= STD_LOGIC_VECTOR(TO_UNSIGNED((account_balance / 10) MOD 10, 8));
									sevsegin2 <= STD_LOGIC_VECTOR(TO_UNSIGNED((account_balance / 100) MOD 10, 8));
									sevsegin1 <= STD_LOGIC_VECTOR(TO_UNSIGNED((account_balance / 1000) MOD 10, 4));
									
								END IF;
								on_off_blink_cin <= '0';
								
							END IF;
							
						ELSE
							flg_btns_cin <= 3;
							flg_blink_cin <= '0';
							
						END IF;
					------- display ODP --------	
					ELSIF(flg_check_deposit_cin = '1' AND q(13) = '1') THEN
						IF(delayen5 = '1') THEN
							IF(on_off_blink_cin = '0') THEN
								sevsegin1<= x"F";
								sevsegin2<= x"0F";
								sevsegin3<= x"0F";
								sevsegin4<= x"F";
								on_off_blink_cin <= '1';
							ELSE
								sevsegin1<= x"D";
								sevsegin2<= x"10";
								sevsegin3<= x"10";
								sevsegin4<= x"F";
								on_off_blink_cin <= '0';
								
							END IF;
							
						ELSE
							flg_btns_cin <= 3;
							flg_check_deposit_cin <= '0';
							
						END IF;
					
					END IF;
				END IF;

-----------------------------------------------***  *** ---------------------------------------------------
				
				if(btns='1')then
					flg_btns_cin <= flg_btns_cin + 1;
					IF(flg_btns_cin = 0) THEN
						LED(4) <= '1' ;
					ELSIF(flg_btns_cin = 0) THEN
						LED(4) <= '0';
					END IF;
					
				end if;
				----------------------------------
				if(btnu='1')then
					cursor:=2;
				end if;
				
				if(btnd='1')then
					cursor:=4;
				end if;
				
			end if;
			-----------.........end 3......--------------
			
			

			
				
		end if;

		end process;
		
		
		---------------------end option part----------------------
		
		
	
	
---------------------------------------*** NWE ADDED  ****-------------------------------------------------	

	----------- checking the buttons for increase deposit amount------------------
	PROCESS(res,btnu,btnd,btnl,btnr,btns)
	BEGIN
		IF(flg_btns_cin = 1) THEN
		
			IF((btnu = '1') AND (deposit_cash_amount <= 240)) THEN
				deposit_cash_amount <= deposit_cash_amount + 10;
			
			ELSIF((btnd = '1') AND (deposit_cash_amount <= 230)) THEN
				deposit_cash_amount <= deposit_cash_amount + 20;
			
			ELSIF((btnl = '1') AND (deposit_cash_amount <= 200)) THEN
				deposit_cash_amount <= deposit_cash_amount + 50;
			
			ELSIF((btnr = '1') AND (deposit_cash_amount <= 150)) THEN
				deposit_cash_amount <= deposit_cash_amount +100;
			
			END IF;
		
		END IF;

	END PROCESS;
	
	
					
					
	--------reset part---------------		deposit_cash_amount
					
	process(btnr,btnl)
	begin
		res <= btnr and btnl;
	end process;
	---------end reset part----------
	
	
end Behavioral;

