module arrays();
  bit [7:0] array_1[10], array_2[10]; 
  int x;
  
  initial begin
    array_1 = '{2,4,6,8,10,12,14,16,18,20};
	  array_2 = '{1,3,5,7,9,11,13,15,17,29};
    
    $display("array_1 is ",array_1);
    $display("array_1 is ",array_2);
  
  	array_2 = array_1;
  	foreach(array_1[i]) if(array_1[i] != array_2[i]) x = x+1;
  
    if(x) $display("Values dont match");
  	else $display("Values match");
  end
endmodule