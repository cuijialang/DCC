	component DCC_QSYS is
		port (
			clk_clk                                           : in  std_logic                     := 'X';             -- clk
			reset_reset_n                                     : in  std_logic                     := 'X';             -- reset_n
			sw_external_connection_export                     : in  std_logic_vector(17 downto 0) := (others => 'X'); -- export
			ledr_external_connection_export                   : out std_logic_vector(17 downto 0);                    -- export
			pcie_hard_ip_0_refclk_export                      : in  std_logic                     := 'X';             -- export
			pcie_hard_ip_0_test_in_test_in                    : in  std_logic_vector(39 downto 0) := (others => 'X'); -- test_in
			pcie_hard_ip_0_pcie_rstn_export                   : in  std_logic                     := 'X';             -- export
			pcie_hard_ip_0_clocks_sim_clk250_export           : out std_logic;                                        -- clk250_export
			pcie_hard_ip_0_clocks_sim_clk500_export           : out std_logic;                                        -- clk500_export
			pcie_hard_ip_0_clocks_sim_clk125_export           : out std_logic;                                        -- clk125_export
			pcie_hard_ip_0_pipe_ext_pipe_mode                 : in  std_logic                     := 'X';             -- pipe_mode
			pcie_hard_ip_0_pipe_ext_phystatus_ext             : in  std_logic                     := 'X';             -- phystatus_ext
			pcie_hard_ip_0_pipe_ext_rate_ext                  : out std_logic;                                        -- rate_ext
			pcie_hard_ip_0_pipe_ext_powerdown_ext             : out std_logic_vector(1 downto 0);                     -- powerdown_ext
			pcie_hard_ip_0_pipe_ext_txdetectrx_ext            : out std_logic;                                        -- txdetectrx_ext
			pcie_hard_ip_0_pipe_ext_rxelecidle0_ext           : in  std_logic                     := 'X';             -- rxelecidle0_ext
			pcie_hard_ip_0_pipe_ext_rxdata0_ext               : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- rxdata0_ext
			pcie_hard_ip_0_pipe_ext_rxstatus0_ext             : in  std_logic_vector(2 downto 0)  := (others => 'X'); -- rxstatus0_ext
			pcie_hard_ip_0_pipe_ext_rxvalid0_ext              : in  std_logic                     := 'X';             -- rxvalid0_ext
			pcie_hard_ip_0_pipe_ext_rxdatak0_ext              : in  std_logic                     := 'X';             -- rxdatak0_ext
			pcie_hard_ip_0_pipe_ext_txdata0_ext               : out std_logic_vector(7 downto 0);                     -- txdata0_ext
			pcie_hard_ip_0_pipe_ext_txdatak0_ext              : out std_logic;                                        -- txdatak0_ext
			pcie_hard_ip_0_pipe_ext_rxpolarity0_ext           : out std_logic;                                        -- rxpolarity0_ext
			pcie_hard_ip_0_pipe_ext_txcompl0_ext              : out std_logic;                                        -- txcompl0_ext
			pcie_hard_ip_0_pipe_ext_txelecidle0_ext           : out std_logic;                                        -- txelecidle0_ext
			pcie_hard_ip_0_reconfig_busy_busy_altgxb_reconfig : in  std_logic                     := 'X';             -- busy_altgxb_reconfig
			pcie_hard_ip_0_rx_in_rx_datain_0                  : in  std_logic                     := 'X';             -- rx_datain_0
			pcie_hard_ip_0_tx_out_tx_dataout_0                : out std_logic;                                        -- tx_dataout_0
			pcie_hard_ip_0_reconfig_togxb_data                : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- data
			pcie_hard_ip_0_reconfig_fromgxb_0_data            : out std_logic_vector(4 downto 0);                     -- data
			inter5_4_ready                                    : in  std_logic                     := 'X';             -- ready
			inter5_4_valid                                    : out std_logic;                                        -- valid
			inter5_4_data                                     : out std_logic_vector(31 downto 0);                    -- data
			inter5_4_channel                                  : out std_logic_vector(5 downto 0);                     -- channel
			inter5_4_startofpacket                            : out std_logic;                                        -- startofpacket
			inter5_4_endofpacket                              : out std_logic;                                        -- endofpacket
			inter5_0_ready                                    : in  std_logic                     := 'X';             -- ready
			inter5_0_valid                                    : out std_logic;                                        -- valid
			inter5_0_data                                     : out std_logic_vector(31 downto 0);                    -- data
			inter5_0_channel                                  : out std_logic_vector(5 downto 0);                     -- channel
			inter5_0_startofpacket                            : out std_logic;                                        -- startofpacket
			inter5_0_endofpacket                              : out std_logic;                                        -- endofpacket
			inter4_ready                                      : in  std_logic                     := 'X';             -- ready
			inter4_valid                                      : out std_logic;                                        -- valid
			inter4_data                                       : out std_logic_vector(31 downto 0);                    -- data
			inter4_channel                                    : out std_logic_vector(5 downto 0);                     -- channel
			inter4_startofpacket                              : out std_logic;                                        -- startofpacket
			inter4_endofpacket                                : out std_logic;                                        -- endofpacket
			inter5_1_ready                                    : in  std_logic                     := 'X';             -- ready
			inter5_1_valid                                    : out std_logic;                                        -- valid
			inter5_1_data                                     : out std_logic_vector(31 downto 0);                    -- data
			inter5_1_channel                                  : out std_logic_vector(5 downto 0);                     -- channel
			inter5_1_startofpacket                            : out std_logic;                                        -- startofpacket
			inter5_1_endofpacket                              : out std_logic;                                        -- endofpacket
			inter5_2_ready                                    : in  std_logic                     := 'X';             -- ready
			inter5_2_valid                                    : out std_logic;                                        -- valid
			inter5_2_data                                     : out std_logic_vector(31 downto 0);                    -- data
			inter5_2_channel                                  : out std_logic_vector(5 downto 0);                     -- channel
			inter5_2_startofpacket                            : out std_logic;                                        -- startofpacket
			inter5_2_endofpacket                              : out std_logic;                                        -- endofpacket
			inter5_3_ready                                    : in  std_logic                     := 'X';             -- ready
			inter5_3_valid                                    : out std_logic;                                        -- valid
			inter5_3_data                                     : out std_logic_vector(31 downto 0);                    -- data
			inter5_3_channel                                  : out std_logic_vector(5 downto 0);                     -- channel
			inter5_3_startofpacket                            : out std_logic;                                        -- startofpacket
			inter5_3_endofpacket                              : out std_logic                                         -- endofpacket
		);
	end component DCC_QSYS;

	u0 : component DCC_QSYS
		port map (
			clk_clk                                           => CONNECTED_TO_clk_clk,                                           --                               clk.clk
			reset_reset_n                                     => CONNECTED_TO_reset_reset_n,                                     --                             reset.reset_n
			sw_external_connection_export                     => CONNECTED_TO_sw_external_connection_export,                     --            sw_external_connection.export
			ledr_external_connection_export                   => CONNECTED_TO_ledr_external_connection_export,                   --          ledr_external_connection.export
			pcie_hard_ip_0_refclk_export                      => CONNECTED_TO_pcie_hard_ip_0_refclk_export,                      --             pcie_hard_ip_0_refclk.export
			pcie_hard_ip_0_test_in_test_in                    => CONNECTED_TO_pcie_hard_ip_0_test_in_test_in,                    --            pcie_hard_ip_0_test_in.test_in
			pcie_hard_ip_0_pcie_rstn_export                   => CONNECTED_TO_pcie_hard_ip_0_pcie_rstn_export,                   --          pcie_hard_ip_0_pcie_rstn.export
			pcie_hard_ip_0_clocks_sim_clk250_export           => CONNECTED_TO_pcie_hard_ip_0_clocks_sim_clk250_export,           --         pcie_hard_ip_0_clocks_sim.clk250_export
			pcie_hard_ip_0_clocks_sim_clk500_export           => CONNECTED_TO_pcie_hard_ip_0_clocks_sim_clk500_export,           --                                  .clk500_export
			pcie_hard_ip_0_clocks_sim_clk125_export           => CONNECTED_TO_pcie_hard_ip_0_clocks_sim_clk125_export,           --                                  .clk125_export
			pcie_hard_ip_0_pipe_ext_pipe_mode                 => CONNECTED_TO_pcie_hard_ip_0_pipe_ext_pipe_mode,                 --           pcie_hard_ip_0_pipe_ext.pipe_mode
			pcie_hard_ip_0_pipe_ext_phystatus_ext             => CONNECTED_TO_pcie_hard_ip_0_pipe_ext_phystatus_ext,             --                                  .phystatus_ext
			pcie_hard_ip_0_pipe_ext_rate_ext                  => CONNECTED_TO_pcie_hard_ip_0_pipe_ext_rate_ext,                  --                                  .rate_ext
			pcie_hard_ip_0_pipe_ext_powerdown_ext             => CONNECTED_TO_pcie_hard_ip_0_pipe_ext_powerdown_ext,             --                                  .powerdown_ext
			pcie_hard_ip_0_pipe_ext_txdetectrx_ext            => CONNECTED_TO_pcie_hard_ip_0_pipe_ext_txdetectrx_ext,            --                                  .txdetectrx_ext
			pcie_hard_ip_0_pipe_ext_rxelecidle0_ext           => CONNECTED_TO_pcie_hard_ip_0_pipe_ext_rxelecidle0_ext,           --                                  .rxelecidle0_ext
			pcie_hard_ip_0_pipe_ext_rxdata0_ext               => CONNECTED_TO_pcie_hard_ip_0_pipe_ext_rxdata0_ext,               --                                  .rxdata0_ext
			pcie_hard_ip_0_pipe_ext_rxstatus0_ext             => CONNECTED_TO_pcie_hard_ip_0_pipe_ext_rxstatus0_ext,             --                                  .rxstatus0_ext
			pcie_hard_ip_0_pipe_ext_rxvalid0_ext              => CONNECTED_TO_pcie_hard_ip_0_pipe_ext_rxvalid0_ext,              --                                  .rxvalid0_ext
			pcie_hard_ip_0_pipe_ext_rxdatak0_ext              => CONNECTED_TO_pcie_hard_ip_0_pipe_ext_rxdatak0_ext,              --                                  .rxdatak0_ext
			pcie_hard_ip_0_pipe_ext_txdata0_ext               => CONNECTED_TO_pcie_hard_ip_0_pipe_ext_txdata0_ext,               --                                  .txdata0_ext
			pcie_hard_ip_0_pipe_ext_txdatak0_ext              => CONNECTED_TO_pcie_hard_ip_0_pipe_ext_txdatak0_ext,              --                                  .txdatak0_ext
			pcie_hard_ip_0_pipe_ext_rxpolarity0_ext           => CONNECTED_TO_pcie_hard_ip_0_pipe_ext_rxpolarity0_ext,           --                                  .rxpolarity0_ext
			pcie_hard_ip_0_pipe_ext_txcompl0_ext              => CONNECTED_TO_pcie_hard_ip_0_pipe_ext_txcompl0_ext,              --                                  .txcompl0_ext
			pcie_hard_ip_0_pipe_ext_txelecidle0_ext           => CONNECTED_TO_pcie_hard_ip_0_pipe_ext_txelecidle0_ext,           --                                  .txelecidle0_ext
			pcie_hard_ip_0_reconfig_busy_busy_altgxb_reconfig => CONNECTED_TO_pcie_hard_ip_0_reconfig_busy_busy_altgxb_reconfig, --      pcie_hard_ip_0_reconfig_busy.busy_altgxb_reconfig
			pcie_hard_ip_0_rx_in_rx_datain_0                  => CONNECTED_TO_pcie_hard_ip_0_rx_in_rx_datain_0,                  --              pcie_hard_ip_0_rx_in.rx_datain_0
			pcie_hard_ip_0_tx_out_tx_dataout_0                => CONNECTED_TO_pcie_hard_ip_0_tx_out_tx_dataout_0,                --             pcie_hard_ip_0_tx_out.tx_dataout_0
			pcie_hard_ip_0_reconfig_togxb_data                => CONNECTED_TO_pcie_hard_ip_0_reconfig_togxb_data,                --     pcie_hard_ip_0_reconfig_togxb.data
			pcie_hard_ip_0_reconfig_fromgxb_0_data            => CONNECTED_TO_pcie_hard_ip_0_reconfig_fromgxb_0_data,            -- pcie_hard_ip_0_reconfig_fromgxb_0.data
			inter5_4_ready                                    => CONNECTED_TO_inter5_4_ready,                                    --                          inter5_4.ready
			inter5_4_valid                                    => CONNECTED_TO_inter5_4_valid,                                    --                                  .valid
			inter5_4_data                                     => CONNECTED_TO_inter5_4_data,                                     --                                  .data
			inter5_4_channel                                  => CONNECTED_TO_inter5_4_channel,                                  --                                  .channel
			inter5_4_startofpacket                            => CONNECTED_TO_inter5_4_startofpacket,                            --                                  .startofpacket
			inter5_4_endofpacket                              => CONNECTED_TO_inter5_4_endofpacket,                              --                                  .endofpacket
			inter5_0_ready                                    => CONNECTED_TO_inter5_0_ready,                                    --                          inter5_0.ready
			inter5_0_valid                                    => CONNECTED_TO_inter5_0_valid,                                    --                                  .valid
			inter5_0_data                                     => CONNECTED_TO_inter5_0_data,                                     --                                  .data
			inter5_0_channel                                  => CONNECTED_TO_inter5_0_channel,                                  --                                  .channel
			inter5_0_startofpacket                            => CONNECTED_TO_inter5_0_startofpacket,                            --                                  .startofpacket
			inter5_0_endofpacket                              => CONNECTED_TO_inter5_0_endofpacket,                              --                                  .endofpacket
			inter4_ready                                      => CONNECTED_TO_inter4_ready,                                      --                            inter4.ready
			inter4_valid                                      => CONNECTED_TO_inter4_valid,                                      --                                  .valid
			inter4_data                                       => CONNECTED_TO_inter4_data,                                       --                                  .data
			inter4_channel                                    => CONNECTED_TO_inter4_channel,                                    --                                  .channel
			inter4_startofpacket                              => CONNECTED_TO_inter4_startofpacket,                              --                                  .startofpacket
			inter4_endofpacket                                => CONNECTED_TO_inter4_endofpacket,                                --                                  .endofpacket
			inter5_1_ready                                    => CONNECTED_TO_inter5_1_ready,                                    --                          inter5_1.ready
			inter5_1_valid                                    => CONNECTED_TO_inter5_1_valid,                                    --                                  .valid
			inter5_1_data                                     => CONNECTED_TO_inter5_1_data,                                     --                                  .data
			inter5_1_channel                                  => CONNECTED_TO_inter5_1_channel,                                  --                                  .channel
			inter5_1_startofpacket                            => CONNECTED_TO_inter5_1_startofpacket,                            --                                  .startofpacket
			inter5_1_endofpacket                              => CONNECTED_TO_inter5_1_endofpacket,                              --                                  .endofpacket
			inter5_2_ready                                    => CONNECTED_TO_inter5_2_ready,                                    --                          inter5_2.ready
			inter5_2_valid                                    => CONNECTED_TO_inter5_2_valid,                                    --                                  .valid
			inter5_2_data                                     => CONNECTED_TO_inter5_2_data,                                     --                                  .data
			inter5_2_channel                                  => CONNECTED_TO_inter5_2_channel,                                  --                                  .channel
			inter5_2_startofpacket                            => CONNECTED_TO_inter5_2_startofpacket,                            --                                  .startofpacket
			inter5_2_endofpacket                              => CONNECTED_TO_inter5_2_endofpacket,                              --                                  .endofpacket
			inter5_3_ready                                    => CONNECTED_TO_inter5_3_ready,                                    --                          inter5_3.ready
			inter5_3_valid                                    => CONNECTED_TO_inter5_3_valid,                                    --                                  .valid
			inter5_3_data                                     => CONNECTED_TO_inter5_3_data,                                     --                                  .data
			inter5_3_channel                                  => CONNECTED_TO_inter5_3_channel,                                  --                                  .channel
			inter5_3_startofpacket                            => CONNECTED_TO_inter5_3_startofpacket,                            --                                  .startofpacket
			inter5_3_endofpacket                              => CONNECTED_TO_inter5_3_endofpacket                               --                                  .endofpacket
		);

