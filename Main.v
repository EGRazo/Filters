module fir_gen
    #(parameter W1 = 8, // Input bit width
                W2 = 16, // Multiplier bit width 2*W1
                W3 = 17, // Adder width = W2+log2(L)-1
                W4 = 8, // Output bit width
                L = 3) // Filter length
            (input clk, // System clock
             input reset, // Asynchronous reset
             input Load_x, // Load/run switch
             input signed [W1-1:0] x_in, // System input
             input signed [W1-1:0] c_in, //Coefficient data input
             output signed [W4-1:0] y_out); // System output
// --------------------------------------------------------
reg signed [W1-1:0] x;
wire signed [W3-1:0] y;

reg signed [W1-1:0] c [0:2]; // Coefficient array
wire signed [W2-1:0] p [0:2]; // Product array
reg signed [W3-1:0] a [0:2]; // Adder array
//----> Load Data or Coefficient
always @(posedge clk or posedge reset) begin: Load
        integer k; // loop variable
        if (reset) begin // Asynchronous clear
            for (k=0; k<=L-1; k=k+1) c[k] <= 0;
            x <= 0;
        end else if (!Load_x) begin
            c[2] <= c_in; // Store coefficient in register
            c[1] <= c[2]; // Coefficients shift one
            c[0] <= c[1];
        end else
            x <= x_in; // Get one data sample at a time
        end
//----> Compute sum-of-products
always @(posedge clk or posedge reset)begin: SOP
// Compute the transposed filter additions
    integer k; // loop variable
    if (reset) // Asynchronous clear
        for (k=0; k<=2; k=k+1) a[k] <= 0;
    else begin
        a[0] <= p[0] + a[1];
        a[1] <= p[1] + a[2];
        a[2] <= p[2];
    end
end
     assign y = a[0];
     genvar I; //Define loop variable for generate statement
generate
        for (I=0; I<L; I=I+1) begin : MulGen
        // Instantiate L multipliers
        assign p[I] = x * c[I];
    end
endgenerate
        assign y_out = y[W3-1:W3-W4];
endmodule