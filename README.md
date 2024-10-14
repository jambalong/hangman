# Hangman Game

This project is part of The Odin Project: [Hangman](https://www.theodinproject.com/lessons/ruby-hangman).

## Overview
This project implements a command-line version of the classic Hangman game where one player competes against the computer. The game randomly selects a secret word from a dictionary, and the player has to guess the word by suggesting letters within a limited number of incorrect guesses.

## Features
- **Word Selection:** The game loads a dictionary and randomly selects a word between 5 and 12 characters long.
- **Display:** The game displays the current state of the word with correctly guessed letters and placeholders for remaining letters.
- **Guess Tracking:** Players can see the letters they have already guessed and how many incorrect guesses remain.
- **Save/Load Functionality:** Players have the option to save their game at any turn and load a saved game upon restarting.

## How It Works
1. At the start of a new game, the dictionary is loaded, and a secret word is randomly selected.
2. The player is allowed to make guesses of letters, and the game updates the display accordingly.
3. The player has a limited number of incorrect guesses before losing the game.
4. Players can save their progress and load it later.

## Learning Objectives
This project demonstrates:
- Understanding of object-oriented programming principles.
- Implementation of game logic and algorithms.
- User input handling and file serialization for saving game states.
- Design patterns for creating interactive command-line applications.

## Installation
1. **Prerequisites:**
   - Ruby installed on your machine.

2. **Clone the Repository:**
   ```bash
   git clone https://github.com/yourusername/hangman.git
   cd hangman
   ```

3. **Run the Game:**
   ```bash
   ruby hangman.rb
   ```
