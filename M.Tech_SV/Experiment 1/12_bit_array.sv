module array_methods();
  bit [11:0] my_array[4];
  
  initial begin
  	my_array = '{12'h12,12'h345,12'h678,12'h9AB};
    
    $display("\nUsing for loop");
    for(int i=0; i<$size(my_array); i++) 
      $displayh("my_array(%0d)=",i,my_array[i]);
    
    $display("\nUsing foreach loop");
    foreach(my_array[i]) 
      $displayh("my_array(%0d)=",i,my_array[i]);
    
    $display("\n\nvalues of bits [5:4]");
    $display("\nUsing for loop");
    for(int i=0; i<$size(my_array); i++) 
      $display("my_array(%0d)=%b",i,my_array[i][5:4]);
    
    $display("\nUsing foreach loop");
    foreach(my_array[i]) 
      $display("my_array(%0d)=%b",i,my_array[i][5:4]);
    
    $display("\n\nAdding 4 to each value");
    $display("\nUsing for loop");
    for(int i=0; i<$size(my_array); i++) begin
      my_array[i] += 4;
      $displayh("my_array(%0d)=",i,my_array[i]);
    end
    
    my_array = '{12'h12,12'h345,12'h678,12'h9AB};
    $display("\nUsing foreach loop");
    foreach(my_array[i]) begin
      my_array[i] += 4; //my_array[i] = my_array[i] + 4
      $displayh("my_array(%0d)=",i,my_array[i]);
    end
  end
endmodule