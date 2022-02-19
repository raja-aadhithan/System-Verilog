module dff(input d,clk, output reg q);
  always@(posedge clk) q<=d;
endmodule 

module tb();
  bit d,clk,q,y;
  dff duv(d,clk,q);
  int x = 0;
  
  initial forever #5 clk = !clk;
  
  initial begin
    repeat(10)begin  
      @(negedge clk) begin
        d <= $random;
        y <= d;
      end
       
      @(posedge clk) if(q != y) x = x+1;
      $display("%0d ip is %d op is %d",$time,d,q);
    end
    if(!x) $display("Success");
    else $display("Failure");
  end           
endmodule