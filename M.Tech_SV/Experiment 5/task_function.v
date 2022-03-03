module add();
  int y;
  
  task sum(input int a,b, output int y);
    y = a+b;
  endtask
  
  task stat_inc;
    begin
      static int g = 0;
      g += 5;
      $display("value of static variable is %d",g);
    end
  endtask
  
  task auto_inc;
    begin
      automatic int u = 0;
      u += 5;
      $display("value of automatic variable is %d",u);
    end
  endtask
  
    
  function int add(int x, int y);
    add = x+y;
  endfunction
  
  function void time_print();
    $display("simulation time is %0d",$time);
  endfunction
  
  initial begin
    int a = $random;
    int b = $random;
    
    $display("\n\nTASK ADD");
    sum(a,b,y);
    if(y == a+b) $display("success in addition");
    else $display("failure");
    
    $display("\nSTATIC INCREMENT");
    repeat(3) stat_inc();
    
    $display("\nAUTOMATIC INCREMENT");
    repeat(3) auto_inc();
    
    $display("\nADD FUNCTION");
    y= add(a,b);
    if(y == a+b) $display("success in add function");
    else $display("failure");
    
    $display("\nTIME PRINT FUNCTION");
    time_print();
    $display("\n\n");
    
  end

  
endmodule