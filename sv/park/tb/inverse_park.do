setenv LMC_TIMEUNIT -9
vlib work
vmap work work

# compile
vlog -work work "../inverse_park.sv"
vlog -work work "inverse_park_tb.sv"

vsim -classdebug -voptargs=+acc +notimingchecks -L work work.inverse_park_tb -wlf inverse_park_tb.wlf

# wave
add wave -noupdate -group inverse_park_tb
add wave -noupdate -group inverse_park_tb -radix hexadecimal /inverse_park_tb/*
add wave -noupdate -group inverse_park_tb/u_clarke
add wave -noupdate -group inverse_park_tb/u_clarke -radix hexadecimal /inverse_park_tb/u_inverse_park/*

run -all