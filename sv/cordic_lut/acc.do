setenv LMC_TIMEUNIT -9
vlib work
vmap work work

# compile
vlog -work work "cordic.sv"
vlog -work work "cordic_tb.sv"


vsim -classdebug -voptargs=+acc +notimingchecks -L work work.cordic_tb -wlf cordic_tb.wlf

# wave
add wave -noupdate -group TOP
add wave -noupdate -group TOP -radix hexadecimal /cordic_tb/*

run -all