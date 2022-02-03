module array_2dim();
  bit [11:0] array_2d[4][3]; //12 bit array of 4 rows and 3 columns
  
  initial begin
    array_2d = '{'{0,1,2},'{3,4,5},'{6,7,8},'{19,20,21}}; //seperate literal for each row
    
    foreach(array_2d[i]) 
      $display("Row %0d of array is ",i,array_2d[i][0],array_2d[i][1],array_2d[i][2]);
  end
endmodule
  