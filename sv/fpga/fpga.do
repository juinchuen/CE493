setenv LMC_TIMEUNIT -9
vlib work
vmap work work

# compile
vlog -work work "fpga_wrapper_tb.sv"
vlog -work work "fpga_wrapper.sv"
vlog -work work "../top/top_v3/top.sv"
vlog -work work "../cordic/cordic.sv"
vlog -work work "../cordic/gamma.sv"
vlog -work work "../matmul/matmul.sv"
vlog -work work "../pid/pid_v3/pid.sv"
vlog -work work "../svm/svm_v2/svm.sv"
vlog -work work "../spi/spi_v2/spi.sv"
vlog -work work "../fifo.sv"

vsim -classdebug -voptargs=+acc +notimingchecks -L work work.fpga_wrapper_tb -wlf spi_fpga_wrapper_tb.wlf

# wave
add wave -noupdate -group TOP -radix hexadecimal /fpga_wrapper_tb/*

add wave -noupdate -group SPIS -radix hexadecimal /fpga_wrapper_tb/spis0/*

add wave -noupdate -group FPGA -radix hexadecimal /fpga_wrapper_tb/fpgaw0/*

add wave -noupdate -group FOC -radix hexadecimal /fpga_wrapper_tb/fpgaw0/top0/*


run -all