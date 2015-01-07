----------------------------------------------------------------------------------
-- Copyright (c) 2014, Luis Ardila
-- E-mail: leardilap@unal.edu.co
--
-- Description:
--
-- Revisions: 
-- Date        	Version    	Author    		Description
-- 28/11/2014    	1.0    		Luis Ardila    File created
--
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY TEST_COUNTER IS 
PORT (	
			clk														 	: in std_logic;
			reset_n															: in std_logic;
			ada_fifo_in_valid                                 : out  std_logic                     := 'X';             -- valid
			ada_fifo_in_data                                  : out  std_logic_vector(31 downto 0) := (others => 'X'); -- data
			ada_fifo_in_ready                                 : in std_logic                                        -- ready
);
END TEST_COUNTER;

ARCHITECTURE TEST_COUNTER_ARCH OF TEST_COUNTER IS 

signal sData : STD_LOGIC_VECTOR(13 downto 0) := (OTHERS => '0');
signal sValid : STD_LOGIC := '0';
signal cnt : integer range 0 to 1000 := 0;

BEGIN

	COUNTER : PROCESS (reset_n, clk) IS
	BEGIN 
		IF reset_n = '0' THEN
			sData <= (OTHERS => '0');
			sValid <= '0';
			cnt <= 0;
		ELSIF rising_edge(clk) THEN
			IF ada_fifo_in_ready = '1' and cnt < 1000 THEN
				sData <= STD_LOGIC_VECTOR(UNSIGNED(sData) + 1);
				cnt <= cnt + 1;
				sValid <= '1';
			else 
				sValid <= '0';
			END IF;	
		END IF;
	END PROCESS COUNTER;
	
	ada_fifo_in_data <= x"0000" & b"00" & sData;
	ada_fifo_in_valid <= sValid;
	
END TEST_COUNTER_ARCH;