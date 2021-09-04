import ram_pkg::*;

class ram_trans_extnd1 extends ram_trans;

                constraint VALID_DATA {data inside {[1:10000]};}
        constraint valid_random_wr {write ==1; wr_address inside {[0:1170]};}
        constraint valid_random_rd {rd_address inside {[0:1170]};}
endclass

class ram_trans_extnd2 extends ram_trans;

                constraint VALID_DATA {data inside {[1:10000]};}
                constraint valid_random_wr {write ==1; wr_address inside {[4090:4095]};}
        constraint valid_random_rd {rd_address inside {[4090:4095]};}
endclass
class test;


    //Instantiate virtual interface with Write BFM modport,
        //Read BFM modport,Write monitor modport,Read monitor modport
    virtual ram_if.RD_BFM rd_if;
    virtual ram_if.WR_BFM wr_if;
    virtual ram_if.RD_MON rdmon_if;
    virtual ram_if.WR_MON wrmon_if;

    // Declare an handle for ram_env as env
    ram_env env;

    // Declare a handle for ram_trans_extnd1
    ram_trans_extnd1 data_h1;
    // Declare an handle for ram_trans_child2
    ram_trans_extnd2 data_h2;


        // In constructor
        // Pass the BFM and monitor interface as the arguments
        // Create the object for env and pass the arguments
        // for the virtual interfaces in new() function
        function new( virtual ram_if.WR_BFM wr_if,
                                virtual ram_if.RD_BFM rd_if,
                                virtual ram_if.WR_MON wrmon_if,
                                virtual ram_if.RD_MON rdmon_if);
        this.wr_if = wr_if;
                this.rd_if = rd_if;
                this.wrmon_if = wrmon_if;
                this.rdmon_if = rdmon_if;
        env = new(wr_if,rd_if,wrmon_if,rdmon_if);
        endfunction



        //Task which builds the TB environment and runs the simulation
        // for different tests
        task build_and_run();
begin
                if($test$plusargs("TEST1"))
                        begin
                                number_of_transactions = 500;
                                env.build();
                                env.run();
                                $finish;
                        end

                if($test$plusargs("TEST2"))
                        begin
                                data_h1=new;
                                number_of_transactions = 500;
                                env.build();
                                env.gen.gen_trans= data_h1;
                                env.run();
                                $finish;
                        end

                if($test$plusargs("TEST3"))
                        begin
                                data_h2=new;
                                number_of_transactions = 200;
                                env.build();
                                env.gen.gen_trans = data_h2;
                                env.run();
                                $finish;
                        end

                end

        endtask
endclass








/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid
training courses or received any written authorization from Maven Silicon.

Filename                :       ram_env.sv

Description             :       Environment class for dual port ram_testbench

Author Name             :       Putta Satish

Support e-mail  :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com"

Version                 :       1.0

*********************************************************************************************/
class ram_env;

        //Instantiate virtual interface with Write BFM modport,Read BFM modport,
        //Write monitor modport,Read monitor modport

        virtual ram_if.WR_BFM wr_if;
        virtual ram_if.RD_BFM rd_if;
        virtual ram_if.WR_MON wrmon_if;
        virtual ram_if.RD_MON rdmon_if;


        //Declare 6 mailboxes parameterized by ram_trans and construct it

        mailbox #(ram_trans) gen2wr=new();
        mailbox #(ram_trans) gen2rd=new();

        mailbox #(ram_trans) wr2rm=new();
        mailbox #(ram_trans) rd2rm=new();

        mailbox #(ram_trans) rd2sb=new();

        mailbox #(ram_trans) rm2sb=new();

        //Create handle for ram_gen,ram_read_bfm,ram_write_bfm,
        //ram_read_mon,ram_write_mon,ram_model,ram_sb
        ram_gen gen;
        ram_write_bfm wr_bfm;
        ram_read_bfm rd_bfm;
        ram_write_mon wr_mon;
        ram_read_mon rd_mon;
        ram_model model;
        ram_sb sb;

        //In constructor pass the BFM and monitor interface as the argument
        //and connect with the virtual interfaces of ram _env

        function new(virtual ram_if.WR_BFM wr_if,
                                virtual ram_if.RD_BFM rd_if,
                                virtual ram_if.WR_MON wrmon_if,
                                virtual ram_if.RD_MON rdmon_if);
                this.wr_if = wr_if;
                this.rd_if = rd_if;
                this.wrmon_if = wrmon_if;
                this.rdmon_if = rdmon_if;
        endfunction : new
        //In task build
        //create instances for generator,Read BFM,Write BFM,Write monitor
        //Read monitor,Reference model,Scoreboard

        task build;
                gen = new(gen2rd, gen2wr);
                wr_bfm = new(wr_if,gen2wr);
                rd_bfm = new(rd_if, gen2rd);
                wr_mon = new(wrmon_if,wr2rm);
                rd_mon = new(rdmon_if,rd2rm,rd2sb);
                model= new(wr2rm, rd2rm,rm2sb);
                sb= new(rm2sb,rd2sb);
  endtask : build

        //Understand and include the reset_dut

        task reset_dut();
                begin
                        rd_if.rd_drv_cb.rd_address<='0;
                        rd_if.rd_drv_cb.read<='0;

                        wr_if.wr_drv_cb.wr_address<=0;
                        wr_if.wr_drv_cb.write<='0;

                        repeat(5) @(wr_if.wr_drv_cb);
                        for (int i=0; i<4096; i++)
                                begin
                                        wr_if.wr_drv_cb.write<='1;
                                        wr_if.wr_drv_cb.wr_address<=i;
                                        wr_if.wr_drv_cb.data_in<='0;
                                        @(wr_if.wr_drv_cb);
                                end
                        wr_if.wr_drv_cb.write<='0;
                        repeat (5) @(wr_if.wr_drv_cb);
                end
        endtask : reset_dut

        //In start task
        //call all the start methods of generator,Read BFM,Write BFM
        //Read monitor,Write Monitor,reference model,scoreboard
         task start;
                gen.start();
                wr_bfm.start();
                rd_bfm.start();
                wr_mon.start();
                rd_mon.start();
                model.start();
                sb.start();
                                                       endtask : start

        task stop();
                wait(sb.DONE.triggered);
        endtask : stop

        //In run task call resut_dut, start and stop & report function from scoreboard

        task run();
                reset_dut();
                start();
                stop();
                sb.report();
        endtask : run

endclass : ram_env
