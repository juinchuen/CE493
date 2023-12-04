setenv LMC_TIMEUNIT -9
vlib work
vmap work work

# compile
vlog -work work "svm_tb.sv"
vlog -work work "runs/RUN_2023-11-29_17-14-46/final/nl/svm.nl.v"
vlog -work work "../../../openlane/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd_nettype_fix.v"
vlog -work work "../../../openlane/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v"

vsim -classdebug -voptargs=+acc +notimingchecks -L work work.svm_tb -wlf svm_tb.wlf -sdftyp svm_tb/svm0=runs/RUN_2023-11-29_17-14-46/final/sdf/nom_tt_025C_1v80/svm__nom_tt_025C_1v80.sdf

# wave
add wave -noupdate -group TOP
add wave -noupdate -group TOP -radix unsigned /svm_tb/*
# add wave -noupdate -group ALU -radix unsigned /svm_tb/svm0/*

run -all