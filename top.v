`timescale 1ns / 1ps

module top();

Filter #(.WL(8)) FIR (.clk(),.x(),.h(),.reset(),.enable(),.y());
srl_filter  SRL (.CLK(),.x(),.h(),.enable(),.y());
endmodule
