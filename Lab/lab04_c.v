module test_polymorphism;
class packet_c; // In class packet_c
        virtual task send;// In task send
                $display("Sending base class packet, class : %s", $typename(this));     // Display message "Sending base class packet"
        endtask
endclass
class badpacket extends packet_c;// Extend badpacket_c from packet_c
        task send;// Override task send
                $display("Sending derived class packet, class : %s", $typename(this));// Display message "Sending derived class packet"
        endtask
endclass
initial begin// Within initial
        badpacket bp = new;     // Create instances for badpacket_c and packet_c
        packet_c pc = new;
        $display("\n\n from child");
        bp.send();      // Call send tasks using base and extended class handles
        $display("\n\n from parent");
        pc.send();
        $display("\n\n from parent");
        pc = bp;        // Assign extended class handle to base class handle
        pc.send();// Call send task using base class object
end
endmodule