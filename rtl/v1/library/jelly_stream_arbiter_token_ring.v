// ---------------------------------------------------------------------------
//  Jelly  -- The platform for real-time computing
//
//                                 Copyright (C) 2008-2020 by Ryuji Fuchikami
//                                 https://github.com/ryuz/jelly.git
// ---------------------------------------------------------------------------



`timescale 1ns / 1ps
`default_nettype none



// ring bus unit
module jelly_stream_arbiter_token_ring
        #(
            parameter   S_NUM         = 8,
            parameter   S_ID_WIDTH    = 3,
            parameter   M_NUM         = 4,
            parameter   M_ID_WIDTH    = 2,
            parameter   DATA_WIDTH    = 32,
            parameter   NO_RING       = 0
        )
        (
            input   wire                            reset,
            input   wire                            clk,
            input   wire                            cke,
            
            input   wire    [S_NUM*M_ID_BITS-1:0]   s_id_to,
            input   wire    [S_NUM-1:0]             s_last,
            input   wire    [S_NUM*DATA_WIDTH-1:0]  s_data,
            input   wire    [S_NUM-1:0]             s_valid,
            output  wire    [S_NUM-1:0]             s_ready,
            
            output  wire    [M_NUM*S_ID_BITS-1:0]   m_id_from,
            output  wire    [M_NUM-1:0]             m_last,
            output  wire    [M_NUM*DATA_WIDTH-1:0]  m_data,
            output  wire    [M_NUM-1:0]             m_valid,
            input   wire    [M_NUM-1:0]             m_ready
        );
    
    genvar      i;
    
    
    localparam  S_ID_BITS = S_ID_WIDTH > 0 ? S_ID_WIDTH : 1;
    localparam  M_ID_BITS = M_ID_WIDTH > 0 ? M_ID_WIDTH : 1;
    
    wire    [(S_NUM+1)*M_ID_BITS-1:0]       ringbus_s_id_to;
    wire    [(S_NUM+1)*S_ID_BITS-1:0]       ringbus_s_id_from;
    wire    [(S_NUM+1)-1:0]                 ringbus_s_last;
    wire    [(S_NUM+1)*DATA_WIDTH-1:0]      ringbus_s_data;
    wire    [(S_NUM+1)-1:0]                 ringbus_s_valid;
    wire    [(S_NUM+1)-1:0]                 ringbus_s_token;
    
    wire    [(M_NUM+1)*M_ID_BITS-1:0]       ringbus_m_id_to;
    wire    [(M_NUM+1)*S_ID_BITS-1:0]       ringbus_m_id_from;
    wire    [(M_NUM+1)-1:0]                 ringbus_m_last;
    wire    [(M_NUM+1)*DATA_WIDTH-1:0]      ringbus_m_data;
    wire    [(M_NUM+1)-1:0]                 ringbus_m_valid;
    
    generate
    for ( i = 0; i < S_NUM; i = i + 1 ) begin : loop_s
        jelly_stream_token_ring_unit
                #(
                    .DATA_WIDTH             (DATA_WIDTH),
                    .ID_TO_WIDTH            (M_ID_WIDTH),
                    .ID_FROM_WIDTH          (S_ID_WIDTH),
                    .UNIT_ID_TO             (0),
                    .UNIT_ID_FROM           (i),
                    .INIT_TOKEN             (i==0)
                )
            i_stream_token_ring_unit_s
                (
                    .reset                  (reset),
                    .clk                    (clk),
                    .cke                    (cke),
                    
                    .s_id_to                (s_id_to[i*M_ID_BITS  +: M_ID_BITS]),
                    .s_last                 (s_last [i]),
                    .s_data                 (s_data [i*DATA_WIDTH +: DATA_WIDTH]),
                    .s_valid                (s_valid[i]),
                    .s_ready                (s_ready[i]),
                    
                    .m_id_from              (),
                    .m_last                 (),
                    .m_data                 (),
                    .m_valid                (),
                    .m_ready                (1'b0),
                    
                    .src_id_to              (ringbus_s_id_to  [(i+1)*M_ID_BITS  +: M_ID_BITS]),
                    .src_id_from            (ringbus_s_id_from[(i+1)*S_ID_BITS  +: S_ID_BITS]),
                    .src_last               (ringbus_s_last   [(i+1)]),
                    .src_data               (ringbus_s_data   [(i+1)*DATA_WIDTH +: DATA_WIDTH]),
                    .src_valid              (ringbus_s_valid  [(i+1)]),
                    .src_token              (ringbus_s_token  [(i+1)]),
                    
                    .sink_id_to             (ringbus_s_id_to  [(i+0)*M_ID_BITS  +: M_ID_BITS]),
                    .sink_id_from           (ringbus_s_id_from[(i+0)*S_ID_BITS  +: S_ID_BITS]),
                    .sink_last              (ringbus_s_last   [(i+0)]),
                    .sink_data              (ringbus_s_data   [(i+0)*DATA_WIDTH +: DATA_WIDTH]),
                    .sink_valid             (ringbus_s_valid  [(i+0)]),
                    .sink_token             (ringbus_s_token  [(i+0)])
                );
    end
    
    // token ring
    assign ringbus_s_token[S_NUM] = ringbus_s_token[0];
    
    
    for ( i = 0; i < M_NUM; i = i + 1 ) begin : loop_m
        jelly_stream_token_ring_unit
                #(
                    .DATA_WIDTH             (DATA_WIDTH),
                    .ID_TO_WIDTH            (M_ID_WIDTH),
                    .ID_FROM_WIDTH          (S_ID_WIDTH),
                    .UNIT_ID_TO             (i),
                    .UNIT_ID_FROM           (0),
                    .INIT_TOKEN             (0)
                )
            i_stream_token_ring_unit_m
                (
                    .reset                  (reset),
                    .clk                    (clk),
                    .cke                    (cke),
                    
                    .s_id_to                ({M_ID_BITS{1'bx}}),
                    .s_data                 ({DATA_WIDTH{1'bx}}),
                    .s_last                 (1'bx),
                    .s_valid                (1'b0),
                    .s_ready                (),
                    
                    .m_id_from              (m_id_from[i*S_ID_BITS  +: S_ID_BITS]),
                    .m_last                 (m_last   [i]),
                    .m_data                 (m_data   [i*DATA_WIDTH +: DATA_WIDTH]),
                    .m_valid                (m_valid  [i]),
                    .m_ready                (m_ready  [i]),
                    
                    .src_id_to              (ringbus_m_id_to  [(i+1)*M_ID_BITS  +: M_ID_BITS]),
                    .src_id_from            (ringbus_m_id_from[(i+1)*S_ID_BITS  +: S_ID_BITS]),
                    .src_last               (ringbus_m_last   [(i+1)]),
                    .src_data               (ringbus_m_data   [(i+1)*DATA_WIDTH +: DATA_WIDTH]),
                    .src_valid              (ringbus_m_valid  [(i+1)]),
                    .src_token              (1'b0),
                    
                    .sink_id_to             (ringbus_m_id_to  [(i+0)*M_ID_BITS  +: M_ID_BITS]),
                    .sink_id_from           (ringbus_m_id_from[(i+0)*S_ID_BITS  +: S_ID_BITS]),
                    .sink_last              (ringbus_m_last   [(i+0)]),
                    .sink_data              (ringbus_m_data   [(i+0)*DATA_WIDTH +: DATA_WIDTH]),
                    .sink_valid             (ringbus_m_valid  [(i+0)]),
                    .sink_token             ()
                );
    end
    endgenerate
    
    
    generate
    if ( NO_RING ) begin : blk_no_ring
        assign ringbus_m_id_to  [M_NUM*M_ID_BITS  +: M_ID_BITS]  = {M_ID_BITS{1'bx}};
        assign ringbus_m_id_from[M_NUM*S_ID_BITS  +: S_ID_BITS]  = {S_ID_BITS{1'bx}};
        assign ringbus_m_last   [M_NUM]                          = 1'bx;
        assign ringbus_m_data   [M_NUM*DATA_WIDTH +: DATA_WIDTH] = {DATA_WIDTH{1'bx}};
        assign ringbus_m_valid  [M_NUM]                          = 1'b0;
        
        assign ringbus_s_id_to  [S_NUM*M_ID_BITS  +: M_ID_BITS]  = {M_ID_BITS{1'bx}};
        assign ringbus_s_id_from[S_NUM*S_ID_BITS  +: S_ID_BITS]  = {S_ID_BITS{1'bx}};
        assign ringbus_s_last   [S_NUM]                          = 1'bx;
        assign ringbus_s_data   [S_NUM*DATA_WIDTH +: DATA_WIDTH] = {DATA_WIDTH{1'bx}};
        assign ringbus_s_valid  [S_NUM]                          = 1'b0;
    end
    else begin : blk_ring
        assign ringbus_m_id_to  [M_NUM*M_ID_BITS  +: M_ID_BITS]  = ringbus_s_id_to  [0*M_ID_BITS  +: M_ID_BITS];
        assign ringbus_m_id_from[M_NUM*S_ID_BITS  +: S_ID_BITS]  = ringbus_s_id_from[0*S_ID_BITS  +: S_ID_BITS];
        assign ringbus_m_last   [M_NUM]                          = ringbus_s_last   [0];
        assign ringbus_m_data   [M_NUM*DATA_WIDTH +: DATA_WIDTH] = ringbus_s_data   [0*DATA_WIDTH +: DATA_WIDTH];
        assign ringbus_m_valid  [M_NUM]                          = ringbus_s_valid  [0];
        
        assign ringbus_s_id_to  [S_NUM*M_ID_BITS  +: M_ID_BITS]  = ringbus_m_id_to  [0*M_ID_BITS  +: M_ID_BITS];
        assign ringbus_s_id_from[S_NUM*S_ID_BITS  +: S_ID_BITS]  = ringbus_m_id_from[0*S_ID_BITS  +: S_ID_BITS];
        assign ringbus_s_last   [S_NUM]                          = ringbus_m_last   [0];
        assign ringbus_s_data   [S_NUM*DATA_WIDTH +: DATA_WIDTH] = ringbus_m_data   [0*DATA_WIDTH +: DATA_WIDTH];
        assign ringbus_s_valid  [S_NUM]                          = ringbus_m_valid  [0];
    end
    endgenerate
    

endmodule



`default_nettype wire


// end of file
