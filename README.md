# PowerShell Custom Scripts

## Setup Instructions

1. **Clone the repository**:
   ```powershell
   git clone https://github.com/yourusername/pwsh-scripts.git
   cd pwsh-scripts
   ```

2. **Add to your PowerShell profile**:
   Edit your PowerShell profile (`$PROFILE`) and add:
   ```powershell
   . C:\path\to\pwsh-scripts\main.ps1
   ```

3. **Reload your profile**:
   ```powershell
   . $PROFILE
   ```

4. **Verify installation**:
   Run `Get-Command` to see available custom commands

## Script Categories
- Git scripts
- Development scripts
- Utility scripts
- Theme scripts

## Usage
All scripts are automatically loaded when you start PowerShell after adding to your profile.

### TO DO
 * Add branch handling short cut (br)
 * Add lazy loading
 * Add file/folder creating script
 * Add time stamp for each function
