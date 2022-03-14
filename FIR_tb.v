`timescale 1ns / 1ps

module FIR_tb();

    reg clk;
    reg hen;
    reg xen;
    reg [0 : 4] address;
    reg [-1 : 6] x;
    reg [-1 : 6] h;
    wire[-1 : 6] y;
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
   
FIR_Filter #(.WL(8)) FIR (.clk(clk),.x(x),.h(h),.x_en(xen),.y(y));
//fir_gen #(.W1(8),.W2(16),.W3(17),.W4(8),.L(3)) fir (.clk(clk),.reset(reset),.Load_x(xen),.x_in(x),.c_in(h),.y_out(y));
    
     reg [5:0] count;
    
    initial begin
     xen = 1; reset = 1; clk = 0; x = 8'b0;
       #10 reset = 0;
       #10 h = 8'b11101011;
       #10 h = 8'b00110011;
       #10 h = 8'b00011010;  
       #15 xen = 0;
       #10 x = 8'b00001101;
       #10 x = 8'b11100110;
       #10 x = 8'b00100110;
       #10 x = 8'b11001101;
       #10 x = 8'b0;
       #100
        $finish;
    end
    
    always begin
        #5 clk = ~clk;
        
    end
endmodule
