# Utility Scripts Documentation (Bash)

## Overview
This document provides detailed information about all utility Bash scripts in the `utility-scripts` folder. These scripts are designed to be sourced rather than executed directly, providing functions that can be called after sourcing.

## How to Use
Source the main.sh file to load all utility script functions:
```bash
source /path/to/utility-scripts/main.sh
```

Then call any of the functions described below.

## Scripts

### help.sh
* **Purpose**: Display help information for all available scripts
* **Function**: `help`
* **Usage**: `help`
* **Examples**:
  ```bash
  help
  ```
* **Notes**:
  - Displays a comprehensive list of all available commands and their descriptions

### count.sh
* **Purpose**: Count files by type in the current directory
* **Function**: `count_files`
* **Usage**: `count_files [directory] [options]`
* **Parameters**:
  - `directory`: Directory to count files in (optional, defaults to current directory)
  - `-recurse`: Count files recursively (optional)
  - `-ext <extension>`: Filter by file extension (optional)
  - `-pattern <pattern>`: Filter by file pattern (optional)
* **Examples**:
  ```bash
  count_files
  count_files /path/to/dir
  count_files -recurse
  count_files -ext js
  count_files -pattern "*.json"
  ```

### search.sh
* **Purpose**: Search for text in files
* **Function**: `search`
* **Usage**: `search <pattern> [options]`
* **Parameters**:
  - `pattern`: Text pattern to search for
  - `-path <path>`: Path to search in (optional, defaults to current directory)
  - `-ext <extension>`: Filter by file extension (optional)
  - `-ignorecase`: Ignore case in search (optional)
* **Examples**:
  ```bash
  search "function"
  search "import React" -ext js
  search "error" -path /logs -ignorecase
  ```

### reload.sh
* **Purpose**: Reload shell configuration
* **Function**: `reload_shell_config`
* **Usage**: `reload_shell_config`
* **Examples**:
  ```bash
  reload_shell_config
  ```
* **Notes**:
  - Reloads the bash configuration files

### common.sh
* **Purpose**: Provides common utility functions
* **Function**: `cls`
* **Usage**: `cls`
* **Examples**:
  ```bash
  cls
  ```
* **Notes**:
  - Clears the terminal screen (alias for clear)

### show-tree.sh
* **Purpose**: Display directory structure in a tree-like format
* **Function**: `show_tree`
* **Usage**: `show_tree [directory] [depth]`
* **Parameters**:
  - `directory`: Directory to show (optional, defaults to current directory)
  - `depth`: Maximum depth to display (optional)
* **Examples**:
  ```bash
  show_tree
  show_tree /path/to/dir
  show_tree /path/to/dir 3
  ```
