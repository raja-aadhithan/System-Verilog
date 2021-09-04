module test_deep_copy;

// In class parity_calc_c
        class parity_calc_c;
                bit [7:0] parity = $random%20;  // Declare parity (bit type, size 8), initialize it with some random value
                function parity_calc_c copy();  // Write copy method that returns parity_calc_c class type
                        copy = new;             // Create copy instance
                        copy.parity = this.parity;// Copy all the current properties into copy object
                endfunction : copy
        endclass: parity_calc_c

// In class packet_c
        class packet_c;
                bit [7:0] header = $random%20;// Declare header (bit type , size 8), initialize it with some random value
                bit [7:0] data = $random%256;// Declare data (bit type , size 8), initialize it with some random value
                parity_calc_c ph=new;// Declare and create an instance of parity_calc_c
                function packet_c copy();// Define copy method that returns packet_c class type
                        copy = new;// Create copy instance
                        copy.header = this.header;// Copy all the current class properties into copy object
                        copy.data = this.data;
                        copy.ph = this.ph.copy();
                endfunction
        endclass: packet_c

        packet_c pkt_h1, pkt_h2;// Declare 2 handles pkt_h1 & pkt_h2 for packet_c class

initial begin// Within initial
        pkt_h1 = new;   // Create pkt_h1 object
        pkt_h2 = new pkt_h1;// Use shallow copy method to copy pkt_h1 to pkt_h2
        // Display the properties of parent class and sub class properties of pkt_h1 and pkt_h2
        $display("\n\n\n\n\n\n shallow copy");
        $display("pkt1 after shallow copy : header = %d, data = %d, parity = %d",pkt_h1.header,pkt_h1.data,pkt_h1.ph.parity);
        $display("pkt2 after shallow copy : header = %d, data = %d, parity = %d",pkt_h2.header,pkt_h2.data,pkt_h2.ph.parity);
        pkt_h2.header = 20;     // Assign random value to the header of pkt_h2
        // Display the properties of parent class and sub-class properties of pkt_h1 and pkt_h2
        $display("\n after pkt_h2 header change");
        $display("pkt1 after shallow copy : header = %d, data = %d, parity = %d",pkt_h1.header,pkt_h1.data,pkt_h1.ph.parity);
        $display("pkt2 after shallow copy : header = %d, data = %d, parity = %d",pkt_h2.header,pkt_h2.data,pkt_h2.ph.parity);
        // observe pkt_h1.header does not change
        // Change parity of pkt_h2 using subclass handle from the parent class packet_c
// Ex: pkt_h2.par.parity=19;
        pkt_h2.ph.parity = 50;
        $display("\n after pkt_h2 parity change");
        $display("pkt1 after shallow copy : header = %d, data = %d, parity = %d",pkt_h1.header,pkt_h1.data,pkt_h1.ph.parity);
        $display("pkt2 after shallow copy : header = %d, data = %d, parity = %d",pkt_h2.header,pkt_h2.data,pkt_h2.ph.parity);
        // Display the properties of parent class and sub-class properties of pkt_h1 and pkt_h2
        // observe that change reflected in pkt_h1 as the subclass handle in pkt_h1 and pkt_h2 are pointing to same subclass object
        // Perform deep copy by calling parent class copy method
        // Ex: pkt_h2=pkt_h1.copy;
        pkt_h2 = pkt_h1.copy;
        // Display the properties of parent class and sub-class properties of pkt_h1 and pkt_h2
        // observe the parent and subclass properties
        $display("\n\n\ deep copy");
        $display("pkt1 after deep copy : header = %d, data = %d, parity = %d",pkt_h1.header,pkt_h1.data,pkt_h1.ph.parity);
        $display("pkt2 after deep copy : header = %d, data = %d, parity = %d",pkt_h2.header,pkt_h2.data,pkt_h2.ph.parity);
        // Change parity of pkt_h2 Ex: pkt_h2.par.parity=210;
        // Display the properties of parent class and sub-class properties of pkt_h1 and pkt_h2
        pkt_h2.ph.parity = 107;
        $display("\n after pkt_h2 parity change");
        $display("pkt1 after deep copy : header = %d, data = %d, parity = %d",pkt_h1.header,pkt_h1.data,pkt_h1.ph.parity);
        $display("pkt2 after deep copy : header = %d, data = %d, parity = %d",pkt_h2.header,pkt_h2.data,pkt_h2.ph.parity);
        // observe that parity doesnot change for pkt_h1 as they are two different subclass objects
end
endmodule