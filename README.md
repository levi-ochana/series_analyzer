# Series Analyzer

## Overview

The Series Analyzer is a Bash script designed to perform various statistical analyses on a series of positive numbers.
It supports both command-line and interactive input and provides essential statistics such as maximum, minimum, average, count, and sum.

## Features
- Input a series via command line or interactive prompt.
- Validate input to ensure it consists of positive integers with a minimum of three numbers.
- Display series in original or sorted order.
- Calculate and display max, min, average, count, and sum of the series.

## Getting Started

### Prerequisites
- Bash (typically available by default on Linux and MacOS; Windows users can use WSL or Git Bash).

### Installation
1. Clone the repository:
    ```bash
   git clone https://github.com/levi-ochana/series_analyzer.git
   cd series_analyzer
2. Make the script executable:
    ```bash
    chmod +x series_analyzer.sh

### Usage
  #### Running the script without arguments:
    ```bash
   ./series_analyzer.sh
 #### Or running the script with arguments:
    ```bash
   ./series_analyzer.sh 5 10 15 20

### Code Structure
 validate(): Validates individual numbers.
 validate_series(): Ensures the series consists of valid numbers.
 display_menu(): Shows the menu options.
 handle_menu_choice(): Processes user choices from the menu.
 Series_Analyzer(): The main function that drives the script

