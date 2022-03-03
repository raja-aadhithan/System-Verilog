module auto_variable_task;
  
  task auto_delay(input time delay);
    logic static_var = 1'b0;
    automatic logic auto_var = 1'b0;
    
    $display("@time : %0d - static variable is %b, auto variable is %b",$time,static_var,auto_var);
    #delay;
    static_var = !static_var;
    auto_var = !auto_var;
    $display("@time : %0d - static variable is %b, auto variable is %b",$time,static_var,auto_var);
  endtask : auto_delay
  
  initial repeat(3) auto_delay(10ns);
endmodule