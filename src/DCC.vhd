----------------------------------------------------------------------------------
-- Copyright (c) 2014, Luis Ardila
-- E-mail: leardilap@unal.edu.co
--
-- Description:
--
-- Revisions: 
-- Date        	Version    	Author    		Description
-- 12/10/2014    	1.0    		Luis Ardila    File created
--
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY DCC IS 
PORT (
	--	CLOCKS
		CLOCK_50				: IN STD_LOGIC;	
		CLOCK2_50			: IN STD_LOGIC;	
		CLOCK3_50			: IN STD_LOGIC;	

	--	DRAM
		DRAM_ADDR			: OUT STD_LOGIC_VECTOR (12 DOWNTO 0);
		DRAM_BA				: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		DRAM_CAS_N			: OUT STD_LOGIC;
		DRAM_CKE				: OUT STD_LOGIC;
		DRAM_CLK				: OUT STD_LOGIC;
		DRAM_CS_N			: OUT STD_LOGIC;
		DRAM_DQM				: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		DRAM_DQ				: INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		DRAM_RAS_N			: OUT STD_LOGIC;
		DRAM_WE_N			: OUT STD_LOGIC;

	-- EEP
		EEP_I2C_SCLK		: OUT STD_LOGIC;
		EEP_I2C_SDAT		: INOUT STD_LOGIC;

	-- ENET
		ENET_GTX_CLK		: OUT STD_LOGIC;
		ENET_INT_N			: IN STD_LOGIC;
		ENET_LINK100		: IN STD_LOGIC;
		ENET_MDC				: OUT STD_LOGIC;
		ENET_MDIO			: INOUT STD_LOGIC;
		ENET_RST_N			: OUT STD_LOGIC;
		ENET_RX_CLK			: IN STD_LOGIC;
		ENET_RX_COL			: IN STD_LOGIC;
		ENET_RX_CRS			: IN STD_LOGIC;
		ENET_RX_DATA		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		ENET_RX_DV			: IN STD_LOGIC;
		ENET_RX_ER			: IN STD_LOGIC;
		ENET_TX_CLK			: IN STD_LOGIC;
		ENET_TX_DATA		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		ENET_TX_EN			: OUT STD_LOGIC;
		ENET_TX_ER			: OUT STD_LOGIC;

	-- FAN
		FAN_CTRL				: OUT STD_LOGIC;

	-- FL
		FL_CE_N				: OUT STD_LOGIC;
		FL_OE_N				: OUT STD_LOGIC;
		FL_RESET_N			: OUT STD_LOGIC;
		FL_RY					: IN STD_LOGIC;
		FL_WE_N				: OUT STD_LOGIC;
		FL_WP_N				: OUT STD_LOGIC;

	-- FS
		FS_ADDR				: OUT STD_LOGIC_VECTOR (26 DOWNTO 0);
		FS_DQ					: INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);

	-- GPIO
		GPIO					: INOUT STD_LOGIC_VECTOR (35 DOWNTO 0);

	-- G
		G_SENSOR_INT1		: IN STD_LOGIC;
		G_SENSOR_SCLK		: OUT STD_LOGIC;
		G_SENSOR_SDAT		: INOUT STD_LOGIC;

	-- HEX
		HEX0					: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		HEX1					: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		HEX2					: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		HEX3					: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		HEX4					: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		HEX5					: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		HEX6					: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		HEX7					: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);

	-- HSMC
		HSMC_CLKIN1			: IN STD_LOGIC; 										--TP1
		HSMC_CLKOUT0		: OUT STD_LOGIC;										--TP2
		HSMC_J1_152			: OUT STD_LOGIC;										--TP5
		
		HSMC_SCL				: OUT STD_LOGIC;
		HSMC_SDA				: INOUT STD_LOGIC;	
		
		HSMC_XT_IN_N		: IN STD_LOGIC;
		HSMC_XT_IN_P		: IN STD_LOGIC;
		
		HSMC_FPGA_CLK_A_N	: OUT STD_LOGIC;
		HSMC_FPGA_CLK_A_P : OUT STD_LOGIC;
		HSMC_FPGA_CLK_B_N	: OUT STD_LOGIC;
		HSMC_FPGA_CLK_B_P : OUT STD_LOGIC;

		HSMC_ADA_D			: IN STD_LOGIC_VECTOR(13 DOWNTO 0);
		HSMC_ADA_OR			: IN STD_LOGIC;
		HSMC_ADA_SPI_CS	: OUT STD_LOGIC;
		HSMC_ADA_OE			: OUT STD_LOGIC;
		HSMC_ADA_DCO		: IN STD_LOGIC;
		
		HSMC_ADB_D			: IN STD_LOGIC_VECTOR(13 DOWNTO 0);
		HSMC_ADB_OR			: IN STD_LOGIC;
		HSMC_ADB_SPI_CS	: OUT STD_LOGIC;
		HSMC_ADB_OE			: OUT STD_LOGIC;
		HSMC_ADB_DCO		: IN STD_LOGIC;
		
		HSMC_DA				: OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
		HSMC_DB				: OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
		
		HSMC_AIC_XCLK		: IN STD_LOGIC;
		HSMC_AIC_LRCOUT	: INOUT STD_LOGIC;
		HSMC_AIC_LRCIN		: INOUT STD_LOGIC;
		HSMC_AIC_DIN		: OUT STD_LOGIC;
		HSMC_AIC_DOUT		: IN STD_LOGIC;
		HSMC_AD_SCLK		: OUT STD_LOGIC;
		HSMC_AD_SDIO		: INOUT STD_LOGIC;
		HSMC_AIC_SPI_CS	: OUT STD_LOGIC;						--low active
		HSMC_AIC_BCLK		: INOUT STD_LOGIC;
		
	-- I2C
		I2C_SCLK				: OUT STD_LOGIC;
		I2C_SDAT				: INOUT STD_LOGIC;

	-- IRDA
		IRDA_RXD				: IN STD_LOGIC;

	-- KEY
		KEY					: IN STD_LOGIC_VECTOR (3 DOWNTO 0);

	-- LCD
		LCD_DATA				: INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		LCD_EN				: OUT STD_LOGIC;
		LCD_ON				: OUT STD_LOGIC;
		LCD_RS				: OUT STD_LOGIC;
		LCD_RW				: OUT STD_LOGIC;

	-- LEDS
		LEDG					: OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
		LEDR					: OUT STD_LOGIC_VECTOR (17 DOWNTO 0);

	-- PCIE
		PCIE_PERST_N		: IN STD_LOGIC;
		PCIE_REFCLK_P	: IN STD_LOGIC;
		PCIE_RX_P			: IN STD_LOGIC_VECTOR (0 DOWNTO 0);
		PCIE_TX_P			: OUT STD_LOGIC_VECTOR (0 DOWNTO 0);
		PCIE_WAKE_N		: OUT STD_LOGIC;

	-- SD
		SD_CLK				: OUT STD_LOGIC;
		SD_CMD				: INOUT STD_LOGIC;
		SD_DAT				: INOUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		SD_WP_N				: IN STD_LOGIC;

	-- SMA
		SMA_CLKIN			: IN STD_LOGIC;
		SMA_CLKOUT        : OUT STD_LOGIC;

	-- SSRAM
		SSRAM0_CE_N       : OUT STD_LOGIC;
		SSRAM1_CE_N       : OUT STD_LOGIC;
		SSRAM_ADSC_N      : OUT STD_LOGIC;
		SSRAM_ADSP_N      : OUT STD_LOGIC;
		SSRAM_ADV_N       : OUT STD_LOGIC;
		SSRAM_BE				: INOUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		SSRAM_CLK			: OUT STD_LOGIC;
		SSRAM_GW_N        : OUT STD_LOGIC;
		SSRAM_OE_N        : OUT STD_LOGIC;
		SSRAM_WE_N        : OUT STD_LOGIC;

	-- SW
		SW						: IN STD_LOGIC_VECTOR (17 DOWNTO 0);

	-- TD
		TD_CLK27				: IN STD_LOGIC;
		TD_DATA				: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		TD_HS					: IN STD_LOGIC;
		TD_RESET_N        : OUT STD_LOGIC;
		TD_VS             : IN STD_LOGIC;

	-- UART
		UART_CTS          : IN STD_LOGIC;
		UART_RTS          : OUT STD_LOGIC;
		UART_RXD          : IN STD_LOGIC;
		UART_TXD          : OUT STD_LOGIC;
		
	-- VGA
		VGA_BLANK_N       : OUT STD_LOGIC;
		VGA_B					: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		VGA_CLK				: OUT STD_LOGIC;
		VGA_G					: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		VGA_HS				: OUT STD_LOGIC;
		VGA_R					: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		VGA_SYNC_N			: OUT STD_LOGIC;
		VGA_VS				: OUT STD_LOGIC
		);
END DCC;

ARCHITECTURE DCC_ARCH OF DCC IS

---------------------------------------------------------------
-- COMPONENTS 
---------------------------------------------------------------
	COMPONENT HSMC_DCC_CLK
		PORT
		(
			areset		: IN STD_LOGIC  := '0';
			inclk0		: IN STD_LOGIC  := '0';
			c0		: OUT STD_LOGIC ;
			c1		: OUT STD_LOGIC ;
			c2		: OUT STD_LOGIC ;
			c3		: OUT STD_LOGIC 
		);
	END COMPONENT;
	
	COMPONENT HEX_MODULE IS
	PORT (
		HDIG			: IN 	STD_LOGIC_VECTOR (31 DOWNTO 0);		
		HEX_0			: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		HEX_1			: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		HEX_2			: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		HEX_3			: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		HEX_4			: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		HEX_5			: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		HEX_6			: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		HEX_7			: OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
		);
	END COMPONENT HEX_MODULE;
	
	COMPONENT HSMC_DCC IS 
		PORT (
			CLK				: IN STD_LOGIC;
			CLK_180			: IN STD_LOGIC;
			CLK_270			: IN STD_LOGIC;
			reset_n			: IN STD_LOGIC;
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
	END COMPONENT HSMC_DCC;
	
	COMPONENT micFilter is
	GENERIC (	adFil_length : Integer := 500;		-- Adaptive Filter - Length
				adFil_aWidth : Integer := 9;				-- Adaptive Filter - Address Width
				adFil_pTH 	: Integer := 2048;			-- Adaptive Filter - Positive Threshold (4.12)
				adFil_nTH 	: Integer := -2048;			-- Adaptive Filter - Negative Threshold (4.12)
				adFil_weight : Integer := 26844;			-- Adaptive Filter - Weight mu (4.28)
				FIR_cFile 	: string := "/dos/Dropbox/HS-KA/STM3/ProyectB/DCC/src/micFilter/taps256.dat";    -- FIR Filter - Coefficient File Path
				FIR_length 	: INTEGER := 257;           -- FIR Filter - Length
				FIR_aWidth	: INTEGER := 9;				-- FIR Filter - Address Width
				DsFil_div   : INTEGER := 2500;          -- Downsample Filter - Downsample Rate
				DsFil_mul  	: Integer := 107374;        -- Downsample Filter - Factor (4.28)
				clkGen_lP	: INTEGER := 1250;		    -- Clock Generator - Low Period
				clkGeN_hP	: INTEGER := 1250;		    -- Clock Generator - High Period
				FIFO_aWidth  : integer := 19;           -- FIFO Buffer - Address Width
				FIFO_length  : integer := 340151;       -- FIFO Buffer - Length
				IntX4_cFile : string := "/dos/Dropbox/HS-KA/STM3/ProyectB/DCC/src/micFilter/i4Taps.dat"; -- InterpolationX4 - Coefficient File Path
				IntX5_cFile1 : string := "/dos/Dropbox/HS-KA/STM3/ProyectB/DCC/src/micFilter/i5Taps.dat"; -- InterpolationX5 - Coefficient File Path
				IntX5_cFile2 : string := "/dos/Dropbox/HS-KA/STM3/ProyectB/DCC/src/micFilter/i5Taps.dat";--2.dat"; -- InterpolationX5 - Coefficient File Path
				IntX5_cFile3 : string := "/dos/Dropbox/HS-KA/STM3/ProyectB/DCC/src/micFilter/i5Taps.dat";--3.dat"; -- InterpolationX5 - Coefficient File Path
				IntX5_cFile4 : string := "/dos/Dropbox/HS-KA/STM3/ProyectB/DCC/src/micFilter/i5Taps.dat";--4.dat"; -- InterpolationX5 - Coefficient File Path D:\Dropbox\HS-KA\STM3\ProyectB\micFilter\
				intClkGen_lP1	: INTEGER := 3;		    -- Interp Clock Generator - Clk1 Low Period
            intClkGen_hP1	: INTEGER := 2;		    -- Interp Clock Generator - Clk1 High Period
				intClkGen_lP2	: INTEGER := 13;			-- Interp Clock Generator - Clk2 Low Period
            intClkGen_hP2	: INTEGER := 12;			-- Interp Clock Generator - Clk2 High Period
				intClkGen_lP3	: INTEGER := 63;			-- Interp Clock Generator - Clk3 Low Period
            intClkGen_hP3	: INTEGER := 62;			-- Interp Clock Generator - Clk3 High Period
				intClkGen_lP4	: INTEGER := 313;			-- Interp Clock Generator - Clk4 Low Period
            intClkGen_hP4	: INTEGER := 312;			-- Interp Clock Generator - Clk4 High Period
				Sub_factor      : INTEGER RANGE 0 TO 65565 := 4111 -- Subtract - DIN2 Factor (4.12)
				);
	PORT (	adj 		: in STD_LOGIC;											-- Coefficient update halt input bit (low = stop update)
			clk_in 		: in STD_LOGIC;											-- Clock input (nom. 25 MHz)
			gamma 		: in STD_LOGIC_VECTOR ( 15 downto 0 );					-- Detector signal input s(k)
			mic 		: in STD_LOGIC_VECTOR ( 15 downto 0 );					-- Mechanical sensor signal input v(q)
			rst 		: in STD_LOGIC;											-- Synchronous reset input
			gamma_corr 	: out STD_LOGIC_VECTOR ( 15 downto 0 ) := x"0000";		-- Filter output y(k)
			clk_outp 	: out STD_LOGIC := '0');								-- Clock output
  END COMPONENT micFilter;
  
	COMPONENT DCC_QSYS is
		port (
			clk_clk                                           : in  std_logic                     := 'X';             -- clk
			reset_reset_n                                     : in  std_logic                     := 'X';             -- reset_n
			pcie_hard_ip_0_refclk_export                      : in  std_logic                     := 'X';             -- export
			pcie_hard_ip_0_pcie_rstn_export                   : in  std_logic                     := 'X';             -- export
			pcie_hard_ip_0_rx_in_rx_datain_0                  : in  std_logic                     := 'X';             -- rx_datain_0
			pcie_hard_ip_0_tx_out_tx_dataout_0                : out std_logic;                                        -- tx_dataout_0
			sw_external_connection_export                     : in  std_logic_vector(17 downto 0) := (others => 'X'); -- export
			ledr_external_connection_export                   : out std_logic_vector(17 downto 0)                     -- export
		);
	END COMPONENT DCC_QSYS;
	
	COMPONENT TEST_COUNTER IS 
	PORT (	
				clk															: in std_logic;
				reset_n															: in std_logic;
				ada_fifo_in_valid                                 : out  std_logic                     := 'X';             -- valid
				ada_fifo_in_data                                  : out  std_logic_vector(31 downto 0) := (others => 'X'); -- data
				ada_fifo_in_ready                                 : in std_logic                                        -- ready
	);
	END COMPONENT TEST_COUNTER;
	

---------------------------------------------------------------
-- SIGNALS
---------------------------------------------------------------
	SIGNAL sCLK25_0				:  STD_LOGIC := '0';
	SIGNAL sCLK25_180			:  STD_LOGIC := '0';
	SIGNAL sCLK25_270			:  STD_LOGIC := '0';
	
	signal reset_n							: STD_LOGIC := '0';
	signal reset							: STD_LOGIC := '0';
	
	signal sValid			: STD_LOGIC := '0';
	signal sData			: STD_LOGIC_VECTOR(31 downto 0) := (OTHERS => '0');
	signal sReady			: STD_LOGIC := '0';
	
	signal sDA_DIN			: std_logic_vector(13 downto 0) := (others => '0');
	signal sDB_DIN			: std_logic_vector(13 downto 0) := (others => '0');
	signal sADA_DOUT		: std_logic_vector(13 downto 0) := (others => '0');
	signal sADB_DOUT		: std_logic_vector(13 downto 0) := (others => '0');
	
	signal sGamma : std_logic_vector(15 downto 0) := (others => '0');
	signal sMic : std_logic_vector(15 downto 0) := (others => '0');
	signal adjust			: std_logic := '0';
	signal sGamma_corr : std_logic_vector(15 downto 0);
BEGIN

---------------------------------------------------------------
-- GENERAL SIGNALS
---------------------------------------------------------------	

	reset_n 	<= '1';
	reset		<= '0';

---------------------------------------------------------------
-- CLOCKS
---------------------------------------------------------------	

	HSMC_DCC_CLK_inst : HSMC_DCC_CLK PORT MAP (
		areset	 => reset,
		inclk0	 => CLOCK_50,
		c0	 => sCLK25_0,						-- 0 
		c1	 => OPEN,						-- 90
		c2	 => sCLK25_180, 					-- 180
		c3	 => sCLK25_270					-- 270
	);
	
---------------------------------------------------------------
-- VERSION - DATE
---------------------------------------------------------------		
	HEX_MODULE_INST : HEX_MODULE
		PORT MAP(
			HDIG		=> x"29082015",		
			HEX_0		=> HEX0,	
			HEX_1		=> HEX1,	
			HEX_2		=> HEX2,	
			HEX_3		=> HEX3,	
			HEX_4		=> HEX4,	
			HEX_5		=> HEX5,	
			HEX_6		=> HEX6,	
			HEX_7		=> HEX7	
			);

---------------------------------------------------------------
-- PCIe - QSYS
---------------------------------------------------------------
	
	DCC_QSYS_INST : component DCC_QSYS
		port map (
			clk_clk                                           => CLOCK_50,						-- clk
			reset_reset_n                                     => reset_n,						-- reset_n
			pcie_hard_ip_0_refclk_export                      => PCIE_REFCLK_P,				-- export
			pcie_hard_ip_0_pcie_rstn_export                   => PCIE_PERST_N,				-- export
			pcie_hard_ip_0_rx_in_rx_datain_0                  => PCIE_RX_P(0),				-- rx_datain_0
			pcie_hard_ip_0_tx_out_tx_dataout_0                => PCIE_TX_P(0),				-- tx_dataout_0
			sw_external_connection_export                     => SW,								-- export
			ledr_external_connection_export                   => LEDR							-- export			
		);
	
	PCIE_WAKE_N <= '1';
	
---------------------------------------------------------------
-- HSMC
---------------------------------------------------------------
	HSMC_DCC_INST : component HSMC_DCC
		PORT MAP(
			CLK					=> CLOCK_50,
			CLK_180				=> sCLK25_180,
			CLK_270				=> sCLK25_270,
			reset_n				=> reset_n,
			-- ADC DATA
			ADA_DOUT				=> sADA_DOUT,
			ADB_DOUT				=> sADB_DOUT,
			-- DAC DATA
			DA_DIN				=> sDA_DIN,
			DB_DIN				=> sDB_DIN,			
			-- TO HSMC CONNECTOR DCC
			CLKIN1				=> HSMC_CLKIN1,								--TP1
			CLKOUT0				=> HSMC_CLKOUT0,								--TP2
			J1_152				=> HSMC_J1_152,								--TP5
			-- I2C EEPROM	      
			SCL					=> HSMC_SCL,									
			SDA					=> HSMC_SDA,				
										
			XT_IN_N				=> HSMC_XT_IN_N,		
			XT_IN_P				=> HSMC_XT_IN_P,		
										
			FPGA_CLK_A_N		=> HSMC_FPGA_CLK_A_N,	
			FPGA_CLK_A_P 		=> HSMC_FPGA_CLK_A_P, 
			FPGA_CLK_B_N		=> HSMC_FPGA_CLK_B_N,	
			FPGA_CLK_B_P 		=> HSMC_FPGA_CLK_B_P, 
										
			ADA_D					=> HSMC_ADA_D,			
			ADA_OR				=> HSMC_ADA_OR,			-- Out of range
			ADA_SPI_CS			=> HSMC_ADA_SPI_CS,	-- Chip Select = 0
			ADA_OE				=> HSMC_ADA_OE,			-- Enable = 0
			ADA_DCO				=> HSMC_ADA_DCO,		-- Data clock output
										
			ADB_D					=> HSMC_ADB_D,			
			ADB_OR				=> HSMC_ADB_OR,			-- Out of range
			ADB_SPI_CS			=> HSMC_ADB_SPI_CS,	-- Chip Select = 0
			ADB_OE				=> HSMC_ADB_OE,			-- Enable = 0
			ADB_DCO				=> HSMC_ADB_DCO,		-- Data clock output
										
			DA						=> HSMC_DA,				
			DB						=> HSMC_DB,				
			-- Audio CODEC	      
			AIC_XCLK				=> HSMC_AIC_XCLK,		-- Crystal or external-clock input
			AIC_LRCOUT			=> HSMC_AIC_LRCOUT,	-- I2S ADC-word clock signal
			AIC_LRCIN			=> HSMC_AIC_LRCIN,		-- I2S DAC-word clock signal.
			AIC_DIN				=> HSMC_AIC_DIN,		-- I2S format serial data input to the sigma delta stereo DAC
			AIC_DOUT				=> HSMC_AIC_DOUT,		-- Output
			AD_SCLK				=> HSMC_AD_SCLK,		-- SPI
			AD_SDIO				=> HSMC_AD_SDIO,		-- SPI
			AIC_SPI_CS			=> HSMC_AIC_SPI_CS,	-- Chip Select = 0  (low active)
			AIC_BCLK				=> HSMC_AIC_BCLK		-- I2S serial-bit clock.
			);
---------------------------------------------------------------
-- micFilter
---------------------------------------------------------------
	micFilter_inst : micFilter
	PORT MAP (	
			adj 			=> adjust,						-- Coefficient update halt input bit (low = stop update)
			clk_in 		=> sCLK25_0,						-- Clock input (nom. 25 MHz)
			gamma 		=> sGamma,						-- Detector signal input s(k)
			mic 			=> sMic,						-- Mechanical sensor signal input v(q)
			rst 			=> reset,						-- Synchronous reset input
			gamma_corr 	=> sGamma_corr,						-- Filter output y(k)
			clk_outp 	=> open						-- Clock output
	);
---------------------------------------------------------------
-- Test
---------------------------------------------------------------	
	TEST_COUNTER_INST : TEST_COUNTER
	PORT MAP(	
				clk						=> sCLK25_0,									 
				reset_n					=> KEY(3), 								
				ada_fifo_in_valid    => sValid,                           -- valid
				ada_fifo_in_data     => sData,                       -- data
				ada_fifo_in_ready    => sReady                         -- ready
	);
	
	sGamma <= std_logic_vector(resize(signed(sADA_DOUT), sGamma'length));	-- putting 14 bit from adc to 16 bit for filter
	sMic 	<= std_logic_vector(resize(signed(sADB_DOUT), sMic'length));		-- putting 14 bit from adc to 16 bit for filter
	sDA_DIN <= std_logic_vector(shift_right(signed(sGamma_corr),2)(13 DOWNTO 0));

END DCC_ARCH;