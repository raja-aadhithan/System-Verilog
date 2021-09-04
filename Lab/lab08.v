//read driver
class ram_read_bfm;
        virtual ram_if.RD_BFM rd_if; // Instantiate virtual interface instance rd_if of type ram_if with RD_BFM modport
        ram_trans data2duv;// Declare a handle for ram_trans as 'data2duv'
        mailbox #(ram_trans) gen2rd;// Declare a mailbox 'gen2rd' parameterized with ram_trans
        function new(virtual ram_if.RD_BFM rd_if, mailbox #(ram_trans) gen2rd);// In constructor Pass the following as the input arguments virtual interface
                this.rd_if = rd_if;// mailbox handle 'gen2rd' parameterized with ram_trans
                this.gen2rd = gen2rd;// Make connections
        endfunction// For example this.gen2rd=gen2rd
        virtual task drive();
                @(rd_if.rd_drv_cb);
                rd_if.rd_drv_cb.rd_address<=data2duv.rd_address;
                rd_if.rd_drv_cb.read<=data2duv.read; // Wait for two clock cycles after applying all the inputs
                repeat(2) @(rd_if.rd_drv_cb);// if read is high, atleast one clock cycle will be required to read the data
                rd_if.rd_drv_cb.read<='0;// Disable the read signal
        endtask : drive
        virtual task start();
                fork // Within fork join_none,
                        forever begin// Within forever , inside begin end
                                gen2rd.get(data2duv);// get the data from mailbox gen2rd
                                drive();// call drive task provided
                        end
                join_none
        endtask: start
endclass: ram_read_bfm

//write driver
class ram_write_bfm;
        virtual ram_if.WR_BFM wr_if; // Instantiate virtual interface instance wr_if of type ram_if with WR_BFM modport
        ram_trans data2duv;// Declare a handle for ram_trans as 'data2duv'
        mailbox #(ram_trans) gen2wr;// Declare a mailbox 'gen2wr' parameterized with ram_trans
        function new(virtual ram_if.WR_BFM wr_if, mailbox #(ram_trans) gen2wr);// In constructor Pass the following as the input arguments
                this.wr_if = wr_if;// virtual interface mailbox handle 'gen2wr' parametrized with ram_trans
                this.gen2wr = gen2wr;// Make connections
        endfunction// For example this.gen2wr=gen2wr
        virtual task drive();
                @(wr_if.wr_drv_cb);
                wr_if.wr_drv_cb.data_in<=data2duv.data;
                wr_if.wr_drv_cb.wr_address<=data2duv.wr_address;
                wr_if.wr_drv_cb.write<=data2duv.write;
                repeat(2) @(wr_if.wr_drv_cb);// Wait for two clock cycles after applying all the inputs if write is high, atleast one clock cycle will be required to write the data
                wr_if.wr_drv_cb.write<='0;//Disable the write signal
        endtask
        virtual task start();
                fork // Within fork join_none
                        forever begin
                                gen2wr.get(data2duv);
                                drive();
                        end
                join_none
        endtask
endclass

//write monitor
class ram_write_mon;
        virtual ram_if.WR_MON wrmon_if;//Instantiate virtual interface instance wrmon_if of type ram_if with WR_MON modport
        ram_trans data2rm;//Declare a handle 'data2rm' of class type ram_trans
        mailbox #(ram_trans) mon2rm;//Declare a mailbox 'mon2rm' parameterized with ram_trans
        function new(virtual ram_if.WR_MON wrmon_if, mailbox #(ram_trans) mon2rm);//In constructor Pass the following properties as the input arguments
                this.wrmon_if = wrmon_if;//pass the virtual interface and the mailbox as arguments
                this.mon2rm = mon2rm;//make the connections and allocate memory for 'data2rm'
                this.data2rm = new;
        endfunction
        task monitor();
                @(wrmon_if.wr_mon_cb)
                wait(wrmon_if.wr_mon_cb.write==1)
                @(wrmon_if.wr_mon_cb);
                begin
                        data2rm.write= wrmon_if.wr_mon_cb.write;
                        data2rm.wr_address =  wrmon_if.wr_mon_cb.wr_address;
                        data2rm.data= wrmon_if.wr_mon_cb.data_in;//call the display of the ram_trans to display the monitor data
                        data2rm.display("DATA FROM WRITE MONITOR");
                end
        endtask
        task start();
                fork//within fork-join_none
                        forever begin//In forever loop
                                monitor();//Call the monitor task Understand the provided monitor task.
                                mon2rm.put(data2rm);//Put the transaction item into the mailbox mon2rm
                        end
                join_none
        endtask: start
endclass:ram_write_mon

//read monitor
class ram_read_mon;
        virtual ram_if.RD_MON rdmon_if;//Instantiate virtual interface instance rdmon_if of type ram_if with RD_MON modport
        ram_trans data2rm, data2sb;//Declare two handles 'data2rm', 'data2sb' of class type ram_trans
        mailbox #(ram_trans) mon2sb;//Declare two mailboxes 'mon2rm' and 'mon2sb' parameterized with ram_trans
        mailbox #(ram_trans) mon2rm;
        function new(virtual ram_if.RD_MON rdmon_if,mailbox #(ram_trans) mon2sb, mailbox #(ram_trans) mon2rm); //In constructor Pass the following properties as the input arguments
                this.data2rm = new;     //pass the virtual interface and the two mailboxes as arguments
                this.mon2sb = mon2sb;//make the connections and allocate memory for 'data2rm'
                this.mon2rm = mon2rm;
                this.rdmon_if = rdmon_if;
        endfunction
        task monitor();
                @(rdmon_if.rd_mon_cb)
                wait(rdmon_if.rd_mon_cb.read==1)
                @(rdmon_if.rd_mon_cb);
                 begin
                        data2rm.read = rdmon_if.rd_mon_cb.read;
                        data2rm.rd_address =  rdmon_if.rd_mon_cb.rd_address;
                        data2rm.data_out= rdmon_if.rd_mon_cb.data_out; //call the display of the ram_trans to display the monitor data
                        data2rm.display("DATA FROM READ MONITOR");
                end
        endtask
        task start();
                fork    //within fork-join_none
                        forever begin//In forever loop
                                monitor();//Call the monitor task
                                data2sb = new data2rm;//shallow copy data2rm to data2sb
                                mon2rm.put(data2rm);//Put the transaction item into two mailboxes mon2rm and mon2sb
                                mon2sb.put(data2rm);
                        end
                join_none
        endtask: start
endclass:ram_read_mon