module full_adder(input [3:0] a,b,input clk,reset, output reg [6:0]sum);
  always@(posedge clk)begin
    if(reset) sum = 0;
    else sum = a+b;
  end
endmodule