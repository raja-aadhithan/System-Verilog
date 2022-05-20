class transaction;
  rand bit [3:0] a;
  rand bit [3:0] b;
  
  bit [3:0] sum;
  bit cy;
  
  function void display(string name);
    $display("@ %s component: inputs are %0d,%0d, and outputs: {cy,sum}=%0d",name,a,b,{cy,sum});
  endfunction
endclass