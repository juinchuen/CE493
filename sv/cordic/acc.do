setenv LMC_TIMEUNIT -9
vlib work
vmap work work

# compile
vlog -work work "cordic_tb.sv"
vlog -work work "cordic.sv"
vlog -work work "gamma.sv"

vsim -classdebug -voptargs=+acc +notimingchecks -L work work.cordic_tb -wlf cordic_tb.wlf

# wave
add wave -noupdate -group TOP -radix unsigned /cordic_tb/*
add wave -noupdate -group ALU -radix unsigned /cordic_tb/cordic0/theta
add wave -noupdate -group ALU -radix unsigned /cordic_tb/cordic0/out_valid
add wave -noupdate -group ALU -radix unsigned /cordic_tb/cordic0/state
add wave -noupdate -group ALU -radix unsigned /cordic_tb/cordic0/theta_store
add wave -noupdate -group ALU -radix decimal  /cordic_tb/cordic0/theta_iter
add wave -noupdate -group ALU -radix unsigned /cordic_tb/cordic0/gamma_i
add wave -noupdate -group ALU -radix unsigned /cordic_tb/cordic0/sigma
add wave -noupdate -group ALU -radix unsigned /cordic_tb/cordic0/vec

add wave -noupdate -group ALL -radix unsigned /cordic_tb/cordic0/*
add wave -noupdate -group ALL -radix unsigned /cordic_tb/cordic0/vec


run -all