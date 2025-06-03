# Utility Scripts Documentation

This document provides detailed information about the utility scripts in the `utility-scripts` directory.

## Scripts

### common
* **Purpose**: Configures PowerShell's command line interface with enhanced usability features
* **Behavior**:
  - Enables tab completion with a navigable menu
  - Configures arrow keys for history navigation
  - Enables command prediction based on history
  - Shows tooltips for better command discovery

* **Features**:
  - `Tab` key: Shows a navigable menu of all available commands/options
  - `UpArrow`/`DownArrow`: Search through command history
  - Command prediction shows likely completions based on history
  - Tooltips provide additional context for commands

* **Notes**:
  - This script runs automatically when the utility scripts are loaded
  - Enhances the default PowerShell command line experience
  - No direct interaction is needed as it modifies shell behavior
  - Changes are applied to the current PowerShell session only

### count
* **Purpose**: Counts files in a directory tree with flexible filtering options
* **Usage**: `count-file [options]`

* **Parameters**:
  - `-Help` : Show help message
  - `-avoidFolder <list>` : Exclude files in specified folders (comma-separated)
  - `-avoidFile <list>` : Exclude files with specified extensions (comma-separated)
  - `-onlyFolder <list>` : Only include files in specified folders (comma-separated)
  - `-onlyFile <list>` : Only include files with specified extensions (comma-separated)

* **Behavior**:
  - Recursively scans the current directory
  - Applies include/exclude filters based on parameters
  - Case-insensitive matching for all filters
  - Returns the total count of matching files

* **Examples**:
  ```powershell
  # Basic usage - count all files
  count-file
  
  # Exclude node_modules and .git folders
  count-file -avoidFolder 'node_modules', '.git'
  
  # Only count TypeScript and JavaScript files
  count-file -onlyFile 'ts', 'js', 'tsx', 'jsx'
  
  # Only count files in src directory
  count-file -onlyFolder 'src'
  
  # Combine multiple filters
  count-file -onlyFolder 'src' -onlyFile 'ts' -avoidFolder 'test', 'spec'
  ```

* **Notes**:
  - Defaults to counting all files in the current directory and subdirectories
  - Uses case-insensitive matching for all filters
  - Folder matching is done by path (e.g., 'node_modules' will match any folder named 'node_modules' in the path)
  - File extensions should be provided without leading dots

### help
* **Purpose**: Displays a comprehensive help menu for all custom scripts and commands
* **Usage**: `scripts [command]`

* **Commands**:
  - `scripts help` : Show the main help menu (default)
  - `scripts path` : Show the path to the scripts directory
  - `scripts update` : Update the custom scripts repository

* **Behavior**:
  - Displays a color-coded help menu organized by categories
  - Provides a quick reference for all available commands
  - Supports self-updating functionality
  - Automatically removes itself after execution (lazy loading)

* **Categories**:
  - **Git Operations**: commit, add, stash, pull, branch, status, etc.
  - **Working Branch Management**: Manage working branches across projects
  - **Development**: build, dev, install-pkg, lint:fix
  - **Utilities**: help, reload, search

* **Examples**:
  ```powershell
  # Show main help menu
  scripts
  scripts help
  
  # Update the scripts repository
  scripts update
  
  # Show scripts directory path
  scripts path
  ```

* **Notes**:
  - The help text is color-coded for better readability
  - Uses a clean, organized layout with command categories
  - Includes both basic and advanced commands
  - The `update` command will pull the latest changes and reload your profile

### reload
* **Purpose**: Reloads the PowerShell environment and disables screen reader announcements
* **Usage**: `reload`

* **Behavior**:
  - Disables screen reader announcements in the current session
  - Reloads the PSReadLine module to apply any configuration changes
  - Provides success/error feedback for each operation
  - Automatically removes itself after execution (lazy loading)

* **Features**:
  - **Screen Reader Control**: Uses Windows API to temporarily disable screen reader announcements
  - **Module Reload**: Refreshes PSReadLine to pick up any configuration changes
  - **Self-Cleaning**: Removes itself from memory after execution

* **Examples**:
  ```powershell
  # Reload the PowerShell environment
  reload
  ```

* **Notes**:
  - Only affects the current PowerShell session
  - Screen reader changes are temporary and only last for the current session
  - Requires administrative privileges to modify screen reader settings
  - Helpful after making changes to your PowerShell profile or PSReadLine settings

### search
* **Purpose**: Searches for files and folders with advanced filtering options
* **Usage**: `Search -Name <pattern> [-Path <path>] [-C] [-F] [-Type <File|Folder|Both>]`

* **Parameters**:
  - `-Name <string>` : (Required) Pattern to search for (supports regex)
  - `-Path <string>` : Directory to search in (default: current directory)
  - `-C` : Case-sensitive search
  - `-F` : Match whole words only
  - `-Type <File|Folder|Both>` : Type of items to search (default: Both)

* **Behavior**:
  - Recursively searches through directories
  - Supports regular expressions in the search pattern
  - Can search for files, folders, or both
  - Returns full paths of matching items
  - Automatically removes itself after execution (lazy loading)

* **Examples**:
  ```powershell
  # Basic search for a file or folder
  Search -Name "config"
  
  # Case-sensitive search for TypeScript files
  Search -Name "\.tsx?$" -C -Type File
  
  # Search for folders matching a pattern
  Search -Name "test" -Type Folder
  
  # Search for whole words only
  Search -Name "util" -F
  
  # Search in a specific directory
  Search -Name "readme" -Path "C:\Projects"
  ```

* **Notes**:
  - Uses regex for pattern matching by default (escape special characters if needed)
  - The `-F` flag adds word boundaries to match whole words only
  - Search is recursive by default
  - Returns full paths to make it easy to work with the results
  - Case-insensitive by default (use `-C` for case-sensitive search)

### show-tree
* **Purpose**: Displays a directory tree structure in a visually appealing format
* **Usage**: `show-tree [[-Path] <string>] [[-Exclude] <string[]>] [[-Indent] <int>]`

* **Parameters**:
  - `-Path <string>` : Starting directory path (default: current directory)
  - `-Exclude <string[]>` : Array of directory names to exclude from the tree
  - `-Indent <int>` : Number of spaces to indent each level (default: 0)

* **Behavior**:
  - Recursively scans directories and displays them in a tree structure
  - Uses Unicode box-drawing characters for visual clarity
  - Can exclude specific directories from the output
  - Maintains proper indentation for nested directories

* **Examples**:
  ```powershell
  # Show tree of current directory
  show-tree
  
  # Show tree starting from a specific directory
  show-tree -Path "C:\Projects"
  
  # Exclude node_modules and .git directories
  show-tree -Exclude "node_modules", ".git"
  
  # Custom indentation
  show-tree -Path "src" -Indent 2
  ```

* **Notes**:
  - Only displays directories (not files)
  - Uses UTF-8 box-drawing characters for the tree structure
  - Helpful for visualizing project structure
  - Can be combined with other commands using the pipeline
  - Case-sensitive exclusion matching

### main.ps1
* **Purpose**: Main entry point that loads all utility scripts
* **Behavior**:
  - Sources (dot-sources) all utility scripts to make their functions available
  - Loads scripts in the following order:
    1. `search.ps1` - Advanced file and folder search
    2. `reload.ps1` - Environment reloading utilities
    3. `common.ps1` - Common shell configurations
    4. `help.ps1` - Help system and documentation
    5. `count.ps1` - File counting with filters
    6. `show-tree.ps1` - Directory tree visualization

* **Usage**:
  This script is automatically sourced when the PowerShell profile loads (if configured).
  It makes all utility commands available in your shell.

* **Notes**:
  - This is a configuration file, not a command to be run directly
  - Ensures all utility commands are available in the current PowerShell session
  - Follows the lazy-loading pattern for better shell startup performance
  - The order of script loading determines the availability of functions

## Summary of All Utility Scripts

| Command | Description | Example |
|---------|-------------|---------|
| `Search` | Advanced file/folder search | `Search -Name "config" -Type File` |
| `reload` | Reload environment | `reload` |
| `scripts` | Show help | `scripts help` |
| `count-file` | Count files with filters | `count-file -avoidFolder 'node_modules'` |
| `show-tree` | Show directory tree | `show-tree -Exclude '.git'` |

This completes the documentation for all utility scripts in the repository.
[Additional documentation will be added after analyzing each script file]
