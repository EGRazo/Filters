`timescale 1ns / 1ps

module Top ();
parameter WL = 32;

reg signed [WL - 1 : 0] x_in;

wire signed [WL - 1 : 0] out;
//Testing clock for testing purposes
reg clk;

reg [WL - 1 : 0] counter = 0;

Filter FIR (.xin(x_in) ,. clk(clk) ,.yout(out));

initial begin
    clk = 0;
    counter = 0;
end

always @(posedge clk) begin
     x_in = 0;
    #10 x_in = -1;
    #10 x_in = -2;
    #10 x_in = 3;
    #10 x_in = 4;
    #10 x_in = -5;
    #10 x_in = 1;
    #10 x_in = 0;
    #10 x_in = 3;
    #10 x_in = 4;
    #10 x_in = 1;
    #10 x_in = 2;
    #10 x_in = 3;
    #10 x_in = 4;
    #10 x_in = 2;
    #10 x_in = -1;
    #10 x_in = 3;
    #10 x_in = 2;
    #10 x_in = 6;
    #10 x_in = 1;
    #10 x_in = -1;
    #10 x_in = 7;
    #10 $finish;
    

end


//Testing Clock Manual Simulation
always begin
    #5 clk = ~clk;
end          
                  
endmodule
