`timescale 1ns / 1ps

module srl_filter( input CLK,
                    input signed [7:0] x,
                    input signed [7:0] h,
                    input enable,
                    output reg [7:0] y);
     reg [7 : 0] h_n[0 : 2];
     reg [7:0] x_temp;
     parameter WLX = 8;
    initial begin
        h_n[0] = 8'b11101011;
        h_n[1] = 8'b00110011;
        h_n[2] = 8'b00011010;
    end
    // Using the SRL shift register
    // Using the SRL shift register
    
    my_srl # ( .WL(WLX), .DELAY(0) ) delay1( .CLK(CLK), .in(x) );
    my_srl # ( .WL(WLX), .DELAY(0) ) delay2( .CLK(CLK), .in(delay1.out) );
    
    fpmult # ( .WI1(2), .WF1(6), .WI2(2), .WF2(6), .WIO(2), .WFO(6) ) h1( .in1(x), .in2(h_n[0]) );
    
    fpmult # ( .WI1(2), .WF1(6), .WI2(2), .WF2(6), .WIO(2), .WFO(6) ) h2( .in1(delay1.out), .in2(h_n[1]) );
    
    fpmult # ( .WI1(2), .WF1(6), .WI2(2), .WF2(6), .WIO(2), .WFO(6) ) h3( .in1(delay2.out), .in2(h_n[2]) );
    
    fpadder # ( .WI1(2), .WF1(6), .WI2(2), .WF2(6), . WIO(2), .WFO(6) ) h0_h1_adder( .in1(h1.out), .in2(h2.out) );
    
    fpadder # ( .WI1(2), .WF1(6), .WI2(2), .WF2(6), . WIO(2), .WFO(6) ) h1_h2_adder( .in1(h0_h1_adder.out), .in2(h3.out) );
    
    always @(CLK) begin
    
        y <= h1_h2_adder.out;
    end
    
    
endmodule
