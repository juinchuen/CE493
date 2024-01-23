setenv LMC_TIMEUNIT -9
vlib work
vmap work work

# compile
vlog -work work "top.sv"
vlog -work work "top_tb.sv"
vlog -work work "../../cordic/cordic.sv"
vlog -work work "../../matmul/matmul.sv"
vlog -work work "../../pid/pid_v2/pid.sv"
vlog -work work "../../svm/svm_v2/svm.sv"

vsim -classdebug -voptargs=+acc +notimingchecks -L work work.top_tb -wlf top_tb.wlf


# wave
add wave -noupdate -group TB -radix decimal /top_tb/*

add wave -noupdate -group TOP -radix decimal /top_tb/u_top/*

add wave -noupdate -group CORDIC -radix decimal /top_tb/u_top/cordic0/*
add wave -noupdate -group MATMUL -radix decimal /top_tb/u_top/matmul0/*
add wave -noupdate -group PID_D -radix decimal /top_tb/u_top/pid_d/*
add wave -noupdate -group PID_Q -radix decimal /top_tb/u_top/pid_q/*
add wave -noupdate -group SVM -radix decimal /top_tb/u_top/svm0/*




run -all