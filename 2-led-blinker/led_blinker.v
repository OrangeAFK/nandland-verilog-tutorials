// input clock is 25 kHz, and the led should be able to blink at 50% duty cycle
// at 1, 10, 50, or 100 Hz based on input

module led_blinker(
    input i_clock, i_enable, i_switch1, i_switch2,
    output o_led_drive
);

    // counters
    reg [31:0] r_CNT_100HZ = 0;
    reg [31:0] r_CNT_50HZ = 0;
    reg [31:0] r_CNT_10HZ = 0;
    reg [31:0] r_CNT_1HZ = 0;

    // constant counting thresholds for 50% duty cycle
    // toggle formula is 0.5 * input clock speed / output blink frequency
    parameter c_CNT_100HZ = 125;
    parameter c_CNT_50HZ = 250;
    parameter c_CNT_10HZ = 1250;
    parameter c_CNT_1HZ = 12500;

    // These signals will toggle at the frequencies needed:
    reg        r_TOGGLE_100HZ = 1'b0;
    reg        r_TOGGLE_50HZ  = 1'b0;
    reg        r_TOGGLE_10HZ  = 1'b0;
    reg        r_TOGGLE_1HZ   = 1'b0;

    // One bit select
    reg        r_LED_SELECT;
    wire       w_LED_SELECT;

begin
    // 100 Hz process
    always @ (posedge i_clock)
        begin
        if (r_CNT_100HZ == c_CNT_100HZ-1) // -1, since counter starts at 0
            begin        
            r_TOGGLE_100HZ <= !r_TOGGLE_100HZ;
            r_CNT_100HZ    <= 0;
            end
        else
            r_CNT_100HZ <= r_CNT_100HZ + 1;
        end
    
    // 50 Hz process
    always @ (posedge i_clock)
        begin
        if (r_CNT_50HZ == c_CNT_50HZ-1) // -1, since counter starts at 0
            begin        
            r_TOGGLE_50HZ <= !r_TOGGLE_50HZ;
            r_CNT_50HZ    <= 0;
            end
        else
            r_CNT_50HZ <= r_CNT_50HZ + 1;
        end
    
    // 10 Hz process
    always @ (posedge i_clock)
        begin
        if (r_CNT_10HZ == c_CNT_10HZ-1) // -1, since counter starts at 0
            begin        
            r_TOGGLE_10HZ <= !r_TOGGLE_10HZ;
            r_CNT_10HZ    <= 0;
            end
        else
            r_CNT_10HZ <= r_CNT_10HZ + 1;
        end
    
    // 1 Hz process
    always @ (posedge i_clock)
        begin
        if (r_CNT_1HZ == c_CNT_1HZ-1) // -1, since counter starts at 0
            begin        
            r_TOGGLE_1HZ <= !r_TOGGLE_1HZ;
            r_CNT_1HZ    <= 0;
            end
        else
            r_CNT_1HZ <= r_CNT_1HZ + 1;
        end

    // mux based on switch inputs
    always @(*)
    begin
        case ({i_switch1, i_switch2})
            2'b11 : r_LED_SELECT <= r_TOGGLE_1HZ;
            2'b10 : r_LED_SELECT <= r_TOGGLE_10HZ;
            2'b01 : r_LED_SELECT <= r_TOGGLE_50HZ;
            2'b00 : r_LED_SELECT <= r_TOGGLE_100HZ;
        endcase
    end

    assign o_led_drive = r_LED_SELECT & i_enable;

end

endmodule