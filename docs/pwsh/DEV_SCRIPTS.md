# Development Scripts Documentation

This document provides detailed information about the development utility scripts in the `dev-scripts` directory.

## Scripts

### build
* **Purpose**: Builds a Node.js project using the preferred package manager (pnpm, npm, or yarn)
* **Usage**: `build`
* **Behavior**:
  - Checks for `package.json` and `node_modules` directory
  - Verifies the existence of a `build` script in `package.json`
  - Automatically detects and uses the available package manager in this order:
    1. pnpm
    2. npm
    3. yarn
  - Executes the build command with appropriate package manager

* **Prerequisites**:
  - Node.js installed
  - At least one of: pnpm, npm, or yarn installed
  - `package.json` with a `build` script
  - `node_modules` directory (run `npm install` or equivalent first)

* **Examples**:
  ```powershell
  # In a Node.js project directory
  build
  ```

* **Notes**:
  - Provides color-coded output for better visibility
  - Automatically removes itself after execution (lazy loading)
  - Shows helpful error messages if requirements are not met

### dev
* **Purpose**: Starts the development server for a Node.js project with optional Turbo Mode
* **Usage**: `dev [-Turbo]`
* **Parameters**:
  - `-Turbo`: (Optional) Enables Next.js Turbo Mode for faster development builds

* **Behavior**:
  - Checks for `package.json` and `node_modules` directory
  - Verifies the existence of a `dev` script in `package.json`
  - Supports multiple package managers (pnpm, npm, yarn)
  - Enables Next.js Turbo Mode when `-Turbo` flag is used
  - Automatically cleans up environment variables after execution

* **Prerequisites**:
  - Node.js installed
  - At least one of: pnpm, npm, or yarn installed
  - `package.json` with a `dev` script
  - `node_modules` directory (run `npm install` or equivalent first)

* **Examples**:
  ```powershell
  # Start development server
  dev
  
  # Enable Turbo Mode (for Next.js projects)
  dev -Turbo
  ```

* **Notes**:
  - Color-coded output for better visibility
  - Automatically removes itself after execution (lazy loading)
  - Shows helpful error messages if requirements are not met
  - Turbo Mode sets `NEXT_EXPERIMENTAL_TURBOPACK=true` environment variable

### install-pkg
* **Purpose**: Installs Node.js packages using the preferred package manager (pnpm, npm, or yarn)
* **Usage**: `install-pkg [<PackageNames>]`
* **Parameters**:
  - `PackageNames`: (Optional) One or more package names to install. If omitted, installs all dependencies from package.json

* **Behavior**:
  - Detects and uses the available package manager in this order: pnpm → npm → yarn
  - Installs all project dependencies if no package names are provided
  - Installs specified packages as dev dependencies if package names are provided
  - Provides color-coded output for better visibility

* **Prerequisites**:
  - Node.js installed
  - At least one of: pnpm, npm, or yarn installed
  - `package.json` in the current directory (for installing all dependencies)

* **Examples**:
  ```powershell
  # Install all project dependencies
  install-pkg
  
  # Install specific packages
  install-pkg react react-dom
  install-pkg -PackageNames @("typescript", "@types/node")
  
  # Install development dependencies
  install-pkg -D eslint prettier
  ```

* **Notes**:
  - Automatically removes itself after execution (lazy loading)
  - Shows helpful error messages if requirements are not met
  - Uses the equivalent of `npm install` or `yarn install` when no packages are specified
  - Uses `add` for pnpm/yarn and `install` for npm when packages are specified

### lint-fix
* **Purpose**: Runs the `lint:fix` script from package.json to automatically fix linting issues
* **Usage**: `lint:fix`
* **Behavior**:
  - Checks for `package.json` and `node_modules` directory
  - Verifies the existence of a `lint:fix` script in `package.json`
  - Supports both pnpm and npm package managers
  - Provides color-coded output for better visibility

* **Prerequisites**:
  - Node.js installed
  - At least one of: pnpm or npm installed
  - `package.json` with a `lint:fix` script
  - Required linting dependencies (e.g., eslint, stylelint) installed

* **Examples**:
  ```powershell
  # Fix linting issues in the current project
  lint:fix
  ```

* **Notes**:
  - Automatically removes itself after execution (lazy loading)
  - Shows helpful error messages if requirements are not met
  - Uses `pnpm run lint:fix` if pnpm is available, falls back to `npm run lint:fix`
  - The colon in the function name (`lint:fix`) matches the common npm script naming convention

### main
* **Purpose**: Entry point that loads all development scripts
* **Behavior**:
  - Sources (dot-sources) all individual dev scripts to make their functions available
  - Loads the following scripts in order:
    1. `dev.ps1` - Development server commands
    2. `build.ps1` - Build commands
    3. `lint-fix.ps1` - Linting utilities
    4. `install-pkg.ps1` - Package management

* **Usage**:
  This script is automatically sourced when the PowerShell profile loads (if configured).
  It makes all development commands available in your shell.

* **Notes**:
  - This is a configuration file, not a command to be run directly
  - Ensures all dev utilities are available in the current PowerShell session
  - Follows the lazy-loading pattern for better shell startup performance
  - The order of script loading determines the availability of functions

## Summary of All Development Scripts

| Command | Description | Example |
|---------|-------------|---------|
| `dev` | Start development server | `dev -Turbo` |
| `build` | Build the project | `build` |
| `lint:fix` | Fix linting issues | `lint:fix` |
| `install-pkg` | Install packages | `install-pkg react` |

This completes the documentation for all development scripts in the repository.
