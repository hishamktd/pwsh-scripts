# PowerShell & Bash Custom Scripts

A collection of PowerShell **and** Bash scripts to enhance your development workflow with useful commands and shortcuts. Every PowerShell script has a corresponding Bash equivalent for cross-platform compatibility.

## 📋 Table of Contents

> **Note:** All scripts are available in both PowerShell (`*.ps1`) and Bash (`*.sh`). Use the version appropriate for your shell and OS.
- [Features](#-features)
- [Setup (PowerShell)](#-setup-powershell)
- [Setup (Bash)](#-setup-bash)
- [Documentation](#-documentation)
- [Script Categories](#-script-categories)
- [Requirements](#-requirements)
- [Contributing](#-contributing)

## ✨ Features

- **Lazy loading**: Commands load only when first used (PowerShell)
- **Consistent interface**: Standardized parameter names and help
- **Cross-platform**: Works on Windows, macOS, and Linux
- **Bash & PowerShell parity**: Every PowerShell script has a Bash equivalent with matching functionality
- **Documentation**: Comprehensive help and examples for all commands

## 🚀 Setup (PowerShell)

### Prerequisites
- PowerShell 7.0 or later
- Git (for version control)

### Installation

1. **Clone the repository**:
   ```powershell
   git clone https://github.com/yourusername/pwsh-scripts.git
   cd pwsh-scripts
   ```

2. **Add to your PowerShell profile**:
   Edit your PowerShell profile (`$PROFILE`) and add:
   ```powershell
   # Load custom scripts
   . C:\path\to\pwsh-scripts\main.ps1
   ```

3. **Reload your profile**:
   ```powershell
   . $PROFILE
   ```

4. **Verify installation**:
   ```powershell
   # List all available commands
   Get-Command -Module Scripts
   
   # Show help
   scripts help
   ```

## 🚀 Setup (Bash)

### Prerequisites
- Bash 4.0+ (Linux, macOS, or Windows with WSL/Git Bash)
- Git (for version control)

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/pwsh-scripts.git
   cd pwsh-scripts
   ```

2. **Add to your shell profile** (e.g., `~/.bashrc`, `~/.zshrc`):
   ```bash
   # Load custom Bash scripts
   source /path/to/pwsh-scripts/main.sh
   ```

3. **Reload your profile**:
   ```bash
   source ~/.bashrc
   # or for zsh
   source ~/.zshrc
   ```

4. **Verify installation**:
   ```bash
   # List available commands (see utility-scripts/help.sh for details)
   bash utility-scripts/help.sh
   ```

## 📚 Documentation

Detailed documentation is available in the `/docs/pwsh/` directory:

- [Git Scripts](docs/pwsh/GIT_SCRIPTS.md) - Version control commands
- [Development Scripts](docs/pwsh/DEV_SCRIPTS.md) - Build and development tools
- [Utility Scripts](docs/pwsh/UTILITY_SCRIPTS.md) - General purpose utilities

## 🗂 Script Categories

### Git Scripts
- `commit` - Stage and commit changes
- `push` - Push changes to remote
- `branch` - Manage branches
- `status` - Enhanced git status
- And more...

### Development Scripts
- `build` - Build projects
- `dev` - Start development server
- `install-pkg` - Package management
- `lint:fix` - Fix linting issues

### Utility Scripts
- `search` - Advanced file search
- `show-tree` - Directory tree visualization
- `count-file` - Count files with filters
- `reload` - Reload environment

## ⚙ Requirements

See [REQUIREMENTS.md](REQUIREMENTS.md) for detailed development and documentation standards.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Update documentation
5. Submit a pull request

Please read our [Contribution Guidelines](CONTRIBUTING.md) before submitting changes.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

💡 **Tip**: Run `scripts help` to see all available commands and their usage.
