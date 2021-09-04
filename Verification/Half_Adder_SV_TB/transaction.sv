class transaction;
  rand bit a,b;
  bit sum, carry;
  function void display(string name);
    $display("%s,input ab = %b%b, output %b%b ", name,a,b,sum,carry);
  endfunction
endclass