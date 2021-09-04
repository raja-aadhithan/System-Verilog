module test_inheritance;
        class account_base;// In class account_base;
        int balance = 2000;             // Declare property balance int type and initialize with value 2000
        function int summary_base();    // In the function summary_base ,return balance
                return balance;
        endfunction
        task deposit(input int pay);// In the task deposit, // Pass an input argument 'pay' of int type
                balance += pay;// Add pay with previous balance
        endtask
        endclass: account_base

        class account_extd extends account_base; // Extend class account_extd from account_base;
        int balance = 3000;     // Declare property balance of int type and initialize with value 3000
        function int summary_extd();// In function summary_extd, return balance from extended class
                balance += super.balance;// the new value returned should be summation of base class balance and extended class balance
                return balance;// Hint: use super to access the base class balance
        endfunction
        endclass: account_extd

        account_extd acc_h;// Declare a handle for account_extd class as acc_h
initial begin// Within initial block,
        acc_h = new;            // Create an object for acc_h
        acc_h.deposit(500);     // Pass the amount for the method deposit and
        $display("\n the account balance in base class is %0d", acc_h.summary_base());  // Call the method summary_base to display the base class balance
        $display("\n the account balance in extended class is %0d",acc_h.summary_extd());// Call method summary_extd to display balance
        // Observe that the super.balance returns the base class balance
end
endmodule : test_inheritance