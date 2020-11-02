`timescale 1ns / 1ps
`include "fifo.sv"
`include "Library.sv"

module dato#(parameter drvrs, parameter pckg_sz)(
output reg[pckg_sz-1:0] dato
);
   initial begin
      reg[8-3:0]c;
      reg[1:0]a;
      reg [pckg_sz-9:0] b;
      a=$urandom; 
      b=$urandom;
      c=8'b0; 
      assign dato = {a,c,b};
   end
endmodule

module Driver #(parameter drvrs=4, parameter pckg_sz=16, parameter depth=16, parameter broadcast = {8{1'b1}})(
    input clk,
    input rst,
    input pop_int,
    output D_out_int,
    output pndng_int
    );
    wire full;
    wire [pckg_sz-1:0]Din;
    wire [pckg_sz-1:0]Dout;
    wire push;
    wire pop;
    wire [pckg_sz-1:0] variable;
    genvar b;
    genvar i;
    generate
        for(b=0; b < 1; b=b+1)
        begin: Fifo
            for (i=0; i < drvrs; i=i+1)
            begin: ID
            fifo_flops #(depth, pckg_sz) fifo_drvr(
            .Din(Din),
            .Dout(Dout),
            .push(push),
            .pop(pop),
            .clk(clk),
            .full(full),
            .pndng(pndng_int),
            .rst(rst)
            );
            genvar e;
            for (e=0; e < depth; e=e+1)
                begin
                assign push =0;
                dato#(drvrs, pckg_sz)vrbl(.dato(variable));
                assign Din=variable;
                assign push =1;

	            end
	       end
	  end
	  endgenerate
	endmodule

