`timescale 1ns / 1ps

module Filter #(parameter WL = 8)
            (input clk,
                input signed [WL -1 :0] x,
                input signed [WL -1 :0] h,
                input enable,
                input reset,
                output reg signed [WL -1:0] y);
    wire [WL - 1 : 0] M [0:2];
    wire [WL - 1 : 0] D [0:1];
    wire [WL - 1 : 0] A [0:1];
    reg [WL - 1 : 0] h_temp [0:2];
    reg [WL - 1 : 0] x_temp;
    wire [WL - 1 : 0] x_in;
    wire [WL - 1 : 0] x_in1;
    wire [WL - 1 : 0] y_out;
    reg [3:0] counter = 3'b0;
    //wire reset;
    wire OVF_Flag [0:2];
    wire OVF_Flaga [0:1];
  
    initial begin
        x_temp <=  8'b0;
    end
  
   
    //Never reset the arithmetic operations
    fpmult #(.WI1(2),.WF1(6),.WI2(2),.WF2(6),.WIO(2),.WFO(6)) M2 (.RESET(1'b0),.in1(h_temp[2]),.in2(x_in1),.out(M[2]),.OVF(OVF_Flag[2]));
    fpmult #(.WI1(2),.WF1(6),.WI2(2),.WF2(6),.WIO(2),.WFO(6)) M1 (.RESET(1'b0),.in1(h_temp[1]),.in2(x_in),.out(M[1]),.OVF(OVF_Flag[1]));
    fpmult #(.WI1(2),.WF1(6),.WI2(2),.WF2(6),.WIO(2),.WFO(6)) M0 (.RESET(1'b0),.in1(h_temp[0]),.in2(x_temp),.out(M[0]),.OVF(OVF_Flag[0]));
    
    dff #(.WL(8)) D2 (.CLK(clk),.rst(reset),.in(x_temp),.out(x_in));
    dff #(.WL(8)) D1 (.CLK(clk),.rst(reset),.in(x_in),.out(x_in1));
    //dff #(.WL(8)) X (.clk(clk),.rst(reset),.d(x_in),.q(x_temp));
    
    fpadder #(.WI1(2),.WF1(6),.WI2(2),.WF2(6),.WIO(2),.WFO(6)) A0 (.RESET(1'b0),.in1(A[1]),.in2(M[2]),.out(A[0]),.OVF(OVF_Flaga[0]));
    fpadder #(.WI1(2),.WF1(6),.WI2(2),.WF2(6),.WIO(2),.WFO(6)) A1 (.RESET(1'b0),.in1(M[0]),.in2(M[1]),.out(A[1]),.OVF(OVF_Flaga[1]));
    
    always @(posedge clk) begin
        if(counter == 4'b0100) begin
             x_temp <= x;
        end
        else begin
        h_temp[2] <= h;
        h_temp[1] <= h_temp[2];
        h_temp[0] <= h_temp[1];
        counter <= counter + 1'b1;
        end
        y <= A[0];
    end
   
endmodule
