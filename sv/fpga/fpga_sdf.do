setenv LMC_TIMEUNIT -9
vlib work
vmap work work

# fpga/runs/RUN_2024-02-27_14-33-42

# compile
vlog -work work "fpga_wrapper_tb.sv"
vlog -work work "runs/RUN_2024-02-27_14-33-42/final/nl/fpga_wrapper.nl.v"
vlog -work work "../spi/spi_v2/spi.sv"
vlog -work work "../../openlane/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd_nettype_fix.v"
vlog -work work "../../openlane/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v"

vsim -classdebug -voptargs=+acc +notimingchecks -L work work.fpga_wrapper_tb -wlf spi_fpga_wrapper_tb.wlf -sdftyp fpga_wrapper_tb/fpgaw0=runs/RUN_2024-02-27_14-33-42/final/sdf/nom_tt_025C_1v80/fpga_wrapper__nom_tt_025C_1v80.sdf

# wave
add wave -noupdate -group FPGA -radix hexadecimal /fpga_wrapper_tb/*
add wave -noupdate -group SPI -radix hexadecimal /fpga_wrapper_tb/spis0/*

add wave -noupdate -group TOP -radix hexadecimal sim:/fpga_wrapper_tb/fpgaw0/*



run -all