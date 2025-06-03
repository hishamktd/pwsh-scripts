# Theme Scripts Documentation (Bash)

## Overview
This document provides detailed information about all theme-related Bash scripts in the `theme-scripts` folder. These scripts are designed to be sourced rather than executed directly, providing functions that can be called after sourcing.

## How to Use
Source the main.sh file to load all theme script functions:
```bash
source /path/to/theme-scripts/main.sh
```

Then call any of the functions described below.

## Scripts

### oh-my-posh.sh
* **Purpose**: Configure and enable Oh My Posh theme for Bash
* **Function**: `enable_oh_my_posh`
* **Usage**: `enable_oh_my_posh`
* **Examples**:
  ```bash
  enable_oh_my_posh
  ```
* **Notes**:
  - Initializes Oh My Posh with a specified theme configuration
  - Requires Oh My Posh to be installed on the system
  - Uses the theme file located in the theme-scripts/theme directory

### main.sh
* **Purpose**: Source all theme-related scripts
* **Usage**: Source this file to load all theme functions
* **Examples**:
  ```bash
  source /path/to/theme-scripts/main.sh
  ```
* **Notes**:
  - This script only sources other theme scripts and doesn't execute any commands automatically
  - After sourcing, all theme functions will be available to call directly
