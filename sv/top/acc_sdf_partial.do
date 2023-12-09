setenv LMC_TIMEUNIT -9
vlib work
vmap work work

# compile
vlog -work work "../cordic/runs/RUN_2023-12-08_19-39-43/final/nl/cordic.nl.v"
vlog -work work "../clarke/runs/RUN_2023-12-08_18-18-05/final/nl/clarke.nl.v"
vlog -work work "../clarke/runs/RUN_2023-12-08_18-20-49/final/nl/inverse_clarke.nl.v"
vlog -work work "../park/runs/RUN_2023-12-08_18-50-36/final/nl/park.nl.v"
vlog -work work "../park/runs/RUN_2023-12-08_18-30-21/final/nl/inverse_park.nl.v"
vlog -work work "../pid/runs/RUN_2023-12-08_17-37-42/final/nl/pid.nl.v"
vlog -work work "../svm/runs/RUN_2023-12-08_19-11-14/final/nl/svm.nl.v"
vlog -work work "top.sv"
vlog -work work "top_tb.sv"

vlog -work work "../../../openlane/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd_nettype_fix.v"
vlog -work work "../../../openlane/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v"

vsim -classdebug -voptargs=+acc +notimingchecks -L work work.top_tb -wlf top_tb.wlf
-sdftyp top_tb/u_top/cordic0=../cordic/runs/RUN_2023-12-08_19-39-43/final/sdf/nom_tt_025C_1v80/cordic__nom_tt_025C_1v80.sdf
-sdftyp top_tb/u_top/clarke0=../clarke/runs/RUN_2023-12-08_18-18-05/final/sdf/nom_tt_025C_1v80/clarke__nom_tt_025C_1v80.sdf
-sdftyp top_tb/u_top/iclarke0=../clarke/runs/RUN_2023-12-08_18-20-49/final/sdf/nom_tt_025C_1v80/inverse_clarke__nom_tt_025C_1v80.sdf
-sdftyp top_tb/u_top/park0=../park/runs/RUN_2023-12-08_18-50-36/final/sdf/nom_tt_025C_1v80/park__nom_tt_025C_1v80.sdf
-sdftyp top_tb/u_top/ipark0=../park/runs/RUN_2023-12-08_18-30-21/final/sdf/nom_tt_025C_1v80/inverse_park__nom_tt_025C_1v80.sdf
-sdftyp top_tb/u_top/pid_d=../pid/runs/RUN_2023-12-08_17-37-42/final/sdf/nom_tt_025C_1v80/pid__nom_tt_025C_1v80.sdf
-sdftyp top_tb/u_top/pid_q=../pid/runs/RUN_2023-12-08_17-37-42/final/sdf/nom_tt_025C_1v80/pid__nom_tt_025C_1v80.sdf
-sdftyp top_tb/u_top/svm0=../svm/runs/RUN_2023-12-08_19-11-14/final/sdf/nom_tt_025C_1v80/svm__nom_tt_025C_1v80.sdf

# wave
add wave -noupdate -group TOP       -radix decimal /top_tb/*
add wave -noupdate -group CORDIC    -radix decimal /top_tb/u_top/cordic0/*
add wave -noupdate -group CLARKE    -radix decimal /top_tb/u_top/clarke0/*
add wave -noupdate -group PARK      -radix decimal /top_tb/u_top/park0/*
add wave -noupdate -group PID_D     -radix decimal /top_tb/u_top/pid_d/*
add wave -noupdate -group PID_Q     -radix decimal /top_tb/u_top/pid_q/*
add wave -noupdate -group IN_PARK   -radix decimal /top_tb/u_top/ipark0/*
add wave -noupdate -group IN_CLARKE -radix decimal /top_tb/u_top/iclarke0/*
add wave -noupdate -group SVM       -radix decimal /top_tb/u_top/svm0/*

run -all