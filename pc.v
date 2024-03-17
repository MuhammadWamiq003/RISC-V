module pc (
    input wire clk,
    input wire rst,
    input wire branch,
    input wire jal,
    input wire jalr,
    input wire branch_res,
    input wire [31:0]address_in,
    input wire [31:0]branch_add,
    input wire [31:0]jal_add,
    input wire [31:0]jalr_add,
    output reg [31:0]address_out
);

always @(posedge clk or negedge rst) begin
    if(!rst)begin
        address_out <= 0;
    end
    else if(branch && branch_res ) begin
        address_out <= branch_add;
    end
    else if (jal) begin
        address_out <= jal_add;
    end
    else if (jalr) begin
        address_out <= jalr_add;
    end
    else begin
        address_out <= address_out + 32'd4;
    end
end
endmodule