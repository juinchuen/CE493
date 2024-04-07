setenv LMC_TIMEUNIT -9
vlib work
vmap work work

# /home/jco1147/393_folder/CE493/sv/fpga/runs/RUN_2024-04-04_11-08-56

# compile
vlog -work work "fpga_wrapper_tb.sv"
vlog -work work "runs/RUN_2024-04-04_11-08-56/final/nl/fpga_wrapper.nl.v"
vlog -work work "../spi/spi_v2/spi.sv"
vlog -work work "../../openlane/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd_nettype_fix.v"
vlog -work work "../../openlane/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v"

vsim -classdebug -voptargs=+acc +notimingchecks -L work work.fpga_wrapper_tb -wlf spi_fpga_wrapper_tb.wlf \
-sdftyp fpga_wrapper_tb/fpgaw0=runs/RUN_2024-04-04_11-08-56/final/sdf/nom_tt_025C_1v80/fpga_wrapper__nom_tt_025C_1v80.sdf\
-sdfmin fpga_wrapper_tb/fpgaw0=runs/RUN_2024-04-04_11-08-56/final/sdf/min_tt_025C_1v80/fpga_wrapper__min_tt_025C_1v80.sdf\
-sdfmax fpga_wrapper_tb/fpgaw0=runs/RUN_2024-04-04_11-08-56/final/sdf/max_tt_025C_1v80/fpga_wrapper__max_tt_025C_1v80.sdf

# vsim -classdebug -voptargs=+acc +notimingchecks -L work work.fpga_wrapper_tb -wlf spi_fpga_wrapper_tb.wlf -sdftyp fpga_wrapper_tb/fpgaw0=runs/RUN_2024-04-04_11-08-56/final/sdf/nom_tt_025C_1v80/fpga_wrapper__nom_tt_025C_1v80.sdf

# wave
add wave -noupdate -group FPGA -radix hexadecimal /fpga_wrapper_tb/*
add wave -noupdate -group SPI -radix hexadecimal /fpga_wrapper_tb/spis0/*

add wave -noupdate -group TOP -radix hexadecimal sim:/fpga_wrapper_tb/fpgaw0/*

run -all