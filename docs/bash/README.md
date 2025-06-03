# Bash Scripts Documentation

## Overview
This documentation covers all Bash scripts in the custom-scripts repository. These scripts are designed to be sourced rather than executed directly, providing functions that can be called after sourcing.

## Script Categories

The scripts are organized into the following categories:

1. [Git Scripts](GIT_SCRIPTS.md) - Scripts for Git operations and repository management
2. [Utility Scripts](UTILITY_SCRIPTS.md) - General utility functions for everyday use
3. [Path Scripts](PATH_SCRIPTS.md) - Quick navigation to common directories
4. [Theme Scripts](THEME_SCRIPTS.md) - Shell theme configuration

## How to Use

All scripts follow a consistent pattern:

1. Each script defines one or more functions
2. No code is executed automatically when sourced
3. Functions can be called explicitly after sourcing

### Loading All Scripts

Source the main.sh file in each directory to load all scripts in that category:

```bash
# Load git scripts
source /path/to/git-scripts/main.sh

# Load utility scripts
source /path/to/utility-scripts/main.sh

# Load path scripts
source /path/to/path-scripts/main.sh

# Load theme scripts
source /path/to/theme-scripts/main.sh
```

### Environment Configuration

Many scripts use path definitions from the `.env` file at the root of the custom-scripts directory. See the [Path Scripts](PATH_SCRIPTS.md) documentation for details on the environment configuration.

## Function Naming Conventions

Functions follow these naming conventions:

- Git operations: Function names match the operation (e.g., `push`, `pull`, `revert`)
- Workspace navigation: Simple, descriptive names (e.g., `ws`, `kie`)
- Utility functions: Descriptive names (e.g., `count_files`, `search`)

## Adding New Scripts

When adding new scripts, follow these guidelines:

1. Place the script in the appropriate directory
2. Follow the function-only pattern (no auto-execution)
3. Add usage comments at the top of the file
4. Update the main.sh file in the directory to source your new script
5. Update the documentation in this directory
