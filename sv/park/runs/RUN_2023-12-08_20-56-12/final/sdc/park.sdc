###############################################################################
# Created by write_sdc
###############################################################################
current_design park
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 10.0000 [get_ports {clk}]
set_clock_transition 0.1500 [get_clocks {clk}]
set_clock_uncertainty 0.2500 clk
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {alpha[0]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {alpha[10]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {alpha[11]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {alpha[12]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {alpha[13]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {alpha[14]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {alpha[15]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {alpha[16]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {alpha[17]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {alpha[18]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {alpha[1]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {alpha[2]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {alpha[3]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {alpha[4]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {alpha[5]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {alpha[6]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {alpha[7]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {alpha[8]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {alpha[9]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {beta[0]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {beta[10]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {beta[11]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {beta[12]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {beta[13]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {beta[14]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {beta[15]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {beta[16]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {beta[17]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {beta[18]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {beta[1]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {beta[2]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {beta[3]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {beta[4]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {beta[5]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {beta[6]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {beta[7]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {beta[8]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {beta[9]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {cos[0]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {cos[10]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {cos[11]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {cos[12]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {cos[13]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {cos[14]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {cos[15]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {cos[16]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {cos[17]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {cos[18]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {cos[1]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {cos[2]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {cos[3]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {cos[4]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {cos[5]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {cos[6]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {cos[7]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {cos[8]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {cos[9]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rstb}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {sin[0]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {sin[10]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {sin[11]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {sin[12]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {sin[13]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {sin[14]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {sin[15]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {sin[16]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {sin[17]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {sin[18]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {sin[1]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {sin[2]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {sin[3]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {sin[4]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {sin[5]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {sin[6]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {sin[7]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {sin[8]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {sin[9]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {start}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {D[0]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {D[10]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {D[11]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {D[12]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {D[13]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {D[14]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {D[15]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {D[16]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {D[17]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {D[18]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {D[1]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {D[2]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {D[3]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {D[4]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {D[5]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {D[6]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {D[7]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {D[8]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {D[9]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Q[0]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Q[10]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Q[11]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Q[12]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Q[13]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Q[14]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Q[15]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Q[16]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Q[17]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Q[18]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Q[1]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Q[2]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Q[3]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Q[4]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Q[5]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Q[6]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Q[7]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Q[8]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Q[9]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {done}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {done}]
set_load -pin_load 0.0334 [get_ports {D[18]}]
set_load -pin_load 0.0334 [get_ports {D[17]}]
set_load -pin_load 0.0334 [get_ports {D[16]}]
set_load -pin_load 0.0334 [get_ports {D[15]}]
set_load -pin_load 0.0334 [get_ports {D[14]}]
set_load -pin_load 0.0334 [get_ports {D[13]}]
set_load -pin_load 0.0334 [get_ports {D[12]}]
set_load -pin_load 0.0334 [get_ports {D[11]}]
set_load -pin_load 0.0334 [get_ports {D[10]}]
set_load -pin_load 0.0334 [get_ports {D[9]}]
set_load -pin_load 0.0334 [get_ports {D[8]}]
set_load -pin_load 0.0334 [get_ports {D[7]}]
set_load -pin_load 0.0334 [get_ports {D[6]}]
set_load -pin_load 0.0334 [get_ports {D[5]}]
set_load -pin_load 0.0334 [get_ports {D[4]}]
set_load -pin_load 0.0334 [get_ports {D[3]}]
set_load -pin_load 0.0334 [get_ports {D[2]}]
set_load -pin_load 0.0334 [get_ports {D[1]}]
set_load -pin_load 0.0334 [get_ports {D[0]}]
set_load -pin_load 0.0334 [get_ports {Q[18]}]
set_load -pin_load 0.0334 [get_ports {Q[17]}]
set_load -pin_load 0.0334 [get_ports {Q[16]}]
set_load -pin_load 0.0334 [get_ports {Q[15]}]
set_load -pin_load 0.0334 [get_ports {Q[14]}]
set_load -pin_load 0.0334 [get_ports {Q[13]}]
set_load -pin_load 0.0334 [get_ports {Q[12]}]
set_load -pin_load 0.0334 [get_ports {Q[11]}]
set_load -pin_load 0.0334 [get_ports {Q[10]}]
set_load -pin_load 0.0334 [get_ports {Q[9]}]
set_load -pin_load 0.0334 [get_ports {Q[8]}]
set_load -pin_load 0.0334 [get_ports {Q[7]}]
set_load -pin_load 0.0334 [get_ports {Q[6]}]
set_load -pin_load 0.0334 [get_ports {Q[5]}]
set_load -pin_load 0.0334 [get_ports {Q[4]}]
set_load -pin_load 0.0334 [get_ports {Q[3]}]
set_load -pin_load 0.0334 [get_ports {Q[2]}]
set_load -pin_load 0.0334 [get_ports {Q[1]}]
set_load -pin_load 0.0334 [get_ports {Q[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {clk}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {rstb}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {start}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {alpha[18]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {alpha[17]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {alpha[16]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {alpha[15]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {alpha[14]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {alpha[13]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {alpha[12]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {alpha[11]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {alpha[10]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {alpha[9]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {alpha[8]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {alpha[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {alpha[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {alpha[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {alpha[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {alpha[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {alpha[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {alpha[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {alpha[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {beta[18]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {beta[17]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {beta[16]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {beta[15]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {beta[14]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {beta[13]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {beta[12]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {beta[11]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {beta[10]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {beta[9]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {beta[8]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {beta[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {beta[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {beta[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {beta[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {beta[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {beta[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {beta[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {beta[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cos[18]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cos[17]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cos[16]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cos[15]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cos[14]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cos[13]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cos[12]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cos[11]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cos[10]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cos[9]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cos[8]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cos[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cos[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cos[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cos[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cos[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cos[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cos[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {cos[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sin[18]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sin[17]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sin[16]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sin[15]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sin[14]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sin[13]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sin[12]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sin[11]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sin[10]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sin[9]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sin[8]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sin[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sin[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sin[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sin[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sin[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sin[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sin[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sin[0]}]
###############################################################################
# Design Rules
###############################################################################
set_max_transition 0.7500 [current_design]
set_max_fanout 10.0000 [current_design]