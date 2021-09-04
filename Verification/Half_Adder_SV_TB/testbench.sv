`include "interface.sv"
`include "test.sv"
module tb_top;
  intf ifa();
  test t1(ifa);
  half_adder h1(ifa.a,ifa.b,ifa.sum,ifa.carry);
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule