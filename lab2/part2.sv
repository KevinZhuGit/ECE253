`timescale 1ns / 1ns // `timescale time_unit/time_precision

module mux2to1(x, y, s, m);
    input logic x; //select 0
    input logic y; //select 1
    input logic s; //select signal
    output logic m; //output
	
	logic not_s, output1, output2;
	
	// not gate
	v7404 u0(.pin1(s), .pin2(not_s));
	
	// and gate
	v7408 u1(.pin1(x), .pin2(not_s), .pin3(output1), .pin4(s), .pin5(y), .pin6(output2));
	
	// or gate
	v7432 u2(.pin1(output1), .pin2(output2), .pin3(m));

endmodule

// Inverter
module v7404 (pin1, pin3, pin5, pin9, pin11, pin13,pin2, pin4, pin6, pin8, pin10, pin12);
	input logic pin1, pin3, pin5, pin9, pin11, pin13;
	output logic pin2, pin4, pin6, pin8, pin10, pin12;
	
	assign pin2 = ~pin1;
	assign pin4 = ~pin3;
	assign pin6 = ~pin5;
	assign pin8 = ~pin9;
	assign pin10 = ~pin11;
	assign pin12 = ~pin13;
endmodule

// Quad 2-input AND
module v7408 (pin1, pin3, pin5, pin9, pin11, pin13,pin2, pin4, pin6, pin8, pin10, pin12);
	input logic pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13;
	output logic pin3, pin6, pin8, pin11;
	
	assign pin3 = pin1 & pin2;
	assign pin6 = pin4 & pin5;
	assign pin8 = pin9 & pin10;
	assign pin11 = pin12 & pin13;
endmodule

// Quad 2-input OR
module v7432 (pin1, pin3, pin5, pin9, pin11, pin13,pin2, pin4, pin6, pin8, pin10, pin12);
	input logic pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13;
	output logic pin3, pin6, pin8, pin11;
	
	assign pin3 = pin1 | pin2;
	assign pin6 = pin4 | pin5;
	assign pin8 = pin9 | pin10;
	assign pin11 = pin12 | pin13;
endmodule