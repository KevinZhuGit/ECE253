# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part1.sv

#load simulation using mux as the top level simulation module
vsim part1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

#test cases
#set input values using the force command, signal names need to be in {} brackets

force {Clock} 0, 1 {5ns} -r {10ns}
force {Reset} 1, 0 10ns
force {Enable} 1, 0 120ns

run 200 ns