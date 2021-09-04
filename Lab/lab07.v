class ram_trans;        // In class ram_trans Declare the following rand fields
        rand logic [63:0] data;// data (bit/logic type , size 64)
        rand logic [11:0] rd_address, wr_address; // rd_address, wr_address (bit/logic type , size 12)
        rand logic read, write; // read, write (bit/logic type , size 1)
        logic [63:0] data_out;// Declare a variable data_out (logic type , size 64)
        static int trans_id;// Declare a static variable trans_id (int type), to keep the count of transactions generated
        static int no_of_read_trans;// Declare 3 static variables no_of_read_trans, no_of_write_trans, no_of_RW_trans (int type)
        static int no_of_write_trans;
        static int no_of_RW_trans; // Add the following constraints
        constraint valid_address { wr_address != rd_address; }// wr_address!=rd_address;
        constraint valid_data{{read,write} != 2'b00;} // read,write != 2'b00;
        constraint data_range{data inside {[1:4294]};}// data between 1 and 4294
        function void display(input string message);//In display method
                $display("%s",message);// Display the string
                if(message == "randomized data")begin
                        $display("total : %0d, read : %0d, write : %0d, RW : %0d",trans_id,no_of_read_trans,no_of_write_trans,no_of_RW_trans);
                end// Display all the properties of the transaction class
                $display("read = %0d, write = %0d",read,write);
                $display("rd_addr :%0d, wr_addr :%0d",rd_address, wr_address);
                $display("data : %0d,data_out : %0d \n\n\n\n\n",data,data_out);
        endfunction
        function void post_randomize(); // In post_randomize method
                trans_id++;// Increment trans_id
                if (this.read == 1 && this.write == 0) no_of_read_trans++;// If it is only read transaction, increment no_of_read_trans
                if (this.read == 0 && this.write == 1) no_of_write_trans++;// If it is only write transaction, increment no_of_write_trans
                if (this.read == 1 && this.write == 1) no_of_RW_trans++;// If it is read-write transaction, increment no_of_RW_trans
                this.display("randomized data");// call the display method and pass a string
        endfunction
        function bit compare(input ram_trans rcv,output string message);
                compare='0;
                begin
                        if (this.rd_address != rcv.rd_address) begin
                                $display($time);
                                message = "ADDRESS MISMATCH";
                                return(0);
                        end
                        if (this.data_out != rcv.data_out) begin
                                $display($time);
                                message = "DATA MISMATCH";
                                return(0);
                        end
                        begin
                                message = "SUCCESSFULL";
                                return(1);
                        end
                end
        endfunction
endclass