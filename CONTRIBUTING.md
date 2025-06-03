# Contributing to PowerShell Custom Scripts

Thank you for your interest in contributing! This guide will help you get started with contributing to this project.

## 📋 Table of Contents
- [Code of Conduct](#-code-of-conduct)
- [Getting Started](#-getting-started)
- [Development Workflow](#-development-workflow)
- [Pull Request Process](#-pull-request-process)
- [Documentation](#-documentation)
- [Testing](#-testing)
- [Code Style](#-code-style)
- [Reporting Issues](#-reporting-issues)
- [Feature Requests](#-feature-requests)

## ✨ Code of Conduct

This project adheres to the [Contributor Covenant](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## 🚀 Getting Started

1. **Fork** the repository on GitHub
2. **Clone** your forked repository
   ```powershell
   git clone https://github.com/your-username/pwsh-scripts.git
   cd pwsh-scripts
   ```
3. **Set up** the development environment
   ```powershell
   # Install required modules
   Install-Module -Name PSScriptAnalyzer -Scope CurrentUser -Force
   ```

## 💻 Development Workflow

1. **Create a feature branch**
   ```powershell
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Follow the [REQUIREMENTS.md](REQUIREMENTS.md) for coding standards
   - Keep commits focused and atomic

3. **Test your changes**
   ```powershell
   # Run PSScriptAnalyzer
   Invoke-ScriptAnalyzer -Path .
   
   # Test your script
   .\path\to\your\script.ps1
   ```

4. **Update documentation**
   - Update relevant markdown files in `/docs/pwsh/`
   - Add examples for new features

## 🔄 Pull Request Process

1. **Sync your fork**
   ```powershell
   git remote add upstream https://github.com/original-owner/pwsh-scripts.git
   git fetch upstream
   git checkout main
   git merge upstream/main
   ```

2. **Submit a Pull Request**
   - Ensure your PR has a clear title and description
   - Reference any related issues
   - Include screenshots or GIFs for UI changes
   - Ensure all tests pass

3. **Code Review**
   - Be responsive to feedback
   - Make requested changes in new commits
   - Keep the PR focused on a single feature/fix

## 📚 Documentation

- Document all new features and changes
- Follow the existing documentation style
- Include examples for all public functions
- Update the README.md if necessary

## 🧪 Testing

- Add tests for new features
- Ensure existing tests pass
- Test in multiple PowerShell versions (5.1, 7.x)
- Test on different platforms if possible

## 🎨 Code Style

- Follow the [PowerShell Practice and Style Guide](https://poshcode.gitbook.io/powershell-practice-and-style/)
- Use `PSScriptAnalyzer` for linting
- Keep lines under 120 characters
- Use full cmdlet names (not aliases) in scripts
- Include comment-based help for all functions

## 🐛 Reporting Issues

When reporting issues, please include:

1. PowerShell version (`$PSVersionTable`)
2. Steps to reproduce
3. Expected vs actual behavior
4. Any error messages

## ✨ Feature Requests

1. Check existing issues to avoid duplicates
2. Clearly describe the problem and proposed solution
3. Include use cases and examples

## 📝 License

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).

---

Thank you for contributing! Your time and effort are greatly appreciated. 🚀
