`include "typedec.v"
`include "control_decoder.v"

module controlunit (
    input wire [6:0] opcode,
    input wire [2:0] fun3,
    input wire fun7,

    output wire reg_write,
    output wire [1:0]imm_sel,
    output wire [1:0]rd_sel,
    output wire operand_b,
    output wire mem_to_reg,
    output wire Load,
    output wire Store,
    output wire Branch,
    output wire Jal,
    output wire Jalr,
    output wire mem_en,
    output wire [3:0] alu_control
);

wire r_type;
wire i_type;
wire load;
wire store;
wire branch;
wire jal;
wire jalr;

type_decoder utd0 (
    .opcode(opcode),
    .r_type(r_type),
    .i_type(i_type),
    .load(load),
    .store(store),
    .branch(branch),
    .jal(jal),
    .jalr(jalr)
);

control_decoder ucd0 (
    .fun3(fun3),
    .fun7(fun7),
    .i_type(i_type),
    .r_type(r_type),
    .load(load),
    .store(store),
    .branch(branch),
    .jal(jal),
    .jalr(jalr),
    .Load(Load),
    .Store(Store),
    .Branch(Branch),
    .Jal(Jal),
    .Jalr(Jalr),
    .mem_to_reg(mem_to_reg),
    .reg_write(reg_write),
    .mem_en(mem_en),
    .operand_b(operand_b),
    .imm_sel(imm_sel),
    .rd_sel(rd_sel),
    .alu_control(alu_control)
);

endmodule