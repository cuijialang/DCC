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

	component DCC_QSYS is
		port (
			clk_clk                                           : in  std_logic                     := 'X';             -- clk
			reset_reset_n                                     : in  std_logic                     := 'X';             -- reset_n
			pcie_hard_ip_0_refclk_export                      : in  std_logic                     := 'X';             -- export
			pcie_hard_ip_0_pcie_rstn_export                   : in  std_logic                     := 'X';             -- export
			pcie_hard_ip_0_rx_in_rx_datain_0                  : in  std_logic                     := 'X';             -- rx_datain_0
			pcie_hard_ip_0_tx_out_tx_dataout_0                : out std_logic;                                        -- tx_dataout_0
			sw_external_connection_export                     : in  std_logic_vector(17 downto 0) := (others => 'X'); -- export
			ledr_external_connection_export                   : out std_logic_vector(17 downto 0);                     -- export
			ada_fifo_in_valid                                 : in  std_logic                     := 'X';             -- valid
			ada_fifo_in_data                                  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- data
			ada_fifo_in_channel                               : in  std_logic                     := 'X';             -- channel
			ada_fifo_in_error                                 : in  std_logic                     := 'X';             -- error
			ada_fifo_in_ready                                 : out std_logic;                                        -- ready
			ada_fifo_clk_in_clk                               : in  std_logic                     := 'X'              -- clk
		);
	end component DCC_QSYS;
	
	component HSMC_DCC IS 
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
		END component HSMC_DCC;

---------------------------------------------------------------
-- SIGNALS
---------------------------------------------------------------

	signal reset_n							: STD_LOGIC := '0';
	signal sada_fifo_clk_in_clk		: STD_LOGIC := '0';
	signal sada_fifo_in_data			: STD_LOGIC_VECTOR(31 downto 0) := (OTHERS => '0');
	
BEGIN

---------------------------------------------------------------
-- GENERAL SIGNALS
---------------------------------------------------------------	

	reset_n <= '1';

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
			ledr_external_connection_export                   => LEDR,							-- export
			ada_fifo_in_valid                                 => sada_fifo_clk_in_clk,                                 --                       ada_fifo_in.valid
			ada_fifo_in_data                                  => sada_fifo_in_data,                                  --                                  .data
			ada_fifo_in_channel                               => '0',                               --                                  .channel
			ada_fifo_in_error                                 => '0',                                 --                                  .error
			ada_fifo_in_ready                                 => open,                                 --                                  .ready
			ada_fifo_clk_in_clk                               => sada_fifo_clk_in_clk                                --                   ada_fifo_clk_in.clk
		);
	
	PCIE_WAKE_N <= '1';
	
---------------------------------------------------------------
-- HSMC
---------------------------------------------------------------
	HSMC_DCC_INST : component HSMC_DCC
		PORT MAP(
			CLK					=> CLOCK_50,
			reset_n				=> reset_n,
			CLK_25				=> sada_fifo_clk_in_clk,
			-- ADC DATA
			ADA_DOUT				=> sada_fifo_in_data(13 downto 0),
			ADB_DOUT				=> open,
			-- DAC DATA
			DA_DIN				=> (OTHERS => '0'),			--ZEROS
			DB_DIN				=> (OTHERS => '0'),			--ZEROS
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

END DCC_ARCH;