module randomgen;
class sbit;
        static bit [7:0] data_in;
        static bit [7:0] x ;
        rand int a[5];
        constraint da{unique{a}; foreach (a[i]) a[i] inside {[0:7]};}
        task ran();
                x = data_in;
                foreach (a[i]) x[a[i]] = !data_in[a[i]];
                $display("x %b, data_in = %b, a %p",x,data_in, a);
                data_in = x;
        endtask
endclass
initial begin
        sbit a_b = new;
        repeat (10) begin
                assert(a_b.randomize());
                 a_b.ran();
        end
end
endmodule