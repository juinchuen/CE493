setenv LMC_TIMEUNIT -9
vlib work
vmap work work

# compile
vlog -work work "../matmul.sv"
vlog -work work "matmul_tb.sv"

vsim -classdebug -voptargs=+acc +notimingchecks -L work work.matmul_tb -wlf matmul_tb.wlf

# wave
add wave -noupdate -group matmul_tb
add wave -noupdate -group matmul_tb -radix hexadecimal /matmul_tb/*
add wave -noupdate -group matmul_tb/matmul_inst
add wave -noupdate -group matmul_tb/matmul_inst -radix hexadecimal /matmul_tb/matmul_inst/*
add wave -noupdate -group matmul_tb/matmul_inst/matmul_stage_inst
add wave -noupdate -group matmul_tb/matmul_inst/matmul_stage_inst -radix hexadecimal matmul_tb/matmul_inst/matmul_stage_inst/*
add wave -noupdate -group matmul_tb/matmul_inst/matmul_stage_inst/mul_inst
add wave -noupdate -group matmul_tb/matmul_inst/matmul_stage_inst/mul_inst -radix hexadecimal matmul_tb/matmul_inst/matmul_stage_inst/mul_inst/*

run -all