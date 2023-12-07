setenv LMC_TIMEUNIT -9
vlib work
vmap work work

# compile
vlog -work work "../cordic/gamma.sv"
vlog -work work "../cordic/cordic.sv"
vlog -work work "../clarke/clarke.sv"
vlog -work work "../clarke/inverse_clarke.sv"
vlog -work work "../park/park.sv"
vlog -work work "../park/inverse_park.sv"
vlog -work work "../pid/pid.sv"
vlog -work work "../svm/svm.sv"
vlog -work work "top.sv"
vlog -work work "top_tb.sv"

vsim -classdebug -voptargs=+acc +notimingchecks -L work work.top_tb -wlf top_tb.wlf

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