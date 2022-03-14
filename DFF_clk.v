`timescale 1ns / 1ps

module dff#(WL = 8)
        (input CLK,
            input rst,
            input signed [WL - 1:0] in,
            output reg signed [WL - 1:0] out);
    initial out <= 0;
  
    always@(posedge CLK) begin
    //if(rst) begin
            //q <= 8'b0;
        //end
        //else begin
            out <= in;
     //end
    end
endmodule