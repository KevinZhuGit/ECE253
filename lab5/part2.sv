module part2 #(parameter CLOCK_FREQUENCY = 500)(ClockIn, Reset, Speed, CounterValue);
    input logic ClockIn, Reset;
    input logic [1:0] Speed;
    output logic [3:0] CounterValue;

    logic c1;

    RateDivider u1(ClockIn, Reset, Speed, c1);

    DisplayCounter u2(ClockIn, Reset, c1, CounterValue);

endmodule



module RateDivider #(parameter CLOCK_FREQUENCY = 500)(ClockIn, Reset, Speed, Enable);
    input logic ClockIn, Reset;
    input logic [1:0] Speed;
    output logic Enable;
    
    logic [$clog2(4*CLOCK_FREQUENCY):0] Counter;    // set sizing


    always_ff @(posedge ClockIn)
    begin
        if (Reset)
            Counter <= 0;
        else if (!Counter)
            begin
                case (Speed)
                0: Counter <= 0;
                1: Counter <= CLOCK_FREQUENCY - 1;
                2: Counter <= 2 * CLOCK_FREQUENCY - 1;
                3: Counter <= 4 * CLOCK_FREQUENCY - 1;
                endcase
            end
        else
            Counter <= Counter - 1; 
    end
    
    assign Enable = (Counter == 'b0)?'1:'0;
endmodule


module DisplayCounter (Clock, Reset, EnableDC, CounterValue);
    input logic Clock, Reset, EnableDC;
    output logic [3:0] CounterValue;

    always_ff @(posedge Clock)
    begin
        if (Reset)
            CounterValue <= 0;
        else if (EnableDC == 0)
            CounterValue <= CounterValue;
        else if (CounterValue == 15)
            CounterValue <= 0;
        else
            CounterValue <= CounterValue + 1;
    end

endmodule


