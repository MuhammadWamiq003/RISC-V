`include "controlunit.v"
`include "mux1.v"
`include "mux2.v"
`include "mux3.v"
`include "alu.v"
`include "registerfile.v"
`include "immediategeneration.v"
`include "instructionmemory.v"
`include "pc.v"
`include "wrapmem.v"
`include "datamemory.v"
`include "branch.v"

module single_cycle (
    input wire clk,
    input wire en,
    input wire rst,
    input wire [31:0]instruction
);

    wire [31:0] data;
    wire [31:0] i_immo;
    wire [31:0] s_immo;
    wire [31:0] sb_immo;
    wire [31:0] uj_immo;
    wire reg_write;
    wire [1:0]imm_sel,rd_sel;
    wire mem_en;
    wire loaden,branchen,jalen,jalren;
    wire operand_b;
    wire out_sel,resb;
    wire [3:0] mmaask;
    wire [3:0] alu_control;
    wire [31:0] op_a, op_b, out,outb, res_o;
    wire [31:0] inadd, outadd, m2out;
    wire [31:0] dmout,dmin, wlout,m3data;

    pc u_pc0 (
        .clk(clk),
        .rst(rst),
        .branch(branchen),
        .jal(jalen),
        .jalr(jalren),
        .branch_res(resb),
        .address_in(0),
        .branch_add(res_o),
        .jal_add(res_o),
        .jalr_add(res_o),
        .address_out(inadd)
    );

    instructionmemory u_im0 (
        .clk(clk),
        .enable(en),
        .address(inadd[9:2]),
        .data_in(instruction),
        .data_out(data)
    );

    immediategen u_ig0 (
        .instr(data),
        .i_imme(i_immo),
        .s_imme(s_immo),
        .sb_imme(sb_immo),
        .jal_imme(uj_immo)
    );

    controlunit u_cu0 (
        .opcode(data[6:0]),
        .fun3(data[14:12]),
        .fun7(data[30]),
        .reg_write(reg_write),
        .imm_sel(imm_sel),
        .rd_sel(rd_sel),
        .operand_b(operand_b),
        .mem_to_reg(mem_to_reg),
        .Load(loaden),
        .Store(Store),
        .Branch(branchen),
        .Jal(jalen),
        .Jalr(jalren),
        .mem_en(mem_en),
        .alu_control(alu_control)
    );

    registerfile u_rf0 (
        .clk(clk),
        .rst(rst),
        .en(reg_write),
        .rs1(data[19:15]),
        .rs2(data[24:20]),
        .rd(data[11:7]),
        .data(m3data),
        .op_a(op_a),
        .op_b(op_b)
    );

    mux u_mx0 (
        .a(op_b),
        .b(m2out),
        .sel(operand_b),
        .out(out)
    );

    muxx u_mxx0 (
        .i(i_immo),
        .s(s_immo),
        .sb(sb_immo),
        .uj(uj_immo),
        .imm_sel(imm_sel),
        .out_sel(m2out)
    );

    muxxx u_mxxx0 (
        .alu_out(res_o),
        .wrapmemout(wlout),
        .jal_add(inadd),
        .rsel(rd_sel),
        .data_reg_in(m3data)
    );

    mux u_mxb (
        .a(op_a),
        .b(inadd),
        .sel(branchen | jalen),
        .out(outb)
    );

    alu u_alu0 (
        .a_i(outb),
        .b_i(out),
        .op_i(alu_control),
        .res_o(res_o)
    );

    branch u_bh0 (
        .op_a(op_a),
        .op_b(op_b),
        .fun3(data[14:12]),
        .en(branchen),
        .res(resb)
    );

    wrappermem u_wm0 (
        .data_i(op_b),
        .byteadd(res_o[1:0]),
        .fun3(data[14:12]),
        .mem_en(mem_en),
        .Load(loaden),
        .wrap_load_in(dmout),

        .masking(mmaask),
        .data_o(dmin),
        .wrap_load_out(wlout)
    );

    datamemory u_dm0(
        .clk(clk),
        .mem_en(mem_en),
        .address(res_o[9:2]),
        .storein(dmin),
        .mask(mmaask),
        .loadout(dmout)
    );

endmodule