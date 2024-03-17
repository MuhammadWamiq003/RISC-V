module muxx (
    input wire [31:0]i,
    input wire [31:0]s,
    input wire [31:0]sb,
    input wire [31:0]uj,
    input wire [1:0]imm_sel,
    output wire [31:0]out_sel
);
    assign out_sel = (imm_sel==2'b00)? i : (imm_sel==2'b01)? s : (imm_sel==2'b10)? sb : uj;

endmodule