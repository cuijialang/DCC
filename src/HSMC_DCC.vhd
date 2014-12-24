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

ENTITY HSMC_DCC IS 
PORT (
	CLK				: IN STD_LOGIC;
	reset_n			: IN STD_LOGIC;
	CLK_25			: OUT STD_LOGIC;
	-- ADC DATA
	ADA_DOUT			: OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
	ADB_DOUT			: OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
	-- DAC DATA
	DA_DIN			: IN STD_LOGIC_VECTOR(13 DOWNTO 0);
	DB_DIN			: IN STD_LOGIC_VECTOR(13 DOWNTO 0);
	-- TO HSMC CONNECTOR DCC
	CLKIN1			: IN STD_LOGIC; 					--TP1
	CLKOUT0			: OUT STD_LOGIC;					--TP2
	J1_152			: OUT STD_LOGIC;					--TP5
	-- I2C EEPROM
	SCL				: OUT STD_LOGIC;					
	SDA				: INOUT STD_LOGIC;	
	-- External Clock Source in DCC
	XT_IN_N			: IN STD_LOGIC;					
	XT_IN_P			: IN STD_LOGIC;
	-- Clocks from FPGA
	FPGA_CLK_A_N	: OUT STD_LOGIC;
	FPGA_CLK_A_P 	: OUT STD_LOGIC;
	FPGA_CLK_B_N	: OUT STD_LOGIC;
	FPGA_CLK_B_P 	: OUT STD_LOGIC;
	-- ADC A
	ADA_D				: IN STD_LOGIC_VECTOR(13 DOWNTO 0);
	ADA_OR			: IN STD_LOGIC;					-- Out of range
	ADA_SPI_CS		: OUT STD_LOGIC;					-- Chip Select = 0
	ADA_OE			: OUT STD_LOGIC;					-- Enable = 0
	ADA_DCO			: IN STD_LOGIC;					-- Data clock output
	-- ADC B
	ADB_D				: IN STD_LOGIC_VECTOR(13 DOWNTO 0);
	ADB_OR			: IN STD_LOGIC;					-- Out of range
	ADB_SPI_CS		: OUT STD_LOGIC;              -- Chip Select = 0
	ADB_OE			: OUT STD_LOGIC;              -- Enable = 0
	ADB_DCO			: IN STD_LOGIC;               -- Data clock output
	-- DACs
	DA					: OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
	DB					: OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
	-- Audio CODEC
	AIC_XCLK			: IN STD_LOGIC;					-- Crystal or external-clock input
	AIC_LRCOUT		: INOUT STD_LOGIC;				-- I2S ADC-word clock signal
	AIC_LRCIN		: INOUT STD_LOGIC;				-- I2S DAC-word clock signal.
	AIC_DIN			: OUT STD_LOGIC;					-- I2S format serial data input to the sigma delta stereo DAC
	AIC_DOUT			: IN STD_LOGIC;					-- Output
	AD_SCLK			: OUT STD_LOGIC;					-- SPI
	AD_SDIO			: INOUT STD_LOGIC;				-- SPI
	AIC_SPI_CS		: OUT STD_LOGIC;					-- Chip Select = 0  (low active)
	AIC_BCLK			: INOUT STD_LOGIC					-- I2S serial-bit clock.
	);
END HSMC_DCC;

ARCHITECTURE HSMC_DCC_ARCH OF HSMC_DCC IS 

	component HSMC_DCC_CLK
		PORT
		(
			areset		: IN STD_LOGIC  := '0';
			inclk0		: IN STD_LOGIC  := '0';
			c0		: OUT STD_LOGIC ;
			c1		: OUT STD_LOGIC ;
			c2		: OUT STD_LOGIC ;
			c3		: OUT STD_LOGIC 
		);
	end component;

	SIGNAL sADA_DOUT : STD_LOGIC_VECTOR (13 DOWNTO 0) := (OTHERS => '0');
	SIGNAL sADB_DOUT : STD_LOGIC_VECTOR (13 DOWNTO 0) := (OTHERS => '0');
	
	SIGNAL sareset				:  STD_LOGIC := '0';
	
	SIGNAL sCLK_0				:  STD_LOGIC := '0';
	SIGNAL sCLK_180			:  STD_LOGIC := '0';
	SIGNAL sCLK_270			:  STD_LOGIC := '0';
	
BEGIN 

	------------------------------------------------------------------------
	-- SPI
	
		AD_SCLK					<= '0';					-- Bynary when SPI not active
		AD_SDIO 					<= '1';					-- Duty Cycle Stabilazer when SPI not active
      ADA_SPI_CS				<= '1';
      ADB_SPI_CS				<= '1';
		AIC_SPI_CS				<= '1';
	
	------------------------------------------------------------------------
	-- ADC A
	-- NOTE: NOT USING THE OUT OF RANGE FLAG ADA_OR		
	
	ADA_OE			<= '1';			-- Output enabled

	ADA_PINS: PROCESS (reset_n, ADA_DCO) IS
	BEGIN
		IF reset_n = '0' THEN
			sADA_DOUT <= (OTHERS => '0');
		ELSIF RISING_EDGE(ADA_DCO) THEN
			sADA_DOUT <= ADA_D;
		END IF;
	END PROCESS ADA_PINS;
	
	ADA_SYNC : PROCESS (reset_n, sCLK_0) IS
	BEGIN 
		IF reset_n = '0' THEN
			ADA_DOUT <= (OTHERS => '0');
		ELSIF RISING_EDGE(sCLK_0) THEN
			ADA_DOUT <= sADA_DOUT;
		END IF;
	END PROCESS ADA_SYNC;
	
	------------------------------------------------------------------------
	-- ADC B
	-- NOTE: NOT USING THE OUT OF RANGE FLAG ADB_OR	
	
	ADB_OE			<= '1';			-- Output enabled
	
	ADB_PINS: PROCESS (reset_n, ADB_DCO) IS
	BEGIN
		IF reset_n = '0' THEN
			sADB_DOUT <= (OTHERS => '0');
		ELSIF RISING_EDGE(ADB_DCO) THEN
			sADB_DOUT <= ADB_D;
		END IF;
	END PROCESS ADB_PINS;
	
	ADB_SYNC : PROCESS (reset_n, sCLK_0) IS
	BEGIN 
		IF reset_n = '0' THEN
			ADB_DOUT <= (OTHERS => '0');
		ELSIF RISING_EDGE(sCLK_0) THEN
			ADB_DOUT <= sADB_DOUT;
		END IF;
	END PROCESS ADB_SYNC;
	
	------------------------------------------------------------------------
	-- DACs
	DA <= DA_DIN;
	DB <= DB_DIN;
	
	------------------------------------------------------------------------
	-- CLOCKS
	sareset <= not reset_n;
	
	HSMC_DCC_CLK_inst : HSMC_DCC_CLK PORT MAP (
		areset	 => sareset,
		inclk0	 => CLK,
		c0	 => sCLK_0,						-- 0 
		c1	 => OPEN,						-- 90
		c2	 => sCLK_180, 					-- 180
		c3	 => sCLK_270					-- 270
	);
	
	FPGA_CLK_A_P	<= sCLK_180;
	FPGA_CLK_A_N	<= not sCLK_180;
	FPGA_CLK_B_P	<= sCLK_270;
	FPGA_CLK_B_N	<= not sCLK_270;
	CLK_25			<= sCLK_0;
	
	------------------------------------------------------------------------
	-- Test Points
	CLKOUT0 <= sCLK_180; 					-- Test Point 2
	J1_152 <= '1';							-- Test Point 5
	
	------------------------------------------------------------------------
	-- NOT USED
	SCL <= 'Z';
   SDA <= 'Z';
	AIC_LRCOUT		<= 'Z';				-- I2S ADC-word clock signal
	AIC_LRCIN		<= 'Z';				-- I2S DAC-word clock signal.
	AIC_DIN			<= 'Z';				-- I2S format serial data input to the sigma delta stereo DAC
	AIC_BCLK			<= 'Z';				-- I2S serial-bit clock.
	
		
END HSMC_DCC_ARCH;
		