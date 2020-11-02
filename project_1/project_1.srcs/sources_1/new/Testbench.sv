`timescale 1ns / 1ps
`include "fifo.sv"
`include "Library.sv"
`include "Driver.sv"


module test #( parameter depth=16, parameter bits = 1,parameter drvrs = 4, parameter pckg_sz = 16, parameter broadcast = {8{1'b1}}) (
  input clk,
  input rst
);

  wire pndng[bits-1:0][drvrs-1:0];
  wire push[bits-1:0][drvrs-1:0];
  wire pop[bits-1:0][drvrs-1:0];
  wire  [pckg_sz-1:0] D_pop[bits-1:0][drvrs-1:0];
  wire [pckg_sz-1:0] D_push[bits-1:0][drvrs-1:0];
  
  wire [bits-1:0]tmp1;
  wire [drvrs-1:0]tmp2;
  reg[5:0] pop_t;
  assign pop_t={tmp1,tmp2};
  
  reg[5:0] pndng_t;
  assign pndng_t_t={tmp1,tmp2};
  
  reg[pckg_sz-1:0]D_pop_t; 
  wire [bits-1:0]tmp3;
  wire [drvrs-1:0]tmp4;
  assign D_pop_t ={tmp3,tmp4};

bs_gnrtr_n_rbtr #(bits,drvrs,pckg_sz, broadcast) uut (
.clk(clk),
.reset(rst),
.pndng(pndng),
.push(push),
.pop(pop),
.D_pop(D_pop),
.D_push(D_push)
);

Driver #(drvrs, pckg_sz,depth,broadcast)driver(
    .clk(clk),
    .rst(rst),
    .pop_int(pop_t),
    .D_out_int(D_pop_t),
    .pndng_int(pndng_t)
    );



endmodule

