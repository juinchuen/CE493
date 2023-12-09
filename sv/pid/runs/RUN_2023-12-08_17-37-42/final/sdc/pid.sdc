###############################################################################
# Created by write_sdc
###############################################################################
current_design pid
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clock -period 10.0000 [get_ports {clock}]
set_clock_transition 0.1500 [get_clocks {clock}]
set_clock_uncertainty 0.2500 clock
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {iterate_enable}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {measurement[0]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {measurement[10]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {measurement[11]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {measurement[12]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {measurement[13]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {measurement[14]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {measurement[15]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {measurement[16]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {measurement[17]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {measurement[1]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {measurement[2]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {measurement[3]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {measurement[4]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {measurement[5]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {measurement[6]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {measurement[7]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {measurement[8]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {measurement[9]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_addr[0]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_addr[10]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_addr[11]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_addr[12]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_addr[13]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_addr[14]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_addr[15]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_addr[16]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_addr[17]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_addr[1]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_addr[2]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_addr[3]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_addr[4]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_addr[5]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_addr[6]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_addr[7]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_addr[8]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_addr[9]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_data[0]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_data[10]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_data[11]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_data[12]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_data[13]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_data[14]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_data[15]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_data[16]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_data[17]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_data[1]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_data[2]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_data[3]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_data[4]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_data[5]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_data[6]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_data[7]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_data[8]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reg_data[9]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {reset}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {target[0]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {target[10]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {target[11]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {target[12]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {target[13]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {target[14]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {target[15]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {target[16]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {target[17]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {target[1]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {target[2]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {target[3]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {target[4]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {target[5]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {target[6]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {target[7]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {target[8]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {target[9]}]
set_input_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {write_enable}]
set_output_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {out_clocked[0]}]
set_output_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {out_clocked[10]}]
set_output_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {out_clocked[11]}]
set_output_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {out_clocked[12]}]
set_output_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {out_clocked[13]}]
set_output_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {out_clocked[14]}]
set_output_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {out_clocked[15]}]
set_output_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {out_clocked[16]}]
set_output_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {out_clocked[17]}]
set_output_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {out_clocked[1]}]
set_output_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {out_clocked[2]}]
set_output_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {out_clocked[3]}]
set_output_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {out_clocked[4]}]
set_output_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {out_clocked[5]}]
set_output_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {out_clocked[6]}]
set_output_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {out_clocked[7]}]
set_output_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {out_clocked[8]}]
set_output_delay 2.0000 -clock [get_clocks {clock}] -add_delay [get_ports {out_clocked[9]}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {out_clocked[17]}]
set_load -pin_load 0.0334 [get_ports {out_clocked[16]}]
set_load -pin_load 0.0334 [get_ports {out_clocked[15]}]
set_load -pin_load 0.0334 [get_ports {out_clocked[14]}]
set_load -pin_load 0.0334 [get_ports {out_clocked[13]}]
set_load -pin_load 0.0334 [get_ports {out_clocked[12]}]
set_load -pin_load 0.0334 [get_ports {out_clocked[11]}]
set_load -pin_load 0.0334 [get_ports {out_clocked[10]}]
set_load -pin_load 0.0334 [get_ports {out_clocked[9]}]
set_load -pin_load 0.0334 [get_ports {out_clocked[8]}]
set_load -pin_load 0.0334 [get_ports {out_clocked[7]}]
set_load -pin_load 0.0334 [get_ports {out_clocked[6]}]
set_load -pin_load 0.0334 [get_ports {out_clocked[5]}]
set_load -pin_load 0.0334 [get_ports {out_clocked[4]}]
set_load -pin_load 0.0334 [get_ports {out_clocked[3]}]
set_load -pin_load 0.0334 [get_ports {out_clocked[2]}]
set_load -pin_load 0.0334 [get_ports {out_clocked[1]}]
set_load -pin_load 0.0334 [get_ports {out_clocked[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {clock}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {iterate_enable}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reset}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {write_enable}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {measurement[17]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {measurement[16]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {measurement[15]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {measurement[14]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {measurement[13]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {measurement[12]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {measurement[11]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {measurement[10]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {measurement[9]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {measurement[8]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {measurement[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {measurement[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {measurement[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {measurement[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {measurement[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {measurement[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {measurement[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {measurement[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[17]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[16]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[15]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[14]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[13]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[12]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[11]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[10]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[9]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[8]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_data[17]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_data[16]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_data[15]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_data[14]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_data[13]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_data[12]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_data[11]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_data[10]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_data[9]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_data[8]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_data[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_data[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_data[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_data[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_data[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_data[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_data[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_data[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {target[17]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {target[16]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {target[15]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {target[14]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {target[13]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {target[12]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {target[11]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {target[10]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {target[9]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {target[8]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {target[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {target[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {target[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {target[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {target[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {target[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {target[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {target[0]}]
###############################################################################
# Design Rules
###############################################################################
set_max_transition 0.7500 [current_design]
set_max_fanout 10.0000 [current_design]
