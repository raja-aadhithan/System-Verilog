module mass_task(input clk, d, output reg y);
always@(negedge d) y <= 1'b0;
always@(posedge d) begin
    @(posedge clk) y<= 1'b1;
end
endmodule