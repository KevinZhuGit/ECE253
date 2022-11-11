module part1(Clock, Enable, Reset, CounterValue);
    input logic Clock, Enable, Reset;
    output logic [7:0] CounterValue;

    logic q0, q1, q2, q3, q4, q5, q6, q7;
    logic c0, c1, c2, c3, c4, c5, c6;


    tflip p0(Clock, Reset, Enable, q0);
    tflip p1(Clock, Reset, c0, q1);
    tflip p2(Clock, Reset, c1, q2);
    tflip p3(Clock, Reset, c2, q3);
    tflip p4(Clock, Reset, c3, q4);
    tflip p5(Clock, Reset, c4, q5);
    tflip p6(Clock, Reset, c5, q6);
    tflip p7(Clock, Reset, c6, q7);

    always_comb
    begin
        c0 = Enable & q0;
        c1 = c0 & q1;
        c2 = c1 & q2;
        c3 = c2 & q3;
        c4 = c3 & q4;
        c5 = c4 & q5;
        c6 = c5 & q6;
    end

    assign CounterValue = {q7, q6, q5, q4, q3, q2, q1, q0};
endmodule


module tflip(Clock, Reset, In, Q);
    input logic Clock, Reset, In;
    output logic Q;

    always_ff @(posedge Clock)
    begin
        if (Reset)
            Q <= 0;
        else
            Q <= Q ^ In;
    end

endmodule