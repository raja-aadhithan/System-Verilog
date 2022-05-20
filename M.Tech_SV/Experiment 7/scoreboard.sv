class scoreboard;

  mailbox mon2scb;
  transaction trans;
  
  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction
  
  task main();
    mon2scb.get(trans);
   
    if({trans.cy,trans.sum} == trans.a+trans.b)
      $display("Success");
    else 
      $error("Wrong Result");
    trans.display("Scoreboard");
  endtask
  
endclass