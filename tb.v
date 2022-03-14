`timescale 1ns / 1ps

module FIR_tb();

    reg clk;
    reg xen;
    reg [-1 : 6] x;
    reg [-1 : 6] x_srl;
    reg [-1 : 6] h;
    wire[-1 : 6] y;
    wire[7 : 0] y_srl;
    reg reset;
 /*   
        x[0] = 8'b00001101;
        x[1] = 8'b11100110;
        x[2] = 8'b00100110;
        x[3] = 8'b11001101;
        h[0] = 8'b11101011;
        h[1] = 8'b00110011;
        h[2] = 8'b00011010;
   */
   
Filter #(.WL(8)) FIR (.clk(clk),.x(x),.h(x),.reset(reset),.enable(xen),.y(y));
srl_filter  SRL (.CLK(clk),.x(x_srl),.h(h),.enable(xen),.y(y_srl));
    //best timing is 10
    
    initial begin
     xen = 0; clk = 0; x_srl = 8'b0;
     x = 8'b0;
     #10 x = 8'b11101011; h = 8'b11101011;
     #10 x = 8'b00110011; h = 8'b00110011;
     #10 x = 8'b00011010; h = 8'b00011010;
     #10 x = 8'b00001101; x_srl = 8'b00001101;
     #10 x = 8'b11100110; x_srl = 8'b11100110;
     #10 x = 8'b00100110; x_srl = 8'b00100110;
     #10 x = 8'b11001101; x_srl = 8'b11001101;
     #10 x = 8'b0; x_srl = 8'b0;
     #20
     #5 $finish;
    
    end
    always begin
        #5 clk = ~clk;
        
    end
endmodule
