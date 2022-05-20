module full_adder(input [3:0] a,b, output [3:0] sum, output cy);
  assign {cy,sum} = a+b;
endmodule