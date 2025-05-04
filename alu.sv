module alu#(
    parameter WIDTH = 8
)(
    input logic [WIDTH-1:0] in_a, in_b,
    input logic [2:0] opcode,
    output logic[WIDTH-1:0] result,
    output logic             zero,      // Zero flag
    output logic             carry      // Carry flag
);
    logic [WIDTH:0] extend_result;
    logic [WIDTH*2-1:0] multi_result;

    always_comb begin
        extend_result = '0;
        multi_result = '0;
        result = '0;
        carry = 0;

        case (opcode)
        // Addition
            4'b0: begin
                extend_result = {1'b0, in_a} + {1'b0, in_b};
                result = extend_result[WIDTH-1:0];
                carry = extend_result[WIDTH];
            end
        // Subtraction
            4'b0001: begin
                extend_result = {1'b0, in_a} - {1'b0, in_b};
                result = extend_result[WIDTH-1:0];
                carry = extend_result[WIDTH];
            end
        // Multiplication 
            4'b0010: begin
                multi_result = in_a * in_b;
                result = multi_result[WIDTH-1:0];

            end
        // Division
            4'b0011: 
                result = (in_b != 0) ? in_a / in_b : '0;
            
        // Shift left
            4'b0100: 
                {carry, result} = in_a << 1;
            
        // Shift right
            4'b0101:
                {carry, result} = in_a >> 1;
            
        // AND
            4'b0110:
                result = in_a & in_b;
        // OR
            4'b0111:
                result = in_a | in_b;
        endcase   

        // Flag generation
        zero = (result == '0);
    end

endmodule
