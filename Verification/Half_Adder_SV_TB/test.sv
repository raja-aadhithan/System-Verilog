`include "environment.sv"
program test(intf ifc);
	environment ev;
    initial begin
      ev = new(ifc);
      ev.run();
    end
endprogram