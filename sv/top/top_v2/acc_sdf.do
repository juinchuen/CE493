setenv LMC_TIMEUNIT -9
vlib work
vmap work work

# latest successful run: /home/jco1147/393_folder/CE493/sv/top/top_v2/runs/RUN_2024-01-22_21-16-14

# compile
vlog -work work "runs/RUN_2024-01-22_21-16-14/final/nl/top.nl.v"
vlog -work work "top_tb.sv"
vlog -work work "../../../openlane/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd_nettype_fix.v"
vlog -work work "../../../openlane/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v"

vsim -classdebug -voptargs=+acc +notimingchecks -L work work.top_tb -wlf top_tb.wlf -sdftyp top_tb/u_top=runs/RUN_2024-01-22_21-16-14/final/sdf/nom_tt_025C_1v80/top__nom_tt_025C_1v80.sdf


# wave
add wave -noupdate -group TOP       -radix decimal /top_tb/*

run -all