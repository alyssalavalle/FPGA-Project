`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2024 04:50:00 PM
// Design Name: 
// Module Name: timer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module timer(
    input clk,                    // FPGA clock signal, 100 MHz
    input IO_BTN_C, IO_BTN_L, IO_BTN_R, // Control buttons: Start, Reset, Pause
    input [2:0] IO_SWITCH,        // Switch inputs for timer presets
    output wire [6:0] IO_SSEG,     // 7-segment display segments (changed to wire)
    output wire [3:0] IO_SSEG_SEL, // 7-segment display select signals (changed to wire)
    output reg [15:0] IO_LED      // LEDs for blinking
);

    reg [31:0] counter = 0;
    reg [31:0] blink_counter = 0; // Counter for blinking LEDs
    parameter max_counter = 100000000; // 1 Hz clock for countdown
    parameter blink_rate = 25000000;   // Blink rate ~4 Hz (250ms on/off)

    reg [5:0] Minutes = 0, Seconds = 0;
    reg [3:0] Digit_0, Digit_1, Digit_2, Digit_3 = 0;
    reg [1:0] timer_state = 0; // 0: Paused, 1: Running, 2: Reset
    reg [1:0] next_state = 0;  // State for blinking after timer is done
    reg blink_enable = 0;      // Enable blinking when timer ends

    sev_seg U00(
        .clk(clk),
        .binary_input_0(Digit_0),
        .binary_input_1(Digit_1),
        .binary_input_2(Digit_2),
        .binary_input_3(Digit_3),
        .IO_SSEG_SEL(IO_SSEG_SEL), // Use wire for the output
        .IO_SSEG(IO_SSEG)          // Use wire for the output
    );

    // Timer States
    always @(posedge clk) begin
        case (timer_state)
            // Reset Timer
            2'b00: begin
                if (IO_BTN_L) begin
                    timer_state <= 2'b00; // Stay in reset
                end else if (IO_BTN_C) begin
                    timer_state <= 2'b01; // Start countdown
                end
                
                if (IO_SWITCH[0]) begin
                    Minutes <= 1; Seconds <= 0;
                end else if (IO_SWITCH[1]) begin
                    Minutes <= 3; Seconds <= 0;
                end else if (IO_SWITCH[2]) begin
                    Minutes <= 5; Seconds <= 0;
                end else begin
                    Minutes <= 0; Seconds <= 0;
                end
                
                IO_LED <= 16'b0; // Reset LEDs
                blink_enable <= 0; // Disable blinking
            end

            // Running Timer (Countdown)
            2'b01: begin
                if (IO_BTN_R) begin
                    timer_state <= 2'b10; // Pause the timer
                end else if (IO_BTN_L) begin
                    timer_state <= 2'b00; // Reset the timer
                end else if (counter < max_counter) begin
                    counter <= counter + 1;
                end else begin
                    counter <= 0;
                    if (Seconds > 0) begin
                        Seconds <= Seconds - 1;
                    end else if (Minutes > 0) begin
                        Minutes <= Minutes - 1;
                        Seconds <= 59;
                    end else begin
                        timer_state <= 2'b11; // Transition to blinking state when timer ends
                    end
                end
            end

            // Paused Timer (Hold current state)
            2'b10: begin
                if (IO_BTN_C) begin
                    timer_state <= 2'b01; // Resume countdown
                end else if (IO_BTN_L) begin
                    timer_state <= 2'b00; // Reset timer
                end
            end

            // Blinking State (After Timer Ends)
            2'b11: begin
                if (IO_BTN_L) begin
                    timer_state <= 2'b00; // Reset the timer
                    IO_LED <= 16'b0; // Reset LEDs when the timer is reset
                end else begin
                    // Blinking logic
                    if (blink_counter < blink_rate) begin
                        blink_counter <= blink_counter + 1;
                    end else begin
                        blink_counter <= 0;
                        IO_LED <= ~IO_LED; // Toggle LEDs on/off
                    end
                end
            end
        endcase

        // Display update logic (for showing current time on the display)
        Digit_0 <= Seconds % 10;
        Digit_1 <= Seconds / 10;
        Digit_2 <= Minutes % 10;
        Digit_3 <= Minutes / 10;
    end
endmodule




