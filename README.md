# PowerShell Custom Scripts

A collection of PowerShell scripts to enhance your development workflow with useful commands and shortcuts.

## 📋 Table of Contents
- [Features](#-features)
- [Setup](#-setup)
- [Documentation](#-documentation)
- [Script Categories](#-script-categories)
- [Requirements](#-requirements)
- [Contributing](#-contributing)

## ✨ Features

- **Lazy loading**: Commands load only when first used
- **Consistent interface**: Standardized parameter names and help
- **Cross-platform**: Works on Windows, macOS, and Linux
- **Documentation**: Comprehensive help and examples for all commands

## 🚀 Setup

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
