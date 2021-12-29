module BasicFIR #(parameter h0 = -3, h1 = 3, h2 = 5,
                    x_vals = 21, WL = 32)
                ( input [WL - 1 : 0] xin,
                  input clk,
                  output [WL -  1 : 0] yout);
                  
 //Delay Wires                 
 wire [WL - 1 : 0] x1, x2, x3;
 
 //Multiplier Wires
 wire [WL - 1 : 0] h0xn, h1xn1, h2xn2;
 
 //Adder Wires
 wire [WL - 1 : 0] h0h1, h1h2;
                  
 Register #(.WL(32)) xn (.CLK(clk),.rst(0),.in(xin),.out(x1));     
 Register #(.WL(32)) xn1 (.CLK(clk),.rst(0),.in(x1),.out(x2)); 
 Register #(.WL(32)) xn2 (.CLK(clk),.rst(0),.in(x2),.out(x3)); 
 
 Multiplier #(.WL(32)) h0Mult (.xin1(h0),. xin2(x1),. out(h0xn));
 Multiplier #(.WL(32)) h1Mult (.xin1(h1),. xin2(x2),. out(h1xn1));
 Multiplier #(.WL(32)) h2Mult (.xin1(h2),. xin2(x3),. out(h2xn2));
 
 Adder #(.WL(32)) h0h1Adder (.xin1(h0xn),. xin2(h1xn1),. out(h0h1));
 Adder #(.WL(32)) h1h2Adder (.xin1(h0h1),. xin2(h2xn2),. out(yout));
                        
endmodule
