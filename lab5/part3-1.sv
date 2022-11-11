// test clock speed of 0.5Hz

module part3 #(parameter CLOCK_FREQUENCY=8)(ClockIn, Reset, Start, Letter, DotDashOut, NewBitOut);
    input logic ClockIn, Reset, Start;
    input logic [2:0] Letter; // specifies which letter
    output logic DotDashOut, NewBitOut;

    logic enable, on, Q, load;

    always_ff @(posedge ClockIn)
    begin
        if (Reset)
            on <= 0;
        else if (Start)
            begin
            on <= 1;
            load <= 1;
            end
        else if (Q) 
            on <= 0;  
        else if (enable)
            load <= 0;
    end

    // should make it possibly reset with Start as well?

    RateDivider u1(ClockIn, on, enable);

    NewBitOutCounter u2 (ClockIn, enable, Reset, Q);

    shiftreg u3 (enable, load, Letter, DotDashOut);


    assign NewBitOut = enable;
    
endmodule


module RateDivider #(parameter CLOCK_FREQUENCY = 8)(ClockIn, On, Enable);
    input logic ClockIn, On;
    output logic Enable;
    
    logic [$clog2(CLOCK_FREQUENCY/2):0] Counter;


    always_ff @(posedge ClockIn)
    begin
        if (!On)
            Counter <= (CLOCK_FREQUENCY / 2) - 1;
        else if (!Counter)
            Counter <= (CLOCK_FREQUENCY / 2) - 1;
        else
            Counter <= Counter - 1; 
    end
    
    assign Enable = (Counter == 'b0)?'1:'0;
endmodule


module NewBitOutCounter (Clock, Enable, Reset, Q);
    input logic Clock, Enable, Reset;
    output logic Q;

    logic [3:0] Counter;

    always_ff @(posedge Clock)
    begin
        if (Reset)
            begin
                Counter <= 0;
                Q <= 0;
            end
        else if (Counter == 12)
            Q <= 1;
        else if (Enable)
            Counter <= Counter + 1;
    end
endmodule


module shiftreg (Clock, Load, Letter, Q);
    input logic Clock, Load;
    input logic [3:0] Letter;
    output logic Q;

    logic [11:0] signal;

    always_ff @(posedge Clock)
    begin
        if (Load)
            begin
            case (Letter)
            0: signal <= 12'b101110000000;
            1: signal <= 12'b111010101000;
            2: signal <= 12'b111010111010;
            3: signal <= 12'b111010100000;
            4: signal <= 12'b100000000000;
            5: signal <= 12'b101011101000;
            6: signal <= 12'b111011101000;
            7: signal <= 12'b101010100000;
            endcase
            end
        else
            signal <= signal << 1; 
    end

    assign Q = signal[11];
endmodule