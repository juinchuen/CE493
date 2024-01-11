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

add wave -noupdate -group DUT -radix decimal /pid_tb/pid0/state
add wave -noupdate -group DUT -radix decimal /pid_tb/pid0/iterate_enable
add wave -noupdate -group DUT -radix decimal /pid_tb/pid0/target
add wave -noupdate -group DUT -radix decimal /pid_tb/pid0/measurement
add wave -noupdate -group DUT -radix decimal /pid_tb/pid0/out
add wave -noupdate -group DUT -radix decimal /pid_tb/pid0/out_valid
add wave -noupdate -group DUT -radix decimal /pid_tb/pid0/curr*
add wave -noupdate -group DUT -radix decimal /pid_tb/pid0/prev*


run -all