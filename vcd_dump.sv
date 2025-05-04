module vcd_dump;
    // Parameters for customization
    parameter string DEFAULT_VCD_NAME = "dump.vcd"; // Default VCD filename
    parameter int DUMP_DEPTH = 0;                  // 0 = dump all levels, 1 = top-level only, etc.

    // Local variables
    string vcd_file;

    // Initial block to handle VCD dumping
    initial begin
        // Check for +vcd=filename command-line argument
        if ($value$plusargs("vcd=%s", vcd_file)) begin
            $dumpfile(vcd_file);           // Set VCD output file
            $dumpvars(DUMP_DEPTH, vcd_dump); // Dump variables starting from this module
            $display("VCD dump enabled: %s, depth=%0d", vcd_file, DUMP_DEPTH);
        end else begin
            // Optional: Use default VCD name if no argument provided
            // Comment this out if you want VCD dumping only with +vcd
            vcd_file = DEFAULT_VCD_NAME;
            $dumpfile(vcd_file);
            $dumpvars(DUMP_DEPTH, vcd_dump);
            $display("VCD dump enabled with default file: %s, depth=%0d", vcd_file, DUMP_DEPTH);
        end
    end
endmodule
