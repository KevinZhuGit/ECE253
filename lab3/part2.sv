module part2(A, B, Function, ALUout);
    input logic [3:0] A,B;
	input logic [1:0] Function;
    output logic [7:0] ALUout;

	logic [3:0] sum,carry;

    RA u1(.a(A), .b(B), .c_in(0), .s(sum), .c_out(carry));

	

    always_comb
    begin
        case (Function)
        0: begin
			ALUout[7:5] = 3'b000;
            ALUout[4] = carry[3];
            ALUout[3:0] = sum;
        end

        1: ALUout = |{A, B};

        2: ALUout = &{A, B};

        3: ALUout = {A, B};

        default: ALUout = 8'b00000000;
        endcase
    end



endmodule



module RA(a, b, c_in, s, c_out);
    input logic [3:0] a,b;
	input logic c_in;
    output logic [3:0] s,c_out;
 
    logic c1, c2, c3;

    fulladder fa1(.a(a[0]), .b(b[0]), .c_in(c_in), .c_out(c1), .s(s[0]));

    fulladder fa2(.a(a[1]), .b(b[1]), .c_in(c1), .c_out(c2), .s(s[1]));

    fulladder fa3(.a(a[2]), .b(b[2]), .c_in(c2), .c_out(c3), .s(s[2]));
    
    fulladder fa4(.a(a[3]), .b(b[3]), .c_in(c3), .c_out(c_out[3]), .s(s[3]));

	assign c_out[0] = c1;
	assign c_out[1] = c2;
	assign c_out[2] = c3;

endmodule

module fulladder(a,b,c_in,c_out,s);
    input logic a,b,c_in;
    output logic c_out,s;
 
    assign s = a ^ b ^ c_in;
    assign c_out = (a&b) | (a&c_in) | (b&c_in);
           
endmodule