## TakToe Game

TakToe is a strategic game that combines elements of Takuzu and Tic Tac Toe. It provides a unique and engaging gameplay experience where players aim to align three of their chosen color — Orange or Black — along the 3x3 grid.

### Features

- Three grid sizes: Small, Regular, and Large.
- Strategic gameplay with winning conditions in rows, columns, and diagonals.
- Reset the game by pressing space.

### Prerequisites

- Pharo 11.0 

### Installation

1. Clone the repository:

   git clone https://github.com/nadiaames/GameProject
   
2. Load the required packages.

### Usage

1. Launch the game:

   ```
   TakToe open.
   ```

or with different grid sizes:

   ```
   TakFieldElement launchSmall.
   TakFieldElement launchRegular.
   TakFieldElement launchLarge.
   ```

2. Click on the boxes to make moves.

3. Press space to reset the game.

### Acknowledgments

- Inspired by Takuzu and Tic Tac Toe games.
- Built with the Pharo programming language.

### Difficulties Report

The game logic is designed to display the two messages when a player wins or when the game ends in a draw. However, despite thorough troubleshooting and debugging, we have not been able to identify the root cause of the problem.

### Troubleshooting Efforts

We have taken the following steps to address the issue:

- Verified the correctness of winning conditions.
- Ensured the correct invocation of the method responsible for checking for a winner after each move.
- Introduced debugging statements and inspected variable values during runtime.
- Checked and updated the logic for determining a draw when the board is full.
- Modified the method responsible for displaying the winner message.
