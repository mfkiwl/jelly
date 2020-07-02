// ---------------------------------------------------------------------------
//  Jelly  -- the soft-core processor system
//   image processing
//
//                                 Copyright (C) 2008-2018 by Ryuji Fuchikami
//                                 http://ryuz.my.coocan.jp/
// ---------------------------------------------------------------------------



`timescale 1ns / 1ps
`default_nettype none


// �񓯊��N���b�N�Ԃł̃p�����[�^�A�b�v�f�[�g(���葤)
module jelly_param_update_master
        #(
            parameter   INDEX_WIDTH = 1
        )
        (
            input   wire                        reset,
            input   wire                        clk,
            input   wire                        cke,
            
            input   wire                        in_index,
            
            output  wire                        out_ack,
            output  wire    [INDEX_WIDTH-1:0]   out_index
        );
    
    // parameter latch
    (* ASYNC_REG="true" *)  reg     [INDEX_WIDTH-1:0]   ff0_index, ff1_index;
    always @(posedge clk) begin
        ff0_index <= in_index;
        ff1_index <= ff0_index;
    end
    
    reg     [INDEX_WIDTH-1:0]   reg_index;
    reg                         reg_ack;
    always @(posedge clk) begin
        if ( reset ) begin
            reg_index <= {INDEX_WIDTH{1'b0}};
            reg_ack   <= 1'b0;
        end
        else if ( cke ) begin
            reg_index <= ff1_index;
            reg_ack   <= (reg_index != ff1_index);
        end
    end
    
    assign out_ack    = reg_ack;
    assign out_index  = reg_index;
    
endmodule


`default_nettype wire


// end of file