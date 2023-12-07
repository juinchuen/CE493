setenv LMC_TIMEUNIT -9
vlib work
vmap work work

# compile
vlog -work work "../clarke.sv"
vlog -work work "clarke_tb.sv"

vsim -classdebug -voptargs=+acc +notimingchecks -L work work.clarke_tb -wlf clarke_tb.wlf

# wave
add wave -noupdate -group /clarke_tb/*
add wave -noupdate -group /clarke_tb/u_clarke/*

run -all