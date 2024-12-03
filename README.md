# Basys 3 FPGA Personal Timer

This project implements a personal timer on the Basys 3 FPGA board. It allows users to select from four different time settings (1 minute, 3 minutes, 5 minutes, and 7 minutes) and displays the countdown on a 7-segment display. The timer is controlled using three buttons for start, pause, and reset functionality. When the timer reaches zero, a section of lights will blink to indicate that the timer has finished.

## Features

- **Four Timer Settings:** Choose from 1 minute, 3 minutes, 5 minutes, or 7 minutes.
- **7-Segment Display:** Displays the countdown time in minutes and seconds (e.g., "05:00" for the 5-minute timer).
- **Button Controls:** 
  - **Start Button:** Starts the countdown timer.
  - **Pause Button:** Pauses the timer at any point.
  - **Reset Button:** Resets the timer to "00:00".
- **Visual Alerts:** When the timer ends, a section of lights blinks to signal completion.

## How to Use

1. **Select Timer Duration:**
   - Use the switches on the Basys 3 FPGA board to select one of the four timer durations (1 minute, 3 minutes, 5 minutes, or 7 minutes).
   
2. **Start the Timer:**
   - Press the "Start" button to begin the countdown. The 7-segment display will show the selected time (e.g., "05:00" for the 5-minute timer).
   
3. **Pause the Timer:**
   - Press the "Pause" button to pause the timer. Press "Start" again to resume the countdown.

4. **Reset the Timer:**
   - Press the "Reset" button to reset the timer to "00:00".

5. **Timer Completion:**
   - When the timer reaches zero, a section of lights on the FPGA board will blink to indicate that the timer has finished.

## Hardware Requirements

- **Basys 3 FPGA Board**
- **7-Segment Display**
- **Switches for timer settings**
- **Buttons for start, pause, and reset**

## How It Works

This project uses VHDL/Verilog code to control the timer logic on the Basys 3 FPGA. The timer countdown is driven by the clock on the FPGA, with the 7-segment display showing the time in a minutes:seconds format. The timer's behavior is controlled by three buttons (start, pause, and reset) and four switches for selecting the timer duration. When the timer finishes, the FPGA activates a section of lights to signal completion.

## Conclusion

This project was a fun and practical way to apply FPGA design skills, demonstrating how to use switches, buttons, and displays to create a functional personal timer. It helped me learn how to interface various components of the Basys 3 FPGA board and manage time-based logic effectively.
