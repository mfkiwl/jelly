
`timescale 1ns / 1ps
`default_nettype none


module tb_img_previous_frame();
    localparam RATE      = 1000.0 / 200.3;
    localparam WB_RATE   = 1000.0 / 100.1;
    localparam AXI4_RATE = 1000.0 / 133.3;
    
    
    initial begin
        $dumpfile("tb_img_previous_frame.vcd");
        $dumpvars(0, tb_img_previous_frame);
        
        #1000000;
            $finish;
    end
    
    
    localparam  RAND_BUSY = 1;
    
    
    reg     reset = 1'b1;
    initial #(RATE*100)         reset = 1'b0;
    
    reg     clk = 1'b1;
    always #(RATE/2.0)          clk = ~clk;
    
    reg     cke = 1'b1;
    always @(posedge clk)       cke <= RAND_BUSY ? {$random()} : 1'b1;
    
    reg     wb_rst_i = 1'b1;
    initial #(WB_RATE*100)      wb_rst_i = 1'b0;
    
    reg     wb_clk_i = 1'b1;
    always #(WB_RATE/2.0)       wb_clk_i = ~wb_clk_i;
    
    
    reg     aresetn = 1'b0;
    initial #(AXI4_RATE*100)    aresetn = 1'b1;
    
    reg     aclk = 1'b1;
    always #(AXI4_RATE/2.0)     aclk = ~aclk;
    
    
    
    
    // -----------------------------------------
    //  Core
    // -----------------------------------------
    
    parameter   USER_WIDTH               = Y_WIDTH+X_WIDTH;
    parameter   USER_BITS                = USER_WIDTH > 1 ? USER_WIDTH : 1;
    
    parameter   DATA_SIZE                = 0;    // 0:8bit, 1:16bit, 2:32bit ...
    parameter   DATA_WIDTH               = (8 << DATA_SIZE);
    
    parameter   WB_ADR_WIDTH             = 8;
    parameter   WB_DAT_SIZE              = 3;     // 0:8bit, 1:16bit, 2:32bit ...
    parameter   WB_DAT_WIDTH             = (8 << WB_DAT_SIZE);
    parameter   WB_SEL_WIDTH             = (WB_DAT_WIDTH / 8);
    
    parameter   ASYNC                    = 1;
    parameter   AXI4_ID_WIDTH            = 6;
    parameter   AXI4_ADDR_WIDTH          = 32;
    parameter   AXI4_DATA_SIZE           = 3;   // 0:8bit, 1:16bit, 2:32bit ...
    parameter   AXI4_DATA_WIDTH          = (8 << AXI4_DATA_SIZE);
    parameter   AXI4_STRB_WIDTH          = (1 << AXI4_DATA_SIZE);
    parameter   AXI4_LEN_WIDTH           = 8;
    parameter   AXI4_QOS_WIDTH           = 4;
    parameter   AXI4_AWID                = {AXI4_ID_WIDTH{1'b0}};
    parameter   AXI4_AWSIZE              = AXI4_DATA_SIZE;
    parameter   AXI4_AWBURST             = 2'b01;
    parameter   AXI4_AWLOCK              = 1'b0;
    parameter   AXI4_AWCACHE             = 4'b0001;
    parameter   AXI4_AWPROT              = 3'b000;
    parameter   AXI4_AWQOS               = 0;
    parameter   AXI4_AWREGION            = 4'b0000;
    parameter   AXI4_ARID                = {AXI4_ID_WIDTH{1'b0}};
    parameter   AXI4_ARSIZE              = AXI4_DATA_SIZE;
    parameter   AXI4_ARBURST             = 2'b01;
    parameter   AXI4_ARLOCK              = 1'b0;
    parameter   AXI4_ARCACHE             = 4'b0001;
    parameter   AXI4_ARPROT              = 3'b000;
    parameter   AXI4_ARQOS               = 0;
    parameter   AXI4_ARREGION            = 4'b0000;
    
    parameter   BYPASS_ADDR_OFFSET       = 0;
    parameter   BYPASS_ALIGN             = 0;
    parameter   AXI4_ALIGN               = 12;
    
    parameter   PARAM_ADDR_WIDTH         = AXI4_ADDR_WIDTH;
    parameter   PARAM_SIZE_WIDTH         = 32;
    parameter   PARAM_SIZE_OFFSET        = 1'b0;
    parameter   PARAM_AWLEN_WIDTH        = AXI4_LEN_WIDTH;
    parameter   PARAM_WSTRB_WIDTH        = AXI4_STRB_WIDTH;
    parameter   PARAM_WTIMEOUT_WIDTH     = 8;
    parameter   PARAM_ARLEN_WIDTH        = AXI4_LEN_WIDTH;
    parameter   PARAM_RTIMEOUT_WIDTH     = 8;
    
    parameter   INIT_CTL_CONTROL         = 2'b00;
    parameter   INIT_PARAM_ADDR          = 0;
    parameter   INIT_PARAM_SIZE          = 0;
    parameter   INIT_PARAM_AWLEN         = 8'h0f;
    parameter   INIT_PARAM_WSTRB         = {AXI4_STRB_WIDTH{1'b1}};
    parameter   INIT_PARAM_WTIMEOUT      = 16;
    parameter   INIT_PARAM_ARLEN         = 8'h0f;
    parameter   INIT_PARAM_RTIMEOUT      = 16;
    
    parameter   WDATA_FIFO_PTR_WIDTH     = 9;
    parameter   WDATA_FIFO_RAM_TYPE      = "block";
    parameter   WDATA_FIFO_LOW_DEALY     = 0;
    parameter   WDATA_FIFO_DOUT_REGS     = 1;
    parameter   WDATA_FIFO_S_REGS        = 1;
    parameter   WDATA_FIFO_M_REGS        = 1;
    
    parameter   AWLEN_FIFO_PTR_WIDTH     = 5;
    parameter   AWLEN_FIFO_RAM_TYPE      = "distributed";
    parameter   AWLEN_FIFO_LOW_DEALY     = 0;
    parameter   AWLEN_FIFO_DOUT_REGS     = 1;
    parameter   AWLEN_FIFO_S_REGS        = 0;
    parameter   AWLEN_FIFO_M_REGS        = 1;
    
    parameter   BLEN_FIFO_PTR_WIDTH      = 5;
    parameter   BLEN_FIFO_RAM_TYPE       = "distributed";
    parameter   BLEN_FIFO_LOW_DEALY      = 0;
    parameter   BLEN_FIFO_DOUT_REGS      = 1;
    parameter   BLEN_FIFO_S_REGS         = 0;
    parameter   BLEN_FIFO_M_REGS         = 1;
    
    parameter   RDATA_FIFO_PTR_WIDTH     = 9;
    parameter   RDATA_FIFO_RAM_TYPE      = "block";
    parameter   RDATA_FIFO_LOW_DEALY     = 0;
    parameter   RDATA_FIFO_DOUT_REGS     = 1;
    parameter   RDATA_FIFO_S_REGS        = 1;
    parameter   RDATA_FIFO_M_REGS        = 1;
    
    
    // model
    parameter   X_NUM                    = 128;
    parameter   Y_NUM                    = 48;
    parameter   X_WIDTH                  = 32;
    parameter   Y_WIDTH                  = 32;
    
    wire                        img_src_line_first;
    wire                        img_src_line_last;
    wire                        img_src_pixel_first;
    wire                        img_src_pixel_last;
    wire                        img_src_de;
    wire    [DATA_WIDTH-1:0]    img_src_data;
    wire    [X_WIDTH-1:0]       img_src_x;
    wire    [Y_WIDTH-1:0]       img_src_y;
    wire                        img_src_valid;
    jelly_img_master_model
            #(
                .DATA_WIDTH         (DATA_WIDTH),
                .X_NUM              (X_NUM),
                .Y_NUM              (Y_NUM),
                .X_BLANK            (0),     // 基本ゼロ
                .Y_BLANK            (2),     // 末尾にde落ちラインを追加
                .X_WIDTH            (32),
                .Y_WIDTH            (32),
                .PGM_FILE           (""),
                .PPM_FILE           (""),
                .SEQUENTIAL_FILE    (0),
                .DIGIT_NUM          (4),
                .DIGIT_POS          (4),
                .MAX_PATH           (64)
            )
        i_img_master_model
            (
                .reset              (reset),
                .clk                (clk),
                .cke                (cke),
                                     
                .m_img_line_first   (img_src_line_first),
                .m_img_line_last    (img_src_line_last),
                .m_img_pixel_first  (img_src_pixel_first),
                .m_img_pixel_last   (img_src_pixel_last),
                .m_img_de           (img_src_de),
                .m_img_data         (img_src_data),
                .m_img_x            (img_src_x),
                .m_img_y            (img_src_y),
                .m_img_valid        (img_src_valid)
            );
    
    
    
    wire                                    s_img_line_first  = img_src_line_first;
    wire                                    s_img_line_last   = img_src_line_last;
    wire                                    s_img_pixel_first = img_src_pixel_first;
    wire                                    s_img_pixel_last  = img_src_pixel_last;
    wire                                    s_img_de          = img_src_de;
    wire    [USER_BITS-1:0]                 s_img_user        = {img_src_y, img_src_x};
    wire    [DATA_WIDTH-1:0]                s_img_data        = img_src_data;
    wire                                    s_img_valid       = img_src_valid;
    
    wire                                    m_img_line_first;
    wire                                    m_img_line_last;
    wire                                    m_img_pixel_first;
    wire                                    m_img_pixel_last;
    wire                                    m_img_de;
    wire    [USER_BITS-1:0]                 m_img_user;
    wire    [DATA_WIDTH-1:0]                m_img_data;
    wire                                    m_img_prev_de;
    wire    [DATA_WIDTH-1:0]                m_img_prev_data;
    wire                                    m_img_valid;
    
    wire                                    s_img_store_line_first  = img_src_line_first;
    wire                                    s_img_store_line_last   = img_src_line_last;
    wire                                    s_img_store_pixel_first = img_src_pixel_first;
    wire                                    s_img_store_pixel_last  = img_src_pixel_last;
    wire                                    s_img_store_de          = img_src_de;
    wire    [DATA_WIDTH-1:0]                s_img_store_data        = img_src_data;
    wire                                    s_img_store_valid       = img_src_valid;
    
    wire    [WB_ADR_WIDTH-1:0]              s_wb_adr_i;
    wire    [WB_DAT_WIDTH-1:0]              s_wb_dat_i;
    wire    [WB_DAT_WIDTH-1:0]              s_wb_dat_o;
    wire                                    s_wb_we_i;
    wire    [WB_SEL_WIDTH-1:0]              s_wb_sel_i;
    wire                                    s_wb_stb_i;
    wire                                    s_wb_ack_o;
    
    wire    [AXI4_ID_WIDTH-1:0]             m_axi4_awid;
    wire    [AXI4_ADDR_WIDTH-1:0]           m_axi4_awaddr;
    wire    [AXI4_LEN_WIDTH-1:0]            m_axi4_awlen;
    wire    [2:0]                           m_axi4_awsize;
    wire    [1:0]                           m_axi4_awburst;
    wire    [0:0]                           m_axi4_awlock;
    wire    [3:0]                           m_axi4_awcache;
    wire    [2:0]                           m_axi4_awprot;
    wire    [AXI4_QOS_WIDTH-1:0]            m_axi4_awqos;
    wire    [3:0]                           m_axi4_awregion;
    wire                                    m_axi4_awvalid;
    wire                                    m_axi4_awready;
    wire    [AXI4_DATA_WIDTH-1:0]           m_axi4_wdata;
    wire    [AXI4_STRB_WIDTH-1:0]           m_axi4_wstrb;
    wire                                    m_axi4_wlast;
    wire                                    m_axi4_wvalid;
    wire                                    m_axi4_wready;
    wire    [AXI4_ID_WIDTH-1:0]             m_axi4_bid;
    wire    [1:0]                           m_axi4_bresp;
    wire                                    m_axi4_bvalid;
    wire                                    m_axi4_bready;
    wire    [AXI4_ID_WIDTH-1:0]             m_axi4_arid;
    wire    [AXI4_ADDR_WIDTH-1:0]           m_axi4_araddr;
    wire    [AXI4_LEN_WIDTH-1:0]            m_axi4_arlen;
    wire    [2:0]                           m_axi4_arsize;
    wire    [1:0]                           m_axi4_arburst;
    wire    [0:0]                           m_axi4_arlock;
    wire    [3:0]                           m_axi4_arcache;
    wire    [2:0]                           m_axi4_arprot;
    wire    [AXI4_QOS_WIDTH-1:0]            m_axi4_arqos;
    wire    [3:0]                           m_axi4_arregion;
    wire                                    m_axi4_arvalid;
    wire                                    m_axi4_arready;
    wire    [AXI4_ID_WIDTH-1:0]             m_axi4_rid;
    wire    [AXI4_DATA_WIDTH-1:0]           m_axi4_rdata;
    wire    [1:0]                           m_axi4_rresp;
    wire                                    m_axi4_rlast;
    wire                                    m_axi4_rvalid;
    wire                                    m_axi4_rready;
    
    jelly_img_previous_frame
            #(
                .USER_WIDTH                 (USER_WIDTH),
                .DATA_SIZE                  (DATA_SIZE),     // 0:8bit, 1:16bit, 2:32bit ...
                
                .WB_ADR_WIDTH               (WB_ADR_WIDTH),
                .WB_DAT_SIZE                (WB_DAT_SIZE),     // 0:8bit, 1:16bit, 2:32bit ...
                
                .ASYNC                      (ASYNC),
                .AXI4_ID_WIDTH              (AXI4_ID_WIDTH),
                .AXI4_ADDR_WIDTH            (AXI4_ADDR_WIDTH),
                .AXI4_DATA_SIZE             (AXI4_DATA_SIZE),
                .AXI4_DATA_WIDTH            (AXI4_DATA_WIDTH),
                .AXI4_STRB_WIDTH            (AXI4_STRB_WIDTH),
                .AXI4_LEN_WIDTH             (AXI4_LEN_WIDTH),
                .AXI4_QOS_WIDTH             (AXI4_QOS_WIDTH),
                .AXI4_AWID                  (AXI4_AWID),
                .AXI4_AWSIZE                (AXI4_AWSIZE),
                .AXI4_AWBURST               (AXI4_AWBURST),
                .AXI4_AWLOCK                (AXI4_AWLOCK),
                .AXI4_AWCACHE               (AXI4_AWCACHE),
                .AXI4_AWPROT                (AXI4_AWPROT),
                .AXI4_AWQOS                 (AXI4_AWQOS),
                .AXI4_AWREGION              (AXI4_AWREGION),
                .AXI4_ARID                  (AXI4_ARID),
                .AXI4_ARSIZE                (AXI4_ARSIZE),
                .AXI4_ARBURST               (AXI4_ARBURST),
                .AXI4_ARLOCK                (AXI4_ARLOCK),
                .AXI4_ARCACHE               (AXI4_ARCACHE),
                .AXI4_ARPROT                (AXI4_ARPROT),
                .AXI4_ARQOS                 (AXI4_ARQOS),
                .AXI4_ARREGION              (AXI4_ARREGION),
                
                .BYPASS_ADDR_OFFSET         (BYPASS_ADDR_OFFSET),
                .BYPASS_ALIGN               (BYPASS_ALIGN),
                .AXI4_ALIGN                 (AXI4_ALIGN),
                
                .PARAM_ADDR_WIDTH           (PARAM_ADDR_WIDTH),
                .PARAM_SIZE_WIDTH           (PARAM_SIZE_WIDTH),
                .PARAM_SIZE_OFFSET          (PARAM_SIZE_OFFSET),
                .PARAM_AWLEN_WIDTH          (PARAM_AWLEN_WIDTH),
                .PARAM_WSTRB_WIDTH          (PARAM_WSTRB_WIDTH),
                .PARAM_WTIMEOUT_WIDTH       (PARAM_WTIMEOUT_WIDTH),
                .PARAM_ARLEN_WIDTH          (PARAM_ARLEN_WIDTH),
                .PARAM_RTIMEOUT_WIDTH       (PARAM_RTIMEOUT_WIDTH),
                
                .WDATA_FIFO_PTR_WIDTH       (WDATA_FIFO_PTR_WIDTH),
                .WDATA_FIFO_RAM_TYPE        (WDATA_FIFO_RAM_TYPE),
                .WDATA_FIFO_LOW_DEALY       (WDATA_FIFO_LOW_DEALY),
                .WDATA_FIFO_DOUT_REGS       (WDATA_FIFO_DOUT_REGS),
                .WDATA_FIFO_S_REGS          (WDATA_FIFO_S_REGS),
                .WDATA_FIFO_M_REGS          (WDATA_FIFO_M_REGS),
                
                .AWLEN_FIFO_PTR_WIDTH       (AWLEN_FIFO_PTR_WIDTH),
                .AWLEN_FIFO_RAM_TYPE        (AWLEN_FIFO_RAM_TYPE),
                .AWLEN_FIFO_LOW_DEALY       (AWLEN_FIFO_LOW_DEALY),
                .AWLEN_FIFO_DOUT_REGS       (AWLEN_FIFO_DOUT_REGS),
                .AWLEN_FIFO_S_REGS          (AWLEN_FIFO_S_REGS),
                .AWLEN_FIFO_M_REGS          (AWLEN_FIFO_M_REGS),
                
                .BLEN_FIFO_PTR_WIDTH        (BLEN_FIFO_PTR_WIDTH),
                .BLEN_FIFO_RAM_TYPE         (BLEN_FIFO_RAM_TYPE),
                .BLEN_FIFO_LOW_DEALY        (BLEN_FIFO_LOW_DEALY),
                .BLEN_FIFO_DOUT_REGS        (BLEN_FIFO_DOUT_REGS),
                .BLEN_FIFO_S_REGS           (BLEN_FIFO_S_REGS),
                .BLEN_FIFO_M_REGS           (BLEN_FIFO_M_REGS),
                                             
                .RDATA_FIFO_PTR_WIDTH       (RDATA_FIFO_PTR_WIDTH),
                .RDATA_FIFO_RAM_TYPE        (RDATA_FIFO_RAM_TYPE),
                .RDATA_FIFO_LOW_DEALY       (RDATA_FIFO_LOW_DEALY),
                .RDATA_FIFO_DOUT_REGS       (RDATA_FIFO_DOUT_REGS),
                .RDATA_FIFO_S_REGS          (RDATA_FIFO_S_REGS),
                .RDATA_FIFO_M_REGS          (RDATA_FIFO_M_REGS)
            )
        i_img_previous_frame
            (
                .reset                      (reset),
                .clk                        (clk),
                .cke                        (cke),
                                             
                .s_img_line_first           (s_img_line_first),
                .s_img_line_last            (s_img_line_last),
                .s_img_pixel_first          (s_img_pixel_first),
                .s_img_pixel_last           (s_img_pixel_last),
                .s_img_de                   (s_img_de),
                .s_img_user                 (s_img_user),
                .s_img_data                 (s_img_data),
                .s_img_valid                (s_img_valid),
                                             
                .m_img_line_first           (m_img_line_first),
                .m_img_line_last            (m_img_line_last),
                .m_img_pixel_first          (m_img_pixel_first),
                .m_img_pixel_last           (m_img_pixel_last),
                .m_img_de                   (m_img_de),
                .m_img_user                 (m_img_user),
                .m_img_data                 (m_img_data),
                .m_img_prev_de              (m_img_prev_de),
                .m_img_prev_data            (m_img_prev_data),
                .m_img_valid                (m_img_valid),
                                             
                .s_img_store_line_first     (s_img_store_line_first),
                .s_img_store_line_last      (s_img_store_line_last),
                .s_img_store_pixel_first    (s_img_store_pixel_first),
                .s_img_store_pixel_last     (s_img_store_pixel_last),
                .s_img_store_de             (s_img_store_de),
                .s_img_store_data           (s_img_store_data),
                .s_img_store_valid          (s_img_store_valid),
                
                .s_wb_rst_i                 (wb_rst_i),
                .s_wb_clk_i                 (wb_clk_i),
                .s_wb_adr_i                 (s_wb_adr_i),
                .s_wb_dat_i                 (s_wb_dat_i),
                .s_wb_dat_o                 (s_wb_dat_o),
                .s_wb_we_i                  (s_wb_we_i),
                .s_wb_sel_i                 (s_wb_sel_i),
                .s_wb_stb_i                 (s_wb_stb_i),
                .s_wb_ack_o                 (s_wb_ack_o),
                
                .m_axi4_aresetn             (aresetn),
                .m_axi4_aclk                (aclk),
                .m_axi4_awid                (m_axi4_awid),
                .m_axi4_awaddr              (m_axi4_awaddr),
                .m_axi4_awlen               (m_axi4_awlen),
                .m_axi4_awsize              (m_axi4_awsize),
                .m_axi4_awburst             (m_axi4_awburst),
                .m_axi4_awlock              (m_axi4_awlock),
                .m_axi4_awcache             (m_axi4_awcache),
                .m_axi4_awprot              (m_axi4_awprot),
                .m_axi4_awqos               (m_axi4_awqos),
                .m_axi4_awregion            (m_axi4_awregion),
                .m_axi4_awvalid             (m_axi4_awvalid),
                .m_axi4_awready             (m_axi4_awready),
                .m_axi4_wdata               (m_axi4_wdata),
                .m_axi4_wstrb               (m_axi4_wstrb),
                .m_axi4_wlast               (m_axi4_wlast),
                .m_axi4_wvalid              (m_axi4_wvalid),
                .m_axi4_wready              (m_axi4_wready),
                .m_axi4_bid                 (m_axi4_bid),
                .m_axi4_bresp               (m_axi4_bresp),
                .m_axi4_bvalid              (m_axi4_bvalid),
                .m_axi4_bready              (m_axi4_bready),
                .m_axi4_arid                (m_axi4_arid),
                .m_axi4_araddr              (m_axi4_araddr),
                .m_axi4_arlen               (m_axi4_arlen),
                .m_axi4_arsize              (m_axi4_arsize),
                .m_axi4_arburst             (m_axi4_arburst),
                .m_axi4_arlock              (m_axi4_arlock),
                .m_axi4_arcache             (m_axi4_arcache),
                .m_axi4_arprot              (m_axi4_arprot),
                .m_axi4_arqos               (m_axi4_arqos),
                .m_axi4_arregion            (m_axi4_arregion),
                .m_axi4_arvalid             (m_axi4_arvalid),
                .m_axi4_arready             (m_axi4_arready),
                .m_axi4_rid                 (m_axi4_rid),
                .m_axi4_rdata               (m_axi4_rdata),
                .m_axi4_rresp               (m_axi4_rresp),
                .m_axi4_rlast               (m_axi4_rlast),
                .m_axi4_rvalid              (m_axi4_rvalid),
                .m_axi4_rready              (m_axi4_rready)
            );
    
    wire    data_eq = (m_img_data == m_img_prev_data);
    
    
    // ---------------------------------
    //  dummy memory model
    // ---------------------------------
    
    jelly_axi4_slave_model
            #(
                .AXI_ID_WIDTH           (AXI4_ID_WIDTH),
                .AXI_ADDR_WIDTH         (AXI4_ADDR_WIDTH),
                .AXI_QOS_WIDTH          (AXI4_QOS_WIDTH),
                .AXI_LEN_WIDTH          (AXI4_LEN_WIDTH),
                .AXI_DATA_SIZE          (AXI4_DATA_SIZE),
                .AXI_DATA_WIDTH         (AXI4_DATA_WIDTH),
                .AXI_STRB_WIDTH         (AXI4_DATA_WIDTH/8),
                .MEM_WIDTH              (20),
                
                .READ_DATA_ADDR         (0),
                
                .WRITE_LOG_FILE         ("axi4_write.txt"),
                .READ_LOG_FILE          ("axi4_read.txt"),
                
                .AW_DELAY               (RAND_BUSY ? 16 : 0),
                .AR_DELAY               (RAND_BUSY ? 16 : 0),
                
                .AW_FIFO_PTR_WIDTH      (RAND_BUSY ? 4 : 0),
                .W_FIFO_PTR_WIDTH       (RAND_BUSY ? 4 : 0),
                .B_FIFO_PTR_WIDTH       (RAND_BUSY ? 4 : 0),
                .AR_FIFO_PTR_WIDTH      (RAND_BUSY ? 4 : 0),
                .R_FIFO_PTR_WIDTH       (RAND_BUSY ? 4 : 0),
                
                .AW_BUSY_RATE           (RAND_BUSY ? 50 : 0),
                .W_BUSY_RATE            (RAND_BUSY ? 50 : 0),
                .B_BUSY_RATE            (RAND_BUSY ? 50 : 0),
                .AR_BUSY_RATE           (RAND_BUSY ? 50 : 0),
                .R_BUSY_RATE            (RAND_BUSY ? 50 : 0)
            )
        i_axi4_slave_model
            (
                .aresetn                (aresetn),
                .aclk                   (aclk),
                
                .s_axi4_awid            (m_axi4_awid),
                .s_axi4_awaddr          (m_axi4_awaddr),
                .s_axi4_awlen           (m_axi4_awlen),
                .s_axi4_awsize          (m_axi4_awsize),
                .s_axi4_awburst         (m_axi4_awburst),
                .s_axi4_awlock          (m_axi4_awlock),
                .s_axi4_awcache         (m_axi4_awcache),
                .s_axi4_awprot          (m_axi4_awprot),
                .s_axi4_awqos           (m_axi4_awqos),
                .s_axi4_awvalid         (m_axi4_awvalid),
                .s_axi4_awready         (m_axi4_awready),
                .s_axi4_wdata           (m_axi4_wdata),
                .s_axi4_wstrb           (m_axi4_wstrb),
                .s_axi4_wlast           (m_axi4_wlast),
                .s_axi4_wvalid          (m_axi4_wvalid),
                .s_axi4_wready          (m_axi4_wready),
                .s_axi4_bid             (m_axi4_bid),
                .s_axi4_bresp           (m_axi4_bresp),
                .s_axi4_bvalid          (m_axi4_bvalid),
                .s_axi4_bready          (m_axi4_bready),
                .s_axi4_arid            (m_axi4_arid),
                .s_axi4_araddr          (m_axi4_araddr),
                .s_axi4_arlen           (m_axi4_arlen),
                .s_axi4_arsize          (m_axi4_arsize),
                .s_axi4_arburst         (m_axi4_arburst),
                .s_axi4_arlock          (m_axi4_arlock),
                .s_axi4_arcache         (m_axi4_arcache),
                .s_axi4_arprot          (m_axi4_arprot),
                .s_axi4_arqos           (m_axi4_arqos),
                .s_axi4_arvalid         (m_axi4_arvalid),
                .s_axi4_arready         (m_axi4_arready),
                .s_axi4_rid             (m_axi4_rid),
                .s_axi4_rdata           (m_axi4_rdata),
                .s_axi4_rresp           (m_axi4_rresp),
                .s_axi4_rlast           (m_axi4_rlast),
                .s_axi4_rvalid          (m_axi4_rvalid),
                .s_axi4_rready          (m_axi4_rready)
            );
    
    
    
    // ----------------------------------
    //  WISHBONE master
    // ----------------------------------
    
//    parameter   WB_ADR_WIDTH        = 30;
//    parameter   WB_DAT_WIDTH        = 32;
//    parameter   WB_SEL_WIDTH        = (WB_DAT_WIDTH / 8);
    
    reg     [WB_ADR_WIDTH-1:0]      wb_adr_o;
    wire    [WB_DAT_WIDTH-1:0]      wb_dat_i = s_wb_dat_o;
    reg     [WB_DAT_WIDTH-1:0]      wb_dat_o;
    reg                             wb_we_o;
    reg     [WB_SEL_WIDTH-1:0]      wb_sel_o;
    reg                             wb_stb_o = 0;
    wire                            wb_ack_i = s_wb_ack_o;
    
    initial begin
        force s_wb_adr_i = wb_adr_o;
        force s_wb_dat_i = wb_dat_o;
        force s_wb_we_i  = wb_we_o;
        force s_wb_sel_i = wb_sel_o;
        force s_wb_stb_i = wb_stb_o;
    end
    
    
    reg     [WB_DAT_WIDTH-1:0]      reg_wb_dat;
    reg                             reg_wb_ack;
    always @(posedge wb_clk_i) begin
        if ( ~wb_we_o & wb_stb_o & wb_ack_i ) begin
            reg_wb_dat <= wb_dat_i;
        end
        reg_wb_ack <= wb_ack_i;
    end
    
    
    task wb_write(
                input [WB_ADR_WIDTH-1:0]    adr,
                input [WB_DAT_WIDTH-1:0]    dat,
                input [WB_SEL_WIDTH-1:0]    sel
            );
    begin
        $display("WISHBONE_WRITE(adr:%h dat:%h sel:%b)", adr, dat, sel);
        @(negedge wb_clk_i);
            wb_adr_o = adr;
            wb_dat_o = dat;
            wb_sel_o = sel;
            wb_we_o  = 1'b1;
            wb_stb_o = 1'b1;
        @(negedge wb_clk_i);
            while ( reg_wb_ack == 1'b0 ) begin
                @(negedge wb_clk_i);
            end
            wb_adr_o = {WB_ADR_WIDTH{1'bx}};
            wb_dat_o = {WB_DAT_WIDTH{1'bx}};
            wb_sel_o = {WB_SEL_WIDTH{1'bx}};
            wb_we_o  = 1'bx;
            wb_stb_o = 1'b0;
    end
    endtask
    
    task wb_read(
                input [31:0]    adr
            );
    begin
        @(negedge wb_clk_i);
            wb_adr_o = adr;
            wb_dat_o = {WB_DAT_WIDTH{1'bx}};
            wb_sel_o = {WB_SEL_WIDTH{1'b1}};
            wb_we_o  = 1'b0;
            wb_stb_o = 1'b1;
        @(negedge wb_clk_i);
            while ( reg_wb_ack == 1'b0 ) begin
                @(negedge wb_clk_i);
            end
            wb_adr_o = {WB_ADR_WIDTH{1'bx}};
            wb_dat_o = {WB_DAT_WIDTH{1'bx}};
            wb_sel_o = {WB_SEL_WIDTH{1'bx}};
            wb_we_o  = 1'bx;
            wb_stb_o = 1'b0;
            $display("WISHBONE_READ(adr:%h dat:%h)", adr, reg_wb_dat);
    end
    endtask
    
    
    
    // -------------------------------------
    //  test
    // -------------------------------------
    
    // register address offset
    localparam  ADR_CORE_ID          = 8'h00;
    localparam  ADR_CORE_VERSION     = 8'h01;
    localparam  ADR_CTL_CONTROL      = 8'h04;
    localparam  ADR_CTL_STATUS       = 8'h05;
    localparam  ADR_CTL_INDEX        = 8'h06;
    localparam  ADR_PARAM_ADDR       = 8'h08;
    localparam  ADR_PARAM_SIZE       = 8'h09;
    localparam  ADR_PARAM_AWLEN      = 8'h10;
    localparam  ADR_PARAM_WSTRB      = 8'h11;
    localparam  ADR_PARAM_WTIMEOUT   = 8'h13;
    localparam  ADR_PARAM_ARLEN      = 8'h14;
    localparam  ADR_PARAM_RTIMEOUT   = 8'h17;
    localparam  ADR_CURRENT_ADDR     = 8'h28;
    localparam  ADR_CURRENT_SIZE     = 8'h29;
    localparam  ADR_CURRENT_AWLEN    = 8'h30;
    localparam  ADR_CURRENT_WSTRB    = 8'h31;
    localparam  ADR_CURRENT_WTIMEOUT = 8'h33;
    localparam  ADR_CURRENT_ARLEN    = 8'h34;
    localparam  ADR_CURRENT_RTIMEOUT = 8'h37;
    
    initial begin
        $display("start");
        
    #1000;
        wb_read (ADR_CORE_ID);
        wb_read (ADR_CORE_VERSION);
        
    #10000;
        $display("set parameter");
        wb_write(ADR_PARAM_ADDR,     32'h0000_1000, {WB_SEL_WIDTH{1'b1}});
        wb_write(ADR_PARAM_SIZE,       X_NUM*Y_NUM, {WB_SEL_WIDTH{1'b1}});
        wb_write(ADR_PARAM_AWLEN,    32'h0000_000f, {WB_SEL_WIDTH{1'b1}});
        wb_write(ADR_PARAM_WSTRB,    32'hffff_ffff, {WB_SEL_WIDTH{1'b1}});
        wb_write(ADR_PARAM_WTIMEOUT, 32'h0000_000f, {WB_SEL_WIDTH{1'b1}});
        wb_write(ADR_PARAM_ARLEN,    32'h0000_000f, {WB_SEL_WIDTH{1'b1}});
        wb_write(ADR_PARAM_RTIMEOUT, 32'h0000_000f, {WB_SEL_WIDTH{1'b1}});
        
    #1000;
        $display("start");
        wb_write(ADR_CTL_CONTROL,    32'h0000_0003, {WB_SEL_WIDTH{1'b1}});
        
        
    #400000;
          $display("stop");
          wb_write(ADR_CTL_CONTROL,    32'h0000_0000, {WB_SEL_WIDTH{1'b1}});
    
    #100000;
        $display("change parameter");
        wb_write(ADR_PARAM_ADDR,     32'h0000_2340, {WB_SEL_WIDTH{1'b1}});
        wb_write(ADR_PARAM_SIZE,     32'h0000_0380, {WB_SEL_WIDTH{1'b1}});
        wb_write(ADR_PARAM_AWLEN,    32'h0000_0000, {WB_SEL_WIDTH{1'b1}});
        wb_write(ADR_PARAM_WSTRB,    32'hffff_ffff, {WB_SEL_WIDTH{1'b1}});
        wb_write(ADR_PARAM_WTIMEOUT, 32'h0000_0000, {WB_SEL_WIDTH{1'b1}});
        wb_write(ADR_PARAM_ARLEN,    32'h0000_0000, {WB_SEL_WIDTH{1'b1}});
        wb_write(ADR_PARAM_RTIMEOUT, 32'h0000_0000, {WB_SEL_WIDTH{1'b1}});
        
    #1000;
        $display("start");
        wb_write(ADR_CTL_CONTROL,    32'h0000_0003, {WB_SEL_WIDTH{1'b1}});
        
    #400000;
          $display("stop");
          wb_write(ADR_CTL_CONTROL,    32'h0000_0000, {WB_SEL_WIDTH{1'b1}});
        
    #100000;
          $finish();
    end
    
    
endmodule


`default_nettype wire


// end of file
