setenv LMC_TIMEUNIT -9
vlib work
vmap work work

# compile
vlog -work work "svm_tb_v1.sv"
vlog -work work "svm_v1.sv"

vsim -classdebug -voptargs=+acc +notimingchecks -L work work.svm_tb -wlf svm_tb.wlf

# wave
add wave -noupdate -group TOP
add wave -noupdate -group TOP -radix unsigned /svm_tb/*
add wave -noupdate -group ALU -radix unsigned /svm_tb/svm0/*

run -all