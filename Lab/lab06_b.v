module test_semaphore;
class driver;   // In class driver
        task send(input string x);// write task send with input argument of string type
                sh.get(1); // Get the key using sem handle
                $display("GOT: %s", x); // Display the string which indicates the respective driver information
                sh.put(1); // Put the key using sem handle
                $display("PUT: %s", x); // Display the string which indicates the respective driver information
        endtask
endclass
driver dr[2];   // Declare an array of two drivers
semaphore sh; // Declare a handle for semaphore
initial begin// Within initial block
dr[0] = new;// Create instances of drivers
dr[1] = new;
sh = new(1); // Create the instance of semaphore handle and initialize it with 1 key
repeat(5) begin // Call send task of both drivers 5 times within fork join
        fork
                dr[0].send("driver 1"); // pass any meaning full string message to indicate the driver information
                dr[1].send("driver 2");
        join
end
end
endmodule