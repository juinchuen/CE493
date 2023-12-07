###############################################################################
# Created by write_sdc
###############################################################################
current_design svm
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 10.0000 [get_ports {clk}]
set_clock_transition 0.1500 [get_clocks {clk}]
set_clock_uncertainty 0.2500 clk
set_propagated_clock [get_clocks {clk}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {periodTop[0]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {periodTop[10]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {periodTop[11]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {periodTop[12]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {periodTop[13]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {periodTop[14]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {periodTop[15]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {periodTop[1]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {periodTop[2]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {periodTop[3]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {periodTop[4]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {periodTop[5]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {periodTop[6]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {periodTop[7]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {periodTop[8]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {periodTop[9]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rstb}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vA[0]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vA[10]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vA[11]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vA[12]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vA[13]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vA[14]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vA[15]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vA[1]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vA[2]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vA[3]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vA[4]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vA[5]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vA[6]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vA[7]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vA[8]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vA[9]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vB[0]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vB[10]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vB[11]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vB[12]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vB[13]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vB[14]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vB[15]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vB[1]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vB[2]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vB[3]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vB[4]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vB[5]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vB[6]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vB[7]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vB[8]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vB[9]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vC[0]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vC[10]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vC[11]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vC[12]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vC[13]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vC[14]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vC[15]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vC[1]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vC[2]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vC[3]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vC[4]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vC[5]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vC[6]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vC[7]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vC[8]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {vC[9]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {halt}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {pwmA}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {pwmB}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {pwmC}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {halt}]
set_load -pin_load 0.0334 [get_ports {pwmA}]
set_load -pin_load 0.0334 [get_ports {pwmB}]
set_load -pin_load 0.0334 [get_ports {pwmC}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {clk}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {rstb}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {periodTop[15]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {periodTop[14]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {periodTop[13]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {periodTop[12]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {periodTop[11]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {periodTop[10]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {periodTop[9]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {periodTop[8]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {periodTop[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {periodTop[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {periodTop[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {periodTop[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {periodTop[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {periodTop[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {periodTop[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {periodTop[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vA[15]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vA[14]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vA[13]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vA[12]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vA[11]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vA[10]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vA[9]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vA[8]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vA[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vA[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vA[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vA[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vA[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vA[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vA[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vA[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vB[15]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vB[14]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vB[13]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vB[12]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vB[11]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vB[10]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vB[9]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vB[8]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vB[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vB[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vB[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vB[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vB[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vB[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vB[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vB[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vC[15]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vC[14]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vC[13]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vC[12]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vC[11]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vC[10]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vC[9]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vC[8]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vC[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vC[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vC[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vC[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vC[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vC[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vC[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {vC[0]}]
###############################################################################
# Design Rules
###############################################################################
set_max_transition 0.7500 [current_design]
set_max_fanout 10.0000 [current_design]
