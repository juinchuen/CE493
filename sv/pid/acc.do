setenv LMC_TIMEUNIT -9
vlib work
vmap work work

# compile
vlog -work work "pid_tb.sv"
vlog -work work "pid.sv"

vsim -classdebug -voptargs=+acc +notimingchecks -L work work.pid_tb -wlf pid_tb.wlf

# wave
add wave -noupdate -group TOP -radix decimal /pid_tb/*
add wave -noupdate -group ALL -radix decimal /pid_tb/test_pid/*

run -all