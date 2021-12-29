module Adder #(parameter WL = 32)
    (
        input  signed [WL - 1 : 0] xin1,
        input  signed [WL - 1 : 0] xin2,
        output reg signed [WL - 1 : 0] out);
        
    initial begin
        out <= 0;
    end

    always @(xin1, xin2) begin
        out <= xin1 + xin2;
    end

endmodule
