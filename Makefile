

run-alu: clean
	@verilator --binary -f verilator.f 
	@./obj_dir/Valu_tb +vcd="alu_wave.vcd"
	@gtkwave alu_wave.vcd

clean:
	@rm -rf obj_dir
