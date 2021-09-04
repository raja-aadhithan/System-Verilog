module test_obj_assignment;
class packet;   // Declare class packet
// Within the class packet declare the below class properties
        bit[3:0] data; // data (bit type, size 4)
        bit[15:0] addr; // addr (bit type, size 16)
        bit[15:0] mem; // mem  (bit type, size 16)
endclass: packet

packet pkt_h1, pkt_h2;  // Declare two handles for the packet class "pkt_h1" and "pkt_h2"

initial begin// Within initial block
        pkt_h1 = new; // Construct pkt_h1 object
        pkt_h1.addr = {$random}%30; // Assign random values to the addr,
        pkt_h1.data = {$random}%1024; //data and mem of pkt_h1 object
        pkt_h1.mem = {$random}%1024;
        $display("pkt_h1 is %p",pkt_h1); // Display the object pkt_h1
        pkt_h2 = pkt_h1; // Assign pkt_h1 to pkt_h2
        $display("\nAfter assigning one object to the other,");
        $display("pkt_h1 is %p",pkt_h1); // Display the object pkt_h1
        $display("pkt_h2 is %p",pkt_h2); // Display the object pkt_h2
// Make changes to address and data using handle pkt_h2
        pkt_h2.addr = {$random}%30; // Assign random values to the addr,
        pkt_h2.data = {$random}%1024; //data and mem of pkt_h1 object
        $display("After changing the values of properties with one handle,");
        $display("pkt_h1 is %p",pkt_h1); // Display the object pkt_h1
        $display("pkt_h2 is %p",pkt_h2); // Display the object pkt_h2
// observe that both will display the same contents because the handles point to the same object
end
endmodule