// ---------------------------------------------------------------------------
//  Jelly  -- The platform for real-time computing
//
//                                 Copyright (C) 2008-2020 by Ryuz
//                                 https://github.com/ryuz/jelly.git
// ---------------------------------------------------------------------------



`timescale 1ns / 1ps
`default_nettype none



// joint
module jelly_data_joint
        #(
            parameter   NUM         = 16,
            parameter   ID_WIDTH    = 4,
            parameter   DATA_WIDTH  = 32,
            parameter   S_REGS      = 1,
            parameter   M_REGS      = 1,
            parameter   ALGORITHM   = "PRIORITY",
            parameter   USE_M_READY = 1,
            parameter   NO_CONFLICT = 0
        )
        (
            input   wire                            reset,
            input   wire                            clk,
            input   wire                            cke,
            
            input   wire    [NUM*DATA_WIDTH-1:0]    s_data,
            input   wire    [NUM-1:0]               s_valid,
            output  wire    [NUM-1:0]               s_ready,
            
            output  wire    [ID_WIDTH-1:0]          m_id,
            output  wire    [DATA_WIDTH-1:0]        m_data,
            output  wire                            m_valid,
            input   wire                            m_ready
        );
    
    generate
    if ( ALGORITHM == "RINGBUS" ) begin : blk_ringbus
        jelly_data_arbiter_ring_bus
                #(
                    .S_NUM          (NUM),
                    .S_ID_WIDTH     (ID_WIDTH),
                    .M_NUM          (1),
                    .M_ID_WIDTH     (1),
                    .DATA_WIDTH     (DATA_WIDTH),
                    .NO_RING        (!USE_M_READY)
                )
            i_data_arbiter_ring_bus
                (
                    .reset          (reset),
                    .clk            (clk),
                    .cke            (cke),
                    
                    .s_id_to        (1'b0),
                    .s_data         (s_data),
                    .s_valid        (s_valid),
                    .s_ready        (s_ready),
                    
                    .m_id_from      (m_id),
                    .m_data         (m_data),
                    .m_valid        (m_valid),
                    .m_ready        (m_ready)
                );
    end
    else begin : blk_priority
        jelly_data_joint_priority
                #(
                    .NUM                (NUM),
                    .DATA_WIDTH         (DATA_WIDTH),
                    .NO_CONFLICT        (NO_CONFLICT),
                    .S_REGS             (S_REGS),
                    .M_REGS             (M_REGS)
                )
            i_data_joint_priority
                (
                    .reset              (reset),
                    .clk                (clk),
                    .cke                (cke),
                    
                    .s_data             (s_data ),
                    .s_valid            (s_valid),
                    .s_ready            (s_ready),
                    
                    .m_id               (m_id),
                    .m_data             (m_data ),
                    .m_valid            (m_valid),
                    .m_ready            (m_ready)
                );
    end
    endgenerate
    
endmodule



`default_nettype wire


// end of file
