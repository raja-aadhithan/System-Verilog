module test_array();
  2
  3 int data_da[];  // Declare a dynamic array data_da of int data type
  4 int data_q[$], addr_q[$];       // Declare queues data_q & addr_q of int data type
  5 int data_mem [bit[7:0]];        // Declare associative array data_mem of int data type and indexed with bit[7:0]
  6 int result,idx; // Declare int variables result,idx
  7
  8 initial begin
  9 // Allocate 10 memory locations for dynamic array & initialize all the locations with some random values less than 20 &     display the array
 10         data_da =new[10];
 11         foreach(data_da[i]) data_da[i] = {$urandom}%20;
 12         $display("array is %p",data_da);
 13
 14 // Call the array reduction method sum which returns the sum of all elements of array and collect the return value to t    he variable result
 15         result = data_da.sum();
 16         $display("sum of array is %0d",result); // Display the sum of elements, result
 17
 18 // Similarly explore other array reduction methods product,or,and & xor
 19         result = data_da.product();
 20         $display("product of array is %0d",result);     // Display the product of elements, result
 21
 22         result = data_da.or();
 23         $display("or of array is %0d",result);  // Display the or of elements, result
 24
 25         result = data_da.xor();
 26         $display("sum of array is %0d",result); // Display the xor of elements, result
 27
 28 // Call the array reduction method sum with "with" clause which returns total number of elements satisfying the conditi    on within the "with" clause
 29
 30         result = data_da.sum with (int'(item>7)); // Display the value of the result
 31         $display(" no. of items greater than 7 = %0d", result);
 32
 33 // Similarly explore other array reduction methods with "with"clause
 34         result = data_da.sum with ((item>5)*item);
 35         $display(" sum of items greater than 5 = %0d", result);
 36 // Sorting Methods
 37
 38// call all the sorting methods like reverse, sort, rsort &  shuffle & display the array after execution of each method     to  understand the behaviour of the array methods
 39         $display("original array: %p",data_da);
 40         data_da.sort();
 41         $display("da.sort: %p",data_da);
 42         data_da.rsort();
 43         $display("da.rsort: %p",data_da);
 44         data_da.shuffle();
 45         $display("da.shuffle: %p",data_da);
 46         data_da.reverse();
 47         $display("da.reverse: %p",data_da);
 48
 49 // Call Array locator methods like min, max, unique,find_* with, find_*_index with using dynamic array & display the co    ntents of data_q after execution of each method to understand the behaviour of the array methods
 50         data_q = data_da.min();
 51         $display("min: %p",data_q);
 52         data_q = data_da.max();
 53         $display("max: %p",data_q);
 54         data_q = data_da.unique();
 55         $display("unique: %p",data_q);
 56         data_q = data_da.find_first with(item>10);
 57         $display("find first: %p",data_q);
 58         data_q = data_da.find_last with (item<10);
 59         $display("find last: %p",data_q);
 60         data_q = data_da.find_first_index with(item>10);
 61         $display("find first index : %p",data_q);
 62         data_q = data_da.find_last_index with (item<10);
 63         $display("find last index: %p",data_q);
 64         data_q = data_da.find with(item>10);
 65         $display("elements > 10: %p",data_q);
 66
 67 //Generate some 10 random address less than 100 within a repeat loop push the address in to the addr_q
 68         repeat(10) begin
 69         addr_q.push_back(($urandom)%100);
 70         $display("addr_q is %p",addr_q);//Display the addr_q
 71         end
 72
 73 // With in for loop update the associate array with random data less than 200 based on the address stored in addr_q
 74 // Hint: To get the address use pop method
 75         for(int i = 0; i<10 ; i++) begin
 76                 data_mem[addr_q.pop_front] = {$urandom}%200;
 77         end
 78
 79 // Display the contents of associate array using foreach loop
 80         foreach (data_mem[i]) $display("datamem[%0d] = %0d", i,data_mem[i]);
 81
 82 // Display the first index of the array by using associative array method first and the first element of the array
 83         if(data_mem.first(idx)) begin
 84         $display("first index is %0d, first element is %0d",idx, data_mem[idx]);
 85         end
 86 // Display the last index of the array by using associative array method last and the last element of the array
 87         if(data_mem.last(idx)) begin
 88         $display("last index is %0d, last element is %0d",idx, data_mem[idx]);
 89         end
 90 end
 91 endmodule