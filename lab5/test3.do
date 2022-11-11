# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part3.sv

#load simulation using mux as the top level simulation module
vsim part3

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

#test cases
#set input values using the force command, signal names need to be in {} brackets

force {ClockIn} 1, 0 {62.5ms} -r {125ms}
force {Reset} 1, 0 130ms
force {Start} 0, 1 1050ms, 0 1200ms, 1 10050ms, 0 10200ms
force {Letter} 010, 000 10000ms

run 17000 ms