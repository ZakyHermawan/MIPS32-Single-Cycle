onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/clock
add wave -noupdate /testbench/reset
add wave -noupdate -radix hexadecimal /testbench/PC_in_t
add wave -noupdate -radix hexadecimal /testbench/PC_out_t
add wave -noupdate -radix hexadecimal /testbench/addr_imem_t
add wave -noupdate -radix hexadecimal /testbench/instr_imem_t
add wave -noupdate /testbench/op_in_t
add wave -noupdate /testbench/funct_in_t
add wave -noupdate /testbench/sig_jmp_t
add wave -noupdate /testbench/sig_bne_t
add wave -noupdate /testbench/sig_branch_t
add wave -noupdate /testbench/sig_memtoreg_t
add wave -noupdate /testbench/sig_memread_t
add wave -noupdate /testbench/sig_memwrite_t
add wave -noupdate /testbench/sig_regdest_t
add wave -noupdate /testbench/sig_regwrite_t
add wave -noupdate /testbench/sig_alusrc_t
add wave -noupdate /testbench/sig_aluctrl_t
add wave -noupdate /testbench/wr_en_regfile_t
add wave -noupdate -radix hexadecimal /testbench/addr_1_regfile_t
add wave -noupdate -radix hexadecimal /testbench/addr_2_regfile_t
add wave -noupdate -radix hexadecimal /testbench/addr_3_regfile_t
add wave -noupdate -radix hexadecimal /testbench/wr_data_3_regfile_t
add wave -noupdate -radix hexadecimal /testbench/rd_data_1_regfile_t
add wave -noupdate -radix hexadecimal /testbench/rd_data_2_regfile_t
add wave -noupdate -radix hexadecimal /testbench/D_In_sgn_extender_t
add wave -noupdate -radix hexadecimal /testbench/D_Out_sgn_extender_t
add wave -noupdate -radix hexadecimal /testbench/oprnd_1_alu_t
add wave -noupdate -radix hexadecimal /testbench/oprnd_2_alu_t
add wave -noupdate /testbench/op_sel_alu_t
add wave -noupdate -radix hexadecimal /testbench/result_alu_t
add wave -noupdate -radix hexadecimal /testbench/addr_dmemory_t
add wave -noupdate /testbench/write_en_dmemory_t
add wave -noupdate /testbench/rd_en_dmemory_t
add wave -noupdate -radix hexadecimal /testbench/rd_data_dmemory_t
add wave -noupdate -radix hexadecimal /testbench/wr_data_dmemory_t
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 226
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {910 ps}
