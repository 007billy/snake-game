# Snake Game on FPGA (Verilog)

This project implements the classic Snake game on an FPGA using Verilog. The snake is controlled using the buttons on the Spartan-3E FPGA board, and the game is displayed on a VGA monitor.

## Table of Contents
- [Overview](#overview)
- [Project Structure](#project-structure)
- [Requirements](#requirements)
- [Setup Instructions](#setup-instructions)
- [How to Play](#how-to-play)
- [License](#license)

## Overview

The Snake game on FPGA is a simple arcade-style game where the player controls a snake to collect apples and avoid hitting the walls. The snake changes direction using the buttons on the Spartan-3E FPGA board.

- The snake moves by default from left to right at the start of the game.
- If the snake hits a wall, the game ends.
- The game can be restarted using the rotary button on the FPGA board.

## Project Structure

The project consists of a single main module that handles both the VGA display and the game logic:
- **Snake Game Module** (`zmija.v`): This module combines the functionality of VGA signal generation and game logic. It controls the movement of the snake, detects collisions, and manages game state (e.g., game over or reset).

### Files:
- `zmija.v`: The module that manages VGA signals for game display and contains the game logic, including snake movement, collision detection, and restart functionality.
- `zmija.ucf`: A pin assignment file for the Spartan-3E FPGA board, which connects variables and outputs to the corresponding pins on the board.

## Requirements

To run this project, you will need the following:
- **FPGA Board**: Spartan-3E FPGA development board.
- **VGA Monitor**: Connect the FPGA to a VGA monitor for game display.
- **Xilinx ISE**: To synthesize and load the design onto the FPGA board.

## Setup Instructions

1. **Clone the Repository**:
   Clone the repository to your local machine:
   ```bash
   git clone https://github.com/yourusername/snake-game-fpga.git
2. **Open the Project**:
    Open the project in Xilinx ISE and make sure all files are correctly included.
3. **Synthesize the Design**:
    Synthesize the project to generate the necessary bitstream file for the FPGA.
4. **Load the Design**:
    Load the synthesized design onto the Spartan-3E FPGA board.
5. **Connect the VGA Monitor**:
    Attach a VGA monitor to the board to display the game.

## How to play

Use the buttons on the Spartan-3E FPGA board to control the snake's direction.
    Button 1: Move Up
    Button 2: Move Down
    Button 3: Move Left
    Button 4: Move Right
The game starts with the snake moving from left to right.
If the snake hits a wall, the game is over.
To restart the game, use the rotary button on the FPGA board.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.


