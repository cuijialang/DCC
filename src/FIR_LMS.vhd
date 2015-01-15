----------------------------------------------------------------------------------
-- Copyright (c) 2014, Luis Ardila
-- E-mail: leardilap@unal.edu.co
--
-- Description: Adaptive filter with 2048 coeficients, 2500 times decimation 
--					 and upsampling.
--					
--
-- Revisions: 
-- Date        	Version    	Author    		Description
-- 14/01/2015    	1.0    		Luis Ardila    File created
--
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

LIBRARY lpm;
USE lpm.lpm_components.ALL;

ENTITY FIR_LMS IS 
GENERIC(	
	W1 : INTEGER := 18;
	W2 : INTEGER := 36;
	L 	: INTEGER := 2048
	);
PORT (
	CLK				: IN STD_LOGIC;
	reset_n			: IN STD_LOGIC;
	-- ADC DATA
	ADA_DOUT			: IN STD_LOGIC_VECTOR(13 DOWNTO 0);
	ADB_DOUT			: IN STD_LOGIC_VECTOR(13 DOWNTO 0);
	-- DAC DATA
	DA_DIN			: OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
	DB_DIN			: OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
	-- TEST PORT
	e_out				: OUT STD_LOGIC_VECTOR(W2-1 DOWNTO 0);
	y_out				: OUT STD_LOGIC_VECTOR(W2-1 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE FIR_LMS_ARCH OF FIR_LMS IS

	TYPE ARRAY_W1 IS ARRAY (0 TO L-1) OF STD_LOGIC_VECTOR(W1-1 DOWNTO 0);
	TYPE ARRAY_W2 IS ARRAY (0 TO L-1) OF STD_LOGIC_VECTOR(W2-1 DOWNTO 0);
	TYPE STATE_TYPE IS (INIT, SHIFT_X, MULT_MUE, MULT_XH, MULT_XMUE, UPDATE_H, SCALING, WAITING, T1, T2, T3);
	SIGNAL STATE : STATE_TYPE := INIT;

	SIGNAL x 	: ARRAY_W1 := (OTHERS => (OTHERS => '0'));						-- data array
	SIGNAL h 	: ARRAY_W1 := (OTHERS => (OTHERS => '0'));						-- coeff array
	
	SIGNAL x_in 		: STD_LOGIC_VECTOR(W1-1 DOWNTO 0) := (OTHERS => '0');			-- x from the ADC plus upper zeros for positive
	SIGNAL d_in 		: STD_LOGIC_VECTOR(W1-1 DOWNTO 0) := (OTHERS => '0');			-- d from the ADC plus upper zeros for positive
	SIGNAL d 			: STD_LOGIC_VECTOR(W1-1 DOWNTO 0) := (OTHERS => '0');			-- current d input	
	SIGNAL mue 			: STD_LOGIC_VECTOR(W1-1 DOWNTO 0) := (OTHERS => '0');			-- mu * e scaled to W1 -- mu is 1/4, e shifted right by 2
	SIGNAL Mult_ina 	: STD_LOGIC_VECTOR(W1-1 DOWNTO 0) := (OTHERS => '0');
	SIGNAL Mult_inb 	: STD_LOGIC_VECTOR(W1-1 DOWNTO 0) := (OTHERS => '0');
	
	SIGNAL Mult_out 	: STD_LOGIC_VECTOR(W2-1 DOWNTO 0) := (OTHERS => '0');
	SIGNAL sxtd 		: STD_LOGIC_VECTOR(W2-1 DOWNTO 0) := (OTHERS => '0');			-- d extended with same sign as d
	SIGNAL sxty 		: STD_LOGIC_VECTOR(W2-1 DOWNTO 0) := (OTHERS => '0');			-- y acumulated and scaled by 65536
	SIGNAL e 			: STD_LOGIC_VECTOR(W2-1 DOWNTO 0) := (OTHERS => '0');			-- error
	SIGNAL y 			: STD_LOGIC_VECTOR(W2-1 DOWNTO 0) := (OTHERS => '0');			-- y acumulated 
	
	SIGNAL m_index		: INTEGER RANGE 0 TO 2048 := 0;
	SIGNAL cnt 			: INTEGER RANGE 0 TO 2500 := 0;

BEGIN

	CONTROL: PROCESS(CLK, reset_n) IS
	BEGIN
		IF reset_n = '0' THEN
			STATE <= INIT;
		ELSIF RISING_EDGE(CLK) THEN
			CASE STATE IS
			
				WHEN INIT =>							-- reset all coeficients 
					FOR ii IN 0 TO L-1 LOOP
						h(ii) <= STD_LOGIC_VECTOR(TO_UNSIGNED(32, W1));    -- 65536/2048 = 32   -- 65536 is a scaling factor
					END LOOP;
					STATE <= SHIFT_X;
					
				WHEN SHIFT_X =>						-- getting new d and x and shifting x[n] = x[n-1]
					m_index <= 0;
					STATE <= T1;
					
				WHEN T1 =>
					STATE <= T2;
					
				WHEN T2 =>
					STATE <= MULT_MUE;
					
				WHEN MULT_MUE	=>								-- Multiply the factor mu with the error mu * (d[n] - y[n]) 
					e <= STD_LOGIC_VECTOR(SIGNED(sxtd) - SIGNED(sxty));
					mue <= e(W1+1 DOWNTO 2);		-- divide by 4 (mu is 1/4) by shifting right 2 spaces
					STATE <= MULT_XH;
					
				WHEN MULT_XH =>						-- Multiply x[n] * h[n]
					Mult_ina <= x(m_index);
					Mult_inb	<= h(m_index);
					STATE <= MULT_XMUE;	
					
				WHEN MULT_XMUE =>						-- Multiply x[n] * mu * (d[n]-y[n]) and get result from x[n] * h[n] to accumulate in y[n]
					Mult_ina	<= x(m_index);
					Mult_inb <= mue;
					y <= STD_LOGIC_VECTOR (SIGNED(y) + SIGNED(Mult_out));					-- Acumulate y = SUM(x[n]*h[n])  - n from 0 to L
					STATE <= UPDATE_H;
					
				WHEN UPDATE_H =>						-- Update h[n] = x[n] * mu * (d[n]-y[n]) + h[n-1]
					IF m_index < L THEN 
						h(m_index) <= STD_LOGIC_VECTOR(SIGNED(Mult_out) + SIGNED(h(m_index)));
						m_index <= m_index + 1;
					ELSE
						STATE <= SCALING;
					END IF;
					
				WHEN SCALING => 						-- Scale y by 65535 = 16 spaces to the right
					STATE <= WAITING;
					
				WHEN WAITING =>
					IF cnt > 2499 THEN
						STATE <= SHIFT_X;
					END IF;
					
				WHEN OTHERS =>
					STATE <= INIT;
					
			END CASE;
		END IF;
	END PROCESS CONTROL;

	cnt_p: PROCESS (CLK) IS
	BEGIN
		IF RISING_EDGE(CLK) THEN
			IF STATE /= INIT AND cnt < 2500 THEN
				cnt <= cnt + 1;
			ELSIF STATE = SHIFT_X THEN
				cnt <= 0;
			END IF;
		END IF;
	END PROCESS cnt_p;

	ext_d: PROCESS (CLK) IS
	BEGIN
		IF RISING_EDGE(CLK) AND STATE = T1 THEN
			sxtd(W1-1 DOWNTO 0) <= d;
			FOR ii IN W2-1 DOWNTO W1 LOOP
				sxtd(ii) <= d(d'high);				-- in case we have a trully signed signal from the ADC this will take care of the sign
			END LOOP;
		END IF;
	END PROCESS ext_d;

	ext_y: PROCESS (CLK) IS
	BEGIN
		IF RISING_EDGE(CLK) AND STATE = SCALING THEN
			sxty(W1 DOWNTO 0) <= y(W1+16 DOWNTO 16);
			FOR ii IN W2-1 DOWNTO W1+1 LOOP
				sxty(ii) <= y(y'high);				-- taking care of the sign when shifting right
			END LOOP;
		END IF;
	END PROCESS ext_y;

	SHIFTING_X: PROCESS(CLK, reset_n) IS
	BEGIN
		IF reset_n = '0' THEN
			FOR ii IN 0 TO L-1 LOOP
				x(ii) <= (OTHERS => '0');
			END LOOP;
		ELSIF RISING_EDGE(CLK) AND STATE = SHIFT_X THEN
			d		<= d_in;														-- adquiring new d (desired signal) -- ADB
			x(0) 	<= x_in;														-- getting new x							-- ADA
			FOR ii IN 1 TO L-1 LOOP
				x(ii) <= x(ii-1);												-- shifting
			END LOOP;
		END IF;
	END PROCESS;
		
	MULTIPLIER: lpm_mult
		GENERIC MAP( 
			LPM_WIDTHA => W1,
			LPM_WIDTHB => W1,
			LPM_REPRESENTATION => "SIGNED",
			LPM_WIDTHP => W2,
			LPM_WIDTHS => W2
			)
		PORT MAP(
			dataa => Mult_ina,
			datab => Mult_inb,
			result => Mult_out
			);
			
	x_in <= x"0" & ADA_DOUT;					-- adding extra zeros to have the ADC signal positive and match the size
	d_in <= x"0" & ADB_DOUT;					-- adding extra zeros to have the ADC signal positive and match the size
	
	e_out <= e;
	y_out <= sxty;
	

END ARCHITECTURE FIR_LMS_ARCH;	