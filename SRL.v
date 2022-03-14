`timescale 1ns / 1ps

module my_srl # (parameter WL = 8, DELAY = 0)
(
    input CLK,
    input [WL - 1 : 0] in,
    output [WL - 1 : 0] out
);
    reg [3 : 0] my_delay = DELAY;
    
    genvar i;
    generate
        for( i = 0; i <= WL; i = i + 1 )
        begin
            SRL16E # (.INIT(16'h0000))  // Initial Value of Shift Register
             srl_M (
            .Q( out[(WL - 1) - i] ),    // SRL data output
            .A0(my_delay[0]),           // Select[0] input
            .A1(my_delay[1]),           // Select[1] input
            .A2(my_delay[2]),           // Select[2] input
            .A3(my_delay[3]),           // Select[3] input
            .CE(1),                     // Clock enable input
            .CLK(CLK),                  // Clock input
            .D(in[(WL - 1) - i])        // SRL data input
            );
        end
    endgenerate
    
    
endmodule