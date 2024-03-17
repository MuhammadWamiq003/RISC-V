module muxxx (
    input wire [31:0] alu_out,
    input wire [31:0] wrapmemout,
    input wire [31:0] jal_add,
    input wire [1:0]rsel,
    output wire [31:0] data_reg_in
);
    assign data_reg_in = (rsel==2'b00)?alu_out:(rsel==2'b01)?wrapmemout:(rsel==2'b10)?jal_add+4:0;

endmodule