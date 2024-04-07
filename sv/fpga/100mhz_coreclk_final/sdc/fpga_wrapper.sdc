###############################################################################
# Created by write_sdc
###############################################################################
current_design fpga_wrapper
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk_sys -period 25.0000 [get_ports {clk_sys}]
set_clock_transition 0.1500 [get_clocks {clk_sys}]
set_clock_uncertainty 0.2500 clk_sys
create_clock -name clk_mosi -period 100.0000 [get_ports {clk_mosi}]
set_clock_transition 0.1500 [get_clocks {clk_mosi}]
set_clock_uncertainty 0.2500 clk_mosi
set_clock_groups -name group1 -asynchronous \
 -group [get_clocks {clk_mosi}]\
 -group [get_clocks {clk_sys}]
set_input_delay 5.0000 -clock [get_clocks {clk_mosi}] -add_delay [get_ports {cs}]
set_input_delay 5.0000 -clock [get_clocks {clk_sys}] -add_delay [get_ports {rstb}]
set_input_delay 5.0000 -clock [get_clocks {clk_mosi}] -add_delay [get_ports {spi_mosi}]
set_output_delay 5.0000 -clock [get_clocks {clk_sys}] -add_delay [get_ports {pwmA}]
set_output_delay 5.0000 -clock [get_clocks {clk_sys}] -add_delay [get_ports {pwmB}]
set_output_delay 5.0000 -clock [get_clocks {clk_sys}] -add_delay [get_ports {pwmC}]
set_output_delay 5.0000 -clock [get_clocks {clk_sys}] -add_delay [get_ports {ready}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {pwmA}]
set_load -pin_load 0.0334 [get_ports {pwmB}]
set_load -pin_load 0.0334 [get_ports {pwmC}]
set_load -pin_load 0.0334 [get_ports {ready}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {clk_mosi}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {clk_sys}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cs}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {rstb}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {spi_mosi}]
###############################################################################
# Design Rules
###############################################################################
set_max_transition 0.7500 [current_design]
set_max_fanout 10.0000 [current_design]
