setenv LMC_TIMEUNIT -9
vlib work
vmap work work

# compile
vlog -work work "runs/RUN_2023-12-07_07-52-09/final/nl/top.nl.v"
vlog -work work "top_tb.sv"
vlog -work work "../../../openlane/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd_nettype_fix.v"
vlog -work work "../../../openlane/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v"

vsim -classdebug -voptargs=+acc +notimingchecks -L work work.top_tb -wlf top_tb.wlf -sdftyp top_tb/u_top=runs/RUN_2023-12-07_07-52-09/final/sdf/max_ff_n40C_1v95/top__max_ff_n40C_1v95.sdf


# wave
add wave -noupdate -group TOP       -radix decimal /top_tb/*

run -all