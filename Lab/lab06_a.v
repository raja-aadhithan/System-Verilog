module test_mailbox;

class packet;   // In class packet add the following rand fields
        rand bit [3:0] addr;    // addr (bit type , size 4)
        rand bit [3:0] data;    // data (bit type , size 4)
        function void display(input string x);  // In display function pass a string as an input argument
                $display("the input string message is %s " , x); // Display the input string message
                $display("the address is %b , data is %b ", this.addr, this.data); // Display the data and address
        endfunction : display
        function void post_randomize(); // In post_randomize method call display method
                this.display("randomized data");// and pass the string argument as "randomized data"
        endfunction : post_randomize
endclass : packet

class generator;// In class generator
        packet pkt;// Declare a handle of packet class
        mailbox #(packet) mail;// Declare the mailbox parameterized by type class packet
        function new(mailbox #(packet) mail);// In constructor Pass the mailbox parameterized by packet as an argument of the constructor
                this.mail = mail;// Assign the mailbox handle argument to the local mailbox handle of generator
        endfunction
        task start;// In task start, within fork - join_none,
                fork
                        repeat(10)begin// create 10 random packets
                                pkt = new();
                                assert(pkt.randomize()); // Randomize each packet using assert & randomize method
                                mail.put(pkt); // Put the generated random packets into the mailbox
                        end
                join_none
        endtask
endclass: generator

class driver;   // In class driver
        packet drv;// Declare a handle of packet class
        mailbox #(packet) dmail; // Declare a mailbox parameterized by type class packet
        function new(mailbox #(packet) dmail);// In constructor
                this.dmail = dmail;// Pass the mailbox parameterized by packet as an argument
        endfunction// Assign the mailbox handle argument to local mailbox handle of driver
        task start;// In task start, within fork - join_none,
        fork
                repeat(10)begin // Get the 10 generated random packets from the mailbox
                        dmail.get(drv);
                        drv.display("DATA IN DRIVER");  // Use display method in the packet class to display the received data
                end
        join_none
        endtask
endclass

class env;// In class env
        mailbox #(packet) email = new;// Create the mailbox instance parameterized by packet
        generator gen;// Declare handles of generator and driver
        driver driv;
        task build(); // In build function
                gen = new(email);// Create instance of generator and driver by passing mailbox as an input argument
                driv = new(email);
        endtask
        task start();   // In task start
                gen.start;// call start task of generator and driver
                driv.start;
        endtask
endclass
initial begin// Within initial block
        env envi = new;// Create an instance of env
        envi.build();// Call build and start task of env
        envi.start();
end
endmodule