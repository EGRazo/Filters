module Register#(parameter WL = 32)
        (input CLK,
            input rst,
            input signed [WL - 1:0] in,
            output reg signed [WL - 1:0] out);
            
    initial out <= 0;
  
    always@(posedge CLK) begin
        out <= in;
    end
endmodule
