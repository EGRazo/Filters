`timescale 1ns / 1ps

module DFF #(WL = 8)
        (input [WL - 1:0] data,
            //input clk,
            //input en,
            output reg [WL - 1:0] q); 

 
always@(data) begin
            
             q <= data;
     end
endmodule