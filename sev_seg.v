`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2024 04:51:35 PM
// Design Name: 
// Module Name: sev_seg
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


module sev_seg(
    input clk,
    input [3:0] binary_input_0,
    input [3:0] binary_input_1,
    input [3:0] binary_input_2,
    input [3:0] binary_input_3,
    output wire [3:0] IO_SSEG_SEL, // Change to wire (non-reg)
    output wire [6:0] IO_SSEG // Change to wire as well (non-reg)
);

    reg [1:0] current_LED = 0; // Current LED to display (0 to 3)
    reg [6:0] LED_out [0:3];  // Array of LED outputs
    reg [18:0] counter = 0; // Counter for timing
    parameter max_counter = 500000; // Maximum counter value for timing

    wire [3:0] four_bit_data [0:3];  // Wire array for input data
    assign four_bit_data[0] = binary_input_0;
    assign four_bit_data[1] = binary_input_1;
    assign four_bit_data[2] = binary_input_2;
    assign four_bit_data[3] = binary_input_3;

    always @(posedge clk) begin
        if (counter < max_counter) begin
            counter <= counter + 1;
        end else begin
            counter <= 0;
            current_LED <= current_LED + 1;
        end
    
        case (four_bit_data[current_LED])
            4'b0000: LED_out[current_LED] = 7'b1000000; // 0
            4'b0001: LED_out[current_LED] = 7'b1111001; // 1
            4'b0010: LED_out[current_LED] = 7'b0100100; // 2
            4'b0011: LED_out[current_LED] = 7'b0110000; // 3
            4'b0100: LED_out[current_LED] = 7'b0011001; // 4
            4'b0101: LED_out[current_LED] = 7'b0010010; // 5
            4'b0110: LED_out[current_LED] = 7'b0000010; // 6
            4'b0111: LED_out[current_LED] = 7'b1111000; // 7
            4'b1000: LED_out[current_LED] = 7'b0000000; // 8
            4'b1001: LED_out[current_LED] = 7'b0011000; // 9
        endcase
    end

    // Continuous assignment for IO_SSEG_SEL
    assign IO_SSEG_SEL = (current_LED == 2'b00) ? 4'b1110 :
                         (current_LED == 2'b01) ? 4'b1101 :
                         (current_LED == 2'b10) ? 4'b1011 :
                         4'b0111;  // For current_LED == 2'b11

    // Continuous assignment for IO_SSEG
    assign IO_SSEG = LED_out[current_LED];

endmodule


