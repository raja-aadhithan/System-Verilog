`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  generator gen;
  monitor mon;
  driver dr;
  scoreboard sb;
  mailbox m1;
  mailbox m2;
  
  virtual intf vif;
  function new(virtual intf vif);
    this.vif = vif;
    m1 = new();
    m2 = new();
    gen = new(m1);
    dr = new(vif,m1);
    mon = new(vif,m2);
    sb = new(m2);
  endfunction
  
  task test();
    fork 
      gen.main();
      mon.main();
      dr.main();
      sb.main();
    join
  endtask
  
  task run();
    test();
    $finish;
  endtask
  
endclass