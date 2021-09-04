class scoreboard;
  mailbox mon2sb;
  function new(mailbox mon2sb);
    this.mon2sb = mon2sb;
  endfunction;
  
  task main();
    transaction trans;
    begin
      mon2sb.get(trans);
      if(( trans.a^trans.b == trans.sum )&&(trans.a & trans.b == trans.carry))
        $display("Expected Result");
      else $display("Error in Result");
      trans.display("Scoreboard");
    end
  endtask
endclass