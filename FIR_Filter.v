`timescale 1ns / 1ps
// Three Tap FIR Filter
// y[n] = h[0]x[n] + h[1]x[n-1] + h[2]x[n-2]
// x = [ 1/5 , -2/5 , 3/5 , -4/5]
// h = [-1/3 , 4/5 , 2/5]
// (2.6) x and h
module FIR_Filter #(WL = 8)
                 (  input clk,
                    input signed [WL - 1 : 0] x,
                    input signed [WL - 1 : 0] h,
                    input x_en,
                    output [WL - 1 : 0] y);
    
      //wire [-1 : 6] x_temp [ 0 : 3];
    reg [-1 : 6] h_temp [0 : 2];
    reg [-1 : 6] y_out;
    wire [-1 : 6] y_temp[ 0 : 2];
    wire [7 : 0] a_temp[0:2];
    wire [7 : 0] p_temp[0:2];
    wire [7:0] d_temp[0:1];
    wire [3:0] n;
    reg [7:0] x_temp;
    reg reset;
    reg out;
    //y_temp = product array
    //x_temp = data in
    //h_temp = coefficients in
    //a_temp = adder array
    /*
    
        The above is taken from the Uwe Mayer Base textbook fir_gen.v description of a 4 tap FIR Filter
        Difference in this implementation is this filter is a 3 tap filter
        This filter also uses a fpmultiplier and fpadder instead of floating point
    
    */
   
    initial begin
       
        
        h_temp[0] <= 8'b0;
        h_temp[1] <= 8'b0;
        h_temp[2] <= 8'b0;
      
     end
   /*
     DFF #(.WL(8)) xen(.data(h_en),.clk(clk),.en(x_en),.q(h_en));
     DFF #(.WL(8)) hen(.data(x_en),.clk(clk),.en(x_en),.q(x_en));
    */
    /*
     DFF #(.WL(8)) x0(.data(x),.clk(clk),.en(1),.q(x_temp[0]));
     DFF #(.WL(8)) x1(.data(x_temp[0]),.clk(clk),.en(1),.q(x_temp[1]));
     DFF #(.WL(8)) x2(.data(x_temp[1]),.clk(clk),.en(1),.q(x_temp[2]));
     DFF #(.WL(8)) x3(.data(x_temp[2]),.clk(clk),.en(1),.q(x_temp[3]));
     */
     
     
     DFF #(.WL(8)) h1(.data(p_temp[2]),.q(d_temp[0]));
     DFF #(.WL(8)) h2(.data(a_temp[1]),.q(d_temp[1]));
     
   
    
     fpmult #(.WI1(2),.WF1(6),.WI2(2),.WF2(6),.WIO(2),.WFO(6)) y0 (.RESET(reset),.in1(x_temp),.in2(h_temp[0]),.out(p_temp[0]),.OVF(n[0]));
     fpmult #(.WI1(2),.WF1(6),.WI2(2),.WF2(6),.WIO(2),.WFO(6)) y1 (.RESET(reset),.in1(x_temp),.in2(h_temp[1]),.out(p_temp[1]),.OVF(n[1]));
     fpmult #(.WI1(2),.WF1(6),.WI2(2),.WF2(6),.WIO(2),.WFO(6)) y2 (.RESET(reset),.in1(x_temp),.in2(h_temp[2]),.out(p_temp[2]),.OVF(n[2]));
     //fpmult #(.WI1(2),.WF1(6),.WI2(2),.WF2(6),.WIO(2),.WFO(6)) y3 (.clk(clk),.RESET(reset),.in1(x),.in2(h_temp[2]),.out(p_temp[3]),.OVF(n[2]));
     
     fpadder #(.WI1(2),.WF1(6),.WI2(2),.WF2(6),.WIO(2),.WFO(6)) addery0 (.RESET(reset),.in1(p_temp[0]),.in2(d_temp[1]),.out(a_temp[0]),.OVF(n[0]));
     fpadder #(.WI1(2),.WF1(6),.WI2(2),.WF2(6),.WIO(2),.WFO(6)) addery1 (.RESET(reset),.in1(p_temp[1]),.in2(a_temp[2]),.out(a_temp[1]),.OVF(n[1]));
     fpadder #(.WI1(2),.WF1(6),.WI2(2),.WF2(6),.WIO(2),.WFO(6)) addery2 (.RESET(reset),.in1(d_temp[0]),.in2(8'b0),.out(a_temp[2]),.OVF(n[2]));
     //fpadder #(.WI1(2),.WF1(6),.WI2(2),.WF2(6),.WIO(2),.WFO(6)) addery3 (.RESET(reset),.in1(p_temp[2]),.in2(8'b0),.out(a_temp[3]),.OVF(n[2]));
    always @(posedge clk) begin
   
        if(x_en) begin
        h_temp[0] <= h;
        h_temp[1] <= h_temp[0];
        h_temp[2] <= h_temp[1];
        end
        else begin
           x_temp <= x;
        end
        
        
    end
    
    assign y = a_temp[2];
    
endmodule
