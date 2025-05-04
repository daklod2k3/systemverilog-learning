module alu_tb;

    parameter WIDTH = 8;

        // input
        logic [WIDTH-1:0]  in_a;
        logic [WIDTH-1:0]  in_b;
        logic [3:0] opcode;

        //output
        logic [WIDTH-1:0] result;
        logic zero;
        logic carry;

    alu #(.WIDTH(WIDTH)) uut (
        .in_a(in_a),
        .in_b(in_b),
        .opcode(opcode),
        .result(result),
        .zero(zero),
        .carry(carry)
    );

    integer test_count = 0, error_count = 0;
    logic[WIDTH-1:0] expected_result;
    logic expected_zero;

    vcd_dump #(.DEFAULT_VCD_NAME("testbench.vcd"), .DUMP_DEPTH(0)) vcd_dump ();


    initial begin
        
        $monitor("Time=%0t a=%d b=%d opcode=%b result=%d zero=%d expected_result=%d", 
        $time, in_a, in_b, opcode, result, zero, expected_result);

        for (opcode=0; opcode < 2**3; opcode++) begin
            in_a = $urandom_range(2**WIDTH / 2 * -1, 2**WIDTH / 2 - 1);
            in_b = $urandom_range(2**WIDTH / 2 * -1, 2**WIDTH / 2 - 1);
            case (opcode)
                'b0: expected_result = in_a + in_b;
                'b1: expected_result = in_a - in_b;
                'b10: expected_result = in_a * in_b;
                'b11: expected_result = in_a / in_b;
                'b100: expected_result = in_a << 1;
                'b101: expected_result = in_a >> 1;
                'b110: expected_result = in_a & in_b;
                'b111: expected_result = in_a | in_b;
            endcase

            

            expected_zero = expected_result == 0;
            #10;

            test_count ++;

            if (result != expected_result || zero != expected_zero) begin
                $display("ERROR at %t: a=%d b=%d opcode=%b result=%d expected_result=%d zero=%d expected_zero=%d", $time, in_a, in_b, opcode, result, expected_result, zero, expected_zero);
                error_count++;
            end

        end

        // Summary
        $display("\nTest Summary:");
        $display("Total Tests: %0d", test_count);
        $display("Errors: %0d", error_count);
        if (error_count == 0)
            $display("All tests passed!");
        else
            $display("Some tests failed.");

        // End simulation
        
        $finish;
    end



    
endmodule
