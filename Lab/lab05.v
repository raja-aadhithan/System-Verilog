module test_random;
class alu_trans_c;      // In class alu_trans_c
        typedef enum{ARITH, LOGIC, SHIFT} OPERATION ;// Declare a typedef variable OPERATION of type enum with LOGIC, ARITH and SHIFT as the values
        rand logic [3:0] alu_sel_in;    // Add the following rand fields alu_sel_in ( logic type, size 4)
        rand OPERATION rand_oper;       // rand_oper ( OPERATION type)
        constraint SEL {        // Apply following constraints
                        rand_oper == LOGIC -> alu_sel_in inside {[0:5]};        // If rand_oper = LOGIC then alu_sel_in should be inside [0:5]
                        rand_oper == ARITH -> alu_sel_in inside {[6:9]};        // If rand_oper = ARITH, then alu_sel_in should be inside [6:9]
                        rand_oper == SHIFT -> alu_sel_in inside {[10:15]};}     // If rand_oper = SHIFT, then alu_sel_in should be inside [10:15]
        constraint SEL2 { rand_oper dist{LOGIC:=1, SHIFT:=1, ARITH:= 2};}               // Give weightage of 2 to ARITH operation
        function void post_randomize();// In post_randomize method ,display all the randomized values
                $display("the values are rand_oper is %s, alu_sel_in is %d", rand_oper.name, alu_sel_in);
        endfunction
endclass
initial begin   // Within initial
        alu_trans_c aadhi = new;                // Create an instance of alu_trans_c
        repeat(10) assert(aadhi.randomize());   // Generate 10 set of random values for the instance alu_trans_c
end     // Randomize using 'assert' or 'if' construct
endmodule