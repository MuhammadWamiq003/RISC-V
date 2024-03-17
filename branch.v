module branch (
    input wire [31:0] op_a,
    input wire [31:0] op_b,
    input wire [2:0] fun3,
    input wire en,
    output reg res
);
    always @(*) begin
        if(en)begin
            case(fun3)
                3'b000: res = (op_a == op_b)? 1:0; //beq
                3'b001: res = (op_a != op_b)? 1:0; //bne
                3'b100: res = ($signed (op_a) < $signed (op_b))? 1:0; //blt
                3'b101: res = ($signed (op_a) >= $signed (op_b))? 1:0; //bge
                3'b110: res = (op_a < op_b)? 1:0; //bltu
                3'b111: res = (op_a >= op_b)? 1:0; //bgeu
            endcase
        end
    end
endmodule