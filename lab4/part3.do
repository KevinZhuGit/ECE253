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

force clock 0, 1 5ns -r 10ns
force reset 1, 0 7ns
force Data_IN 1010
force ASRight 1
force ParallelLoadn 0 12ns
force RotateRight 1


run 100 ns