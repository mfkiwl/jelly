// ---------------------------------------------------------------------------
//  Jelly  -- The platform for real-time computing
//
//
//                                 Copyright (C) 2008-2018 by Ryuji Fuchikami
//                                 https://github.com/ryuz/jelly.git
// ---------------------------------------------------------------------------



`timescale 1ns / 1ps
`default_nettype none


module jelly2_video_format_regularizer
        #(
            parameter   int                             TUSER_WIDTH           = 1,
            parameter   int                             TDATA_WIDTH           = 24,
            parameter   int                             X_WIDTH               = 16,
            parameter   int                             Y_WIDTH               = 16,
            parameter   int                             FRAME_TIMER_WIDTH     = 32,
            parameter   int                             TIMER_WIDTH           = 32,
            parameter   bit                             S_SLAVE_REGS          = 1,
            parameter   bit                             S_MASTER_REGS         = 1,
            parameter   bit                             M_SLAVE_REGS          = 1,
            parameter   bit                             M_MASTER_REGS         = 1,

            parameter   int                             WB_ADR_WIDTH          = 8,
            parameter   int                             WB_DAT_WIDTH          = 32,
            parameter   int                             WB_SEL_WIDTH          = (WB_DAT_WIDTH / 8),

            parameter                                   CORE_ID               = 32'h527a_1220,
            parameter                                   CORE_VERSION          = 32'h0001_0000,
            parameter   int                             INDEX_WIDTH           = 1,
            
            parameter   bit     [1:0]                   INIT_CTL_CONTROL      = 2'b00,
            parameter   bit                             INIT_CTL_SKIP         = 1,
            parameter   bit                             INIT_CTL_FRM_TIMER_EN = 0,
            parameter   bit     [FRAME_TIMER_WIDTH-1:0] INIT_CTL_FRM_TIMEOUT  = 1000000,
            parameter   bit     [X_WIDTH-1:0]           INIT_PARAM_WIDTH      = 640,
            parameter   bit     [Y_WIDTH-1:0]           INIT_PARAM_HEIGHT     = 480,
            parameter   bit     [TDATA_WIDTH-1:0]       INIT_PARAM_FILL       = {TDATA_WIDTH{1'b0}},
            parameter   bit     [TIMER_WIDTH-1:0]       INIT_PARAM_TIMEOUT    = 0
        )
        (
            input   wire                        aresetn,
            input   wire                        aclk,
            input   wire                        aclken,
                        
            output  wire    [X_WIDTH-1:0]       out_param_width,
            output  wire    [Y_WIDTH-1:0]       out_param_height,
            
            input   wire    [TUSER_WIDTH-1:0]   s_axi4s_tuser,
            input   wire                        s_axi4s_tlast,
            input   wire    [TDATA_WIDTH-1:0]   s_axi4s_tdata,
            input   wire                        s_axi4s_tvalid,
            output  wire                        s_axi4s_tready,
            
            output  wire    [TUSER_WIDTH-1:0]   m_axi4s_tuser,
            output  wire                        m_axi4s_tlast,
            output  wire    [TDATA_WIDTH-1:0]   m_axi4s_tdata,
            output  wire                        m_axi4s_tvalid,
            input   wire                        m_axi4s_tready,

            input   wire                        s_wb_rst_i,
            input   wire                        s_wb_clk_i,
            input   wire    [WB_ADR_WIDTH-1:0]  s_wb_adr_i,
            input   wire    [WB_DAT_WIDTH-1:0]  s_wb_dat_i,
            output  reg     [WB_DAT_WIDTH-1:0]  s_wb_dat_o,
            input   wire                        s_wb_we_i,
            input   wire    [WB_SEL_WIDTH-1:0]  s_wb_sel_i,
            input   wire                        s_wb_stb_i,
            output  reg                         s_wb_ack_o
        );
    
    
    // -------------------------------------
    //  registers
    // -------------------------------------
    
    // register address offset
    localparam  ADR_CORE_ID            = 8'h00;
    localparam  ADR_CORE_VERSION       = 8'h01;
    localparam  ADR_CTL_CONTROL        = 8'h04;
    localparam  ADR_CTL_STATUS         = 8'h05;
    localparam  ADR_CTL_INDEX          = 8'h07;
    localparam  ADR_CTL_SKIP           = 8'h08;
    localparam  ADR_CTL_FRM_TIMER_EN   = 8'h0a;
    localparam  ADR_CTL_FRM_TIMEOUT    = 8'h0b;
    localparam  ADR_PARAM_WIDTH        = 8'h10;
    localparam  ADR_PARAM_HEIGHT       = 8'h11;
    localparam  ADR_PARAM_FILL         = 8'h12;
    localparam  ADR_PARAM_TIMEOUT      = 8'h13;
    
    // registers
    reg     [1:0]                   reg_ctl_control;
    reg                             reg_ctl_skip;
    reg                             reg_ctl_frm_timer_en;
    reg     [FRAME_TIMER_WIDTH-1:0] reg_ctl_frm_timeout;

    reg     [X_WIDTH-1:0]           reg_param_width;
    reg     [Y_WIDTH-1:0]           reg_param_height;
    reg     [TDATA_WIDTH-1:0]       reg_param_fill;
    reg     [TIMER_WIDTH-1:0]       reg_param_timeout;
    
    // status
    wire                            busy;
    wire    [INDEX_WIDTH-1:0]       index;
    
    // latch core domein signals
    (* ASYNC_REG = "true" *)    reg                         ff0_busy,  ff1_busy;
    (* ASYNC_REG = "true" *)    reg     [INDEX_WIDTH-1:0]   ff0_index, ff1_index, ff2_index;
    always_ff @(posedge s_wb_clk_i) begin
        ff0_busy  <= busy;
        ff1_busy  <= ff0_busy;
        
        ff0_index <= index;
        ff1_index <= ff0_index;
        ff2_index <= ff1_index;
    end
    
    function [WB_DAT_WIDTH-1:0] reg_mask(
                                        input [WB_DAT_WIDTH-1:0] org,
                                        input [WB_DAT_WIDTH-1:0] wdat,
                                        input [WB_SEL_WIDTH-1:0] msk
                                    );
    begin
        for ( int i = 0; i < WB_DAT_WIDTH; ++i ) begin
            reg_mask[i] = msk[i/8] ? wdat[i] : org[i];
        end
    end
    endfunction
    
    always_ff @(posedge s_wb_clk_i) begin
        if ( s_wb_rst_i ) begin
            reg_ctl_control      <= INIT_CTL_CONTROL;
            reg_ctl_skip         <= INIT_CTL_SKIP;
            reg_ctl_frm_timer_en <= INIT_CTL_FRM_TIMER_EN;
            reg_ctl_frm_timeout  <= INIT_CTL_FRM_TIMEOUT;
            reg_param_width      <= INIT_PARAM_WIDTH;
            reg_param_height     <= INIT_PARAM_HEIGHT;
            reg_param_fill       <= INIT_PARAM_FILL;
            reg_param_timeout    <= INIT_PARAM_TIMEOUT;
        end
        else begin
            if ( ff1_index[0] != ff2_index[0] ) begin
                reg_ctl_control[1] <= 1'b0;     // auto clear
            end
            
            if ( s_wb_stb_i && s_wb_we_i ) begin
                case ( s_wb_adr_i )
                ADR_CTL_CONTROL:        reg_ctl_control      <=                 2'(reg_mask(WB_DAT_WIDTH'(reg_ctl_control),      s_wb_dat_i, s_wb_sel_i));
                ADR_CTL_SKIP:           reg_ctl_skip         <=                 1'(reg_mask(WB_DAT_WIDTH'(reg_ctl_skip),         s_wb_dat_i, s_wb_sel_i));
                ADR_CTL_FRM_TIMER_EN:   reg_ctl_frm_timer_en <=                 1'(reg_mask(WB_DAT_WIDTH'(reg_ctl_frm_timer_en), s_wb_dat_i, s_wb_sel_i));
                ADR_CTL_FRM_TIMEOUT:    reg_ctl_frm_timeout  <= FRAME_TIMER_WIDTH'(reg_mask(WB_DAT_WIDTH'(reg_ctl_frm_timeout),  s_wb_dat_i, s_wb_sel_i));
                ADR_PARAM_WIDTH:        reg_param_width      <=           X_WIDTH'(reg_mask(WB_DAT_WIDTH'(reg_param_width),      s_wb_dat_i, s_wb_sel_i));
                ADR_PARAM_HEIGHT:       reg_param_height     <=           Y_WIDTH'(reg_mask(WB_DAT_WIDTH'(reg_param_height),     s_wb_dat_i, s_wb_sel_i));
                ADR_PARAM_FILL:         reg_param_fill       <=       TDATA_WIDTH'(reg_mask(WB_DAT_WIDTH'(reg_param_fill),       s_wb_dat_i, s_wb_sel_i));
                ADR_PARAM_TIMEOUT:      reg_param_timeout    <=       TIMER_WIDTH'(reg_mask(WB_DAT_WIDTH'(reg_param_timeout),    s_wb_dat_i, s_wb_sel_i));
                default: ;
                endcase
            end
        end
    end
    
    // read
    always_comb begin
        s_wb_dat_o = '0;
        case ( s_wb_adr_i )
        ADR_CORE_ID:            s_wb_dat_o = WB_DAT_WIDTH'(CORE_ID             );
        ADR_CORE_VERSION:       s_wb_dat_o = WB_DAT_WIDTH'(CORE_VERSION        );
        ADR_CTL_CONTROL:        s_wb_dat_o = WB_DAT_WIDTH'(reg_ctl_control     );
        ADR_CTL_STATUS:         s_wb_dat_o = WB_DAT_WIDTH'(ff1_busy            );
        ADR_CTL_INDEX:          s_wb_dat_o = WB_DAT_WIDTH'(ff1_index           );
        ADR_CTL_SKIP:           s_wb_dat_o = WB_DAT_WIDTH'(reg_ctl_skip        );
        ADR_CTL_FRM_TIMER_EN:   s_wb_dat_o = WB_DAT_WIDTH'(reg_ctl_frm_timer_en);
        ADR_CTL_FRM_TIMEOUT:    s_wb_dat_o = WB_DAT_WIDTH'(reg_ctl_frm_timeout );
        ADR_PARAM_WIDTH:        s_wb_dat_o = WB_DAT_WIDTH'(reg_param_width     );
        ADR_PARAM_HEIGHT:       s_wb_dat_o = WB_DAT_WIDTH'(reg_param_height    );
        ADR_PARAM_FILL:         s_wb_dat_o = WB_DAT_WIDTH'(reg_param_fill      );
        ADR_PARAM_TIMEOUT:      s_wb_dat_o = WB_DAT_WIDTH'(reg_param_timeout   );
        default: ;
        endcase
    end

    always_comb s_wb_ack_o = s_wb_stb_i;
    
    
    
    // -------------------------------------
    //  core
    // -------------------------------------
    
    // core
    (* ASYNC_REG = "true" *)    logic     ff0_ctl_enable,        ff1_ctl_enable,    ff2_ctl_enable;
    (* ASYNC_REG = "true" *)    logic     ff0_ctl_update,        ff1_ctl_update;
    (* ASYNC_REG = "true" *)    logic     ff0_ctl_skip,          ff1_ctl_skip;
    (* ASYNC_REG = "true" *)    logic     ff0_ctl_frm_timer_en,  ff1_ctl_frm_timer_en;
    
    always_ff @(posedge aclk) begin
        if ( ~aresetn ) begin
            ff0_ctl_enable       <= 1'b0;
            ff1_ctl_enable       <= 1'b0;
            ff2_ctl_enable       <= 1'b0;
            
            ff0_ctl_update       <= 1'b0;
            ff1_ctl_update       <= 1'b0;
            
            ff0_ctl_skip         <= 1'b0;
            ff1_ctl_skip         <= 1'b0;
            
            ff0_ctl_frm_timer_en <= 1'b0;
            ff1_ctl_frm_timer_en <= 1'b0;
        end
        else begin
            ff0_ctl_enable       <= reg_ctl_control[0];
            ff1_ctl_enable       <= ff0_ctl_enable;
            ff2_ctl_enable       <= ff1_ctl_enable;

            ff0_ctl_update       <= reg_ctl_control[1];
            ff1_ctl_update       <= ff0_ctl_update;

            ff0_ctl_skip         <= reg_ctl_skip;
            ff1_ctl_skip         <= ff0_ctl_skip;
            
            ff0_ctl_frm_timer_en <= reg_ctl_frm_timer_en;
            ff1_ctl_frm_timer_en <= ff0_ctl_frm_timer_en;
        end
    end
    
    // core
    jelly_video_format_regularizer_core
            #(
                .TUSER_WIDTH        (TUSER_WIDTH),
                .TDATA_WIDTH        (TDATA_WIDTH),
                .INDEX_WIDTH        (INDEX_WIDTH),
                .X_WIDTH            (X_WIDTH),
                .Y_WIDTH            (Y_WIDTH),
                .TIMER_WIDTH        (TIMER_WIDTH),
                .S_SLAVE_REGS       (S_SLAVE_REGS),
                .S_MASTER_REGS      (S_MASTER_REGS),
                .M_SLAVE_REGS       (M_SLAVE_REGS),
                .M_MASTER_REGS      (M_MASTER_REGS)
            )
        i_video_format_regularizer_core
            (
                .aresetn            (aresetn),
                .aclk               (aclk),
                .aclken             (aclken),
                
                .ctl_enable         (ff2_ctl_enable),
                .ctl_busy           (busy),
                .ctl_update         (ff1_ctl_enable),
                .ctl_index          (index),
                .ctl_skip           (ff1_ctl_skip),
                .ctl_frm_timer_en   (ff1_ctl_frm_timer_en),
                .ctl_frm_timeout    (reg_ctl_frm_timeout),
                
                .param_width        (reg_param_width),
                .param_height       (reg_param_height),
                .param_fill         (reg_param_fill),
                .param_timeout      (reg_param_timeout),

                .current_width      (out_param_width),
                .current_height     (out_param_height),

                .s_axi4s_tuser      (s_axi4s_tuser),
                .s_axi4s_tlast      (s_axi4s_tlast),
                .s_axi4s_tdata      (s_axi4s_tdata),
                .s_axi4s_tvalid     (s_axi4s_tvalid),
                .s_axi4s_tready     (s_axi4s_tready),
                
                .m_axi4s_tuser      (m_axi4s_tuser),
                .m_axi4s_tlast      (m_axi4s_tlast),
                .m_axi4s_tdata      (m_axi4s_tdata),
                .m_axi4s_tvalid     (m_axi4s_tvalid),
                .m_axi4s_tready     (m_axi4s_tready)
            );
    
endmodule



`default_nettype wire



// end of file
