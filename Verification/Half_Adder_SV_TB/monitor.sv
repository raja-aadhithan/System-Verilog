class monitor;
  virtual intf vif;
  mailbox mon2sb;
  function new(virtual intf vif,mailbox mon2sb);
    this.vif = vif;
    this.mon2sb = mon2sb;
  endfunction
  
  task main();
    #3;
    begin
      transaction trans;
      trans = new();
      trans.a = vif.a;
      trans.b = vif.b;
      trans.sum = vif.sum;
      trans.carry = vif.carry;
      mon2sb.put(trans);
      trans.display("Monitor");
    end
  endtask
endclass