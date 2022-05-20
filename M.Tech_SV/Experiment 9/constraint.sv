//constraint_1

class packet;
  rand bit [3:0] addr;
  
  constraint addr_range { addr > 5; }
endclass

module const_blocks;
  initial begin
    packet pkt;
    pkt = new();
    repeat(10) begin
      pkt.randomize();
      $display("\taddr = %0d",pkt.addr);
    end
  end
endmodule

//constraint_2

class packet;
  rand bit [3:0] addr;
  constraint addr_range;
endclass

constraint packet :: addr_range { addr > 5; }

module const_blocks;
  initial begin
    packet pkt;
    pkt = new();
    repeat(10) begin
      pkt.randomize();
      $display("\taddr = %0d",pkt.addr);
    end
  end
endmodule

//constraint_3

class packet;
  rand bit [3:0] addr;
  rand bit [3:0] start;
  rand bit [3:0] stop;
  constraint addr_range;
endclass

constraint packet :: addr_range { addr inside {[start:stop]}; }

module const_blocks;
  initial begin
    packet pkt;
    pkt = new();
    repeat(10) begin
      pkt.randomize();
      $display("start is %0d, stop is %0d",pkt.start, pkt.stop);
      $display("\taddr = %0d",pkt.addr);
    end
  end
endmodule

//constraint_4

class packet;
  rand bit [3:0] addr;
  rand bit [3:0] start;
  rand bit [3:0] stop;
  constraint addr_range;
endclass

constraint packet :: addr_range {! (addr inside {[start:stop]});
                                	start < stop;}

module const_blocks;
  initial begin
    packet pkt;
    pkt = new();
    repeat(10) begin
      pkt.randomize();
      $display("start is %0d, stop is %0d",pkt.start, pkt.stop);
      $display("\taddr = %0d",pkt.addr);
    end
  end
endmodule
