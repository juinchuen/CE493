setenv LMC_TIMEUNIT -9
vlib work
vmap work work

# compile
vlog -work work "pid.sv"
vlog -work work "pid_tb.sv"

vsim -classdebug -voptargs=+acc +notimingchecks -L work work.pid_tb -wlf pid_tb.wlf

# wave
add wave -noupdate -group TOP -radix decimal /pid_tb/*
add wave -noupdate -group ALL -radix decimal /pid_tb/pid0/*

run -all