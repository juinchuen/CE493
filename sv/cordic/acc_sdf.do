setenv LMC_TIMEUNIT -9
vlib work
vmap work work

# compile
vlog -work work "cordic_tb.sv"
vlog -work work "runs/RUN_2023-11-15_10-07-41/final/nl/cordic.nl.v"
vlog -work work "gamma.sv"
vlog -work work "../../../openlane/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd_nettype_fix.v"
vlog -work work "../../../openlane/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v"

vsim -classdebug -voptargs=+acc +notimingchecks -L work work.cordic_tb -wlf cordic_tb.wlf -sdftyp cordic_tb/cordic0=runs/RUN_2023-11-15_10-07-41/final/sdf/nom_tt_025C_1v80/cordic__nom_tt_025C_1v80.sdf

#-sdfmin cordic_tb= -sdftyp [<instance>=]<filename> -sdfmax [<instance>=]<filename>


# wave
add wave -noupdate -group TOP -radix unsigned /cordic_tb/*


run -all