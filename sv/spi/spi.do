setenv LMC_TIMEUNIT -9
vlib work
vmap work work

# compile
vlog -work work "spi_tb.sv"
vlog -work work "spi.sv"
vlog -work work "../fifo.sv"

vsim -classdebug -voptargs=+acc +notimingchecks -L work work.spi_tb -wlf spi_tb.wlf

# wave
add wave -noupdate -group TOP -radix hexadecimal /spi_tb/*
add wave -noupdate -group SPI -radix hexadecimal /spi_tb/spi0/*
add wave -noupdate -group FIFOO -radix hexadecimal /spi_tb/spi0/fifo_o/*
add wave -noupdate -group FIFOD -radix hexadecimal /spi_tb/spi0/fifo_d/*




run -all