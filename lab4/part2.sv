module part2(Clock, Reset_b, Data, Function, ALUout);
    input logic Clock, Reset_b;
    input logic [1:0] Function;
    input logic [3:0] Data;
    output logic [7:0] ALUout;


    always_ff @(posedge Clock)
    begin 
        if (Reset_b) ALUout <= 8'b0; // active high reset
        else
            begin
                case (Function)

                0: ALUout <= Data + ALUout[3:0]; // <= or =????
                1: ALUout <= Data * ALUout[3:0];
                2: ALUout <= ALUout[3:0] << Data;
                3: ALUout <= ALUout;

                default ALUout <= ALUout;
                endcase
            end
    end

endmodule
    

// current behaviour for 2, will bit shift to num greater than 4'b
// for behaviour 2, does the other stuff shift as well????

// 01101111 << A    ->     10111100
// 1111 << 2   -> 00111100


// HOW TO USE FORCE
// ex:    force Function 00, 11 17ns, 00 33ns

// IF WANT TO use 00 {x ns} pairs, need to have ( , ) between each
