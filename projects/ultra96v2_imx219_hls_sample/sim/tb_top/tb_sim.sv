// ---------------------------------------------------------------------------
//
//                                 Copyright (C) 2015-2020 by Ryuz 
//                                 https://github.com/ryuz/
// ---------------------------------------------------------------------------


`timescale 1ns / 1ps
`default_nettype none


module tb_sim();
    
    initial begin
        $dumpfile("tb_sim.vcd");
        $dumpvars(0, tb_sim);
        
    #100000000
        $finish;
    end
    
    
    parameter   X_NUM = 2048; // 3280 / 2;
    parameter   Y_NUM = 16; // 2464 / 2;


    // ---------------------------------
    //  clock & reset
    // ---------------------------------

    localparam RATE100 = 1000.0/100.00;
    localparam RATE200 = 1000.0/200.00;
    localparam RATE250 = 1000.0/250.00;
    localparam RATE133 = 1000.0/133.33;

    reg			reset = 1;
    initial #100 reset = 0;

    reg			clk100 = 1'b1;
    always #(RATE100/2.0) clk100 <= ~clk100;

    reg			clk200 = 1'b1;
    always #(RATE200/2.0) clk200 <= ~clk200;

    reg			clk250 = 1'b1;
    always #(RATE250/2.0) clk250 <= ~clk250;

    initial begin
      force i_tb_sim_main.i_top.i_design_1.reset = reset;
      force i_tb_sim_main.i_top.i_design_1.clk100 = clk100;
      force i_tb_sim_main.i_top.i_design_1.clk200 = clk200;
      force i_tb_sim_main.i_top.i_design_1.clk250 = clk250;
    end

    
    // ---------------------------------
    //  main
    // ---------------------------------
    
    tb_sim_main
            #(
                .X_NUM  (X_NUM),
                .Y_NUM  (Y_NUM)
            )
        i_sim_main
            (
                .reset  (reset),
                .clk    (clk100)
            );
    
    
    /*
    // ----------------------------------
    //  dummy video
    // ----------------------------------
    
    wire            axi4s_model_aresetn = i_tb_sim_main.i_top.axi4s_cam_aresetn;
    wire            axi4s_model_aclk    = i_tb_sim_main.i_top.axi4s_cam_aclk;
    wire    [0:0]   axi4s_model_tuser;
    wire            axi4s_model_tlast;
    wire    [7:0]   axi4s_model_tdata;
    wire            axi4s_model_tvalid;
    wire            axi4s_model_tready = i_tb_sim_main.i_top.axi4s_csi2_tready;
    
    jelly_axi4s_master_model
            #(
                .AXI4S_DATA_WIDTH   (8),
                .X_NUM              (X_NUM), // (128),
                .Y_NUM              (Y_NUM),   // (128),
//              .PGM_FILE           ("lena_128x128.pgm"),
                .BUSY_RATE          (0), // (50),
                .RANDOM_SEED        (0)
            )
        i_axi4s_master_model
            (
                .aresetn            (axi4s_model_aresetn),
                .aclk               (axi4s_model_aclk),
                
                .m_axi4s_tuser      (axi4s_model_tuser),
                .m_axi4s_tlast      (axi4s_model_tlast),
                .m_axi4s_tdata      (axi4s_model_tdata),
                .m_axi4s_tvalid     (axi4s_model_tvalid),
                .m_axi4s_tready     (axi4s_model_tready)
            );
    
    initial begin
        force i_tb_sim_main.i_top.axi4s_csi2_tuser  = axi4s_model_tuser;
        force i_tb_sim_main.i_top.axi4s_csi2_tlast  = axi4s_model_tlast;
        force i_tb_sim_main.i_top.axi4s_csi2_tdata  = {axi4s_model_tdata, 2'd0};
        force i_tb_sim_main.i_top.axi4s_csi2_tvalid = axi4s_model_tvalid;
    end
    */
    
    
    // ----------------------------------
    //  WISHBONE master
    // ----------------------------------
    
    parameter   WB_ADR_WIDTH        = 30;
    parameter   WB_DAT_WIDTH        = 64;
    parameter   WB_SEL_WIDTH        = (WB_DAT_WIDTH / 8);
    
    wire                            wb_rst_i = i_tb_sim_main.i_top.wb_peri_rst_i;
    wire                            wb_clk_i = i_tb_sim_main.i_top.wb_peri_clk_i;
    reg     [WB_ADR_WIDTH-1:0]      wb_adr_o;
    wire    [WB_DAT_WIDTH-1:0]      wb_dat_i = i_tb_sim_main.i_top.wb_peri_dat_o;
    reg     [WB_DAT_WIDTH-1:0]      wb_dat_o;
    reg                             wb_we_o;
    reg     [WB_SEL_WIDTH-1:0]      wb_sel_o;
    reg                             wb_stb_o = 0;
    wire                            wb_ack_i = i_tb_sim_main.i_top.wb_peri_ack_o;
    
    initial begin
        force i_tb_sim_main.i_top.wb_peri_adr_i = wb_adr_o;
        force i_tb_sim_main.i_top.wb_peri_dat_i = wb_dat_o;
        force i_tb_sim_main.i_top.wb_peri_we_i  = wb_we_o;
        force i_tb_sim_main.i_top.wb_peri_sel_i = wb_sel_o;
        force i_tb_sim_main.i_top.wb_peri_stb_i = wb_stb_o;
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
                input [31:0]    adr,
                input [31:0]    dat,
                input [3:0]     sel
            );
    begin
        $display("WISHBONE_WRITE(adr:%h dat:%h sel:%b)", adr, dat, sel);
        @(negedge wb_clk_i);
            wb_adr_o = (adr >> 3);
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
            wb_adr_o = (adr >> 3);
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
    
    
    
    initial begin
    #1000;
        $display("start");
    
    #1000;
        $display("read core ID");
        wb_read (32'h80000000);     // gid
        wb_read (32'h80100000);     // fmtr
        wb_read (32'h80120000);     // demosaic
        wb_read (32'h80120200);     // col mat
        wb_read (32'h80210000);     // wdma

    #10000;
        $display("set format regularizer");
        wb_read (32'h80100000);                         // CORE ID
        wb_write(32'h80100080,        X_NUM, 4'b1111);  // width
        wb_write(32'h80100088,        Y_NUM, 4'b1111);  // height
        wb_write(32'h80100090,            0, 4'b1111);  // fill
        wb_write(32'h80100098,         1024, 4'b1111);  // timeout
        wb_write(32'h80100020,            1, 4'b1111);  // enable
    #100000;
        
        $display("set write DMA");
        wb_read (32'h80210000);                         // CORE ID
        wb_write(32'h80210040, 32'h30000000, 4'b1111);  // address
        wb_write(32'h80210048,      4*X_NUM, 4'b1111);  // stride
        wb_write(32'h80210050,        X_NUM, 4'b1111);   // width
        wb_write(32'h80210058,        Y_NUM, 4'b1111);  // height
        wb_write(32'h80210060,  X_NUM*Y_NUM, 4'b1111);  // size
        wb_write(32'h80210068,           31, 4'b1111);  // awlen
        wb_write(32'h80210020,            3, 4'b1111);  // update & enable
    #10000;
        wb_read (32'h80210028);  // read status
        wb_read (32'h80210028);  // read status
        wb_read (32'h80210028);  // read status
        wb_read (32'h80210028);  // read status
        
    #10000;
        wb_write(32'h80210020, 0, 4'b1111); // stop
        
        // 取り込み完了を待つ
        wb_read(32'h80210028);
        while ( reg_wb_dat != 0 ) begin
            #10000;
            wb_read(32'h80210028);
        end
        #10000;
        
        
        // サイズを不整合で書いてみる(デッドロックしない確認)
        wb_write(32'h80210040, 32'h30000000, 4'b1111);  // address
        wb_write(32'h80210048,        4*128, 4'b1111);  // stride
        wb_write(32'h80210050,       256+64, 4'b1111);  // width
        wb_write(32'h80210058,           64, 4'b1111);  // height
        wb_write(32'h80210060,       256*64, 4'b1111);  // size
        wb_write(32'h80210068,           31, 4'b1111);  // awlen
        wb_write(32'h80210020,            7, 4'b1111);  // update & enable (one shot)
    #10000;
        
        // 取り込み完了を待つ
        wb_read(32'h80210028);
        while ( reg_wb_dat != 0 ) begin
            #10000;
            wb_read(32'h80210028);
        end
    #10000;
        $finish();
    end
    
    
endmodule


`default_nettype wire


// end of file