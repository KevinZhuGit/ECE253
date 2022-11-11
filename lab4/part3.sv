module part3 (clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
    input logic clock, reset, ParallelLoadn, RotateRight, ASRight;
    input logic [3:0] Data_IN;
    output logic [3:0] Q;

    logic c4, c3, c2, c1, x; // outputs of each register, x is variable connection

    subregister r4(clock, reset, Data_IN[3], ParallelLoadn, RotateRight, x, c3, c4); // when no .(), must follow input order
    subregister r3(clock, reset, Data_IN[2], ParallelLoadn, RotateRight, c4, c2, c3);
    subregister r2(clock, reset, Data_IN[1], ParallelLoadn, RotateRight, c3, c1, c2);
    subregister r1(clock, reset, Data_IN[0], ParallelLoadn, RotateRight, c2, c4, c1);
    
    always_comb
    begin
        if (RotateRight & ASRight & ParallelLoadn) x = c4;
        else x = c1;
    end

    assign Q = {c4, c3, c2, c1};
endmodule


module subregister (clock, reset, D, loadn, Loadleft, left, right, Q);
    input logic clock, reset, right, left, D, loadn, Loadleft;
    output logic Q;

    always_ff @(posedge clock)
    begin
        if (reset) Q <= 1'b0;
        else if (!loadn)
            Q <= D;
        else
            if (Loadleft) Q <= left;
            else Q <= right;
    end
endmodule