interface ram_if(input bit clock);

// Declare the interface signals:
        // data_in, data_out(logic type , size 64)
        //read, write (logic type, size 1)
        // rd_address, wr_address (logic type, size 12)
logic [63:0] data_in, data_out;
logic [11:0] rd_address, wr_address;
logic write,read;

// Add clocking block wr_drv_cb for write driver that is triggered at posedge of clock
        // define the input skew as #1 & output skew as #1
        // Define the direction of the signals as:
                // output: data_in, wr_address, write
clocking wr_drv_cb@(posedge clock);
default input #1 output #1;
output data_in, wr_address, write;
endclocking

// Add clocking block rd_drv_cb for read driver that is triggered at posedge of clock
        // define the input skew as #1 & output skew as #1
        // Define the direction of the signals as:
                // output:  rd_address, read
clocking rd_drv_cb@(posedge clock);
default input #1 output #1;
output rd_address, read;
endclocking

// Add monitor clocking block wr_mon_cb for write monitor that is triggered at the posedge of clock
        // define the input skew as #1 & output skew as #1
        // Define the direction of the signals as:
                // input: data_in, wr_address, write
clocking wr_mon_cb@(posedge clock);
default input #1 output #1;
input data_in, wr_address, write;
endclocking

// Add monitor clocking block rd_mon_cb for read monitor that is triggered at the posedge of clock
        // define the input skew as #1 & output skew as #1
        // Define the direction of the signals as:
                // input: rd_address,read, data_out
clocking rd_mon_cb@(posedge clock);
default input #1 output #1;
input rd_address, read, data_out;
endclocking

// Add write driver modport WR_BFM with driver clocking block(wr_drv_cb) as the input argument
modport WR_BFM (clocking wr_drv_cb);

// Add read driver modport RD_BFM with driver clocking block(rd_drv_cb) as the input argument
modport RD_BFM (clocking rd_drv_cb);

// Add write monitor modport WR_MON with monitor clocking block (wr_mon_cb) as the input argument
modport WR_MON (clocking wr_mon_cb);

// Add read monitor modport RD_MON with monitor clocking block(rd_mon_cb) as the input argument
modport RD_MON (clocking rd_mon_cb);

endinterface: ram_if