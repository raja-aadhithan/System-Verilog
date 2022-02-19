module add(input [3:0] a,b, input cin, output [3:0] sum, output cout);
  assign {cout,sum} = a+b+cin;
endmodule


module tb();
  reg [3:0] a,b;
  wire [3:0] sum; 
  reg cin;
  wire cout;
  int x=0;
  
  add duv(a,b,cin,sum,cout);
  
  initial begin
    repeat(10) begin
    	{a,b,cin} = $random;
    	#1;
      if({cout,sum} != a+b+cin) x = x+1;
      $display("ip is %d,%d, %b op is %d",a,b,cin,{cout,sum});
    end
    if(!x) $display("Success");
    else $display("Failure");
  end
endmodule