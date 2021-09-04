module test_class_defn;
class account_c;        // Declare class account_c
        int balance;    // Within class account_c Declare variable balance as int type
// Write a function summary that returns balance from it
        function int summary;
                return balance;
        endfunction
// Write a task deposit with pay (type int) as the input argument and add pay with the balance
        task deposit(input int pay);
                balance += pay;
        endtask
endclass

account_c aadhi;        // Declare a handle for class account_c

// Within initial block Create an instance of the class account_c
initial begin
        aadhi = new;
// Call method deposit and pass pay value as the input and call method summary to display balance
        aadhi.deposit(500);
        $display("The balance is %d",aadhi.summary());
        $display("The balance is %d",aadhi.balance);
end
endmodule