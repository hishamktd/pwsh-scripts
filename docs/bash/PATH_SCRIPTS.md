# Path Scripts Documentation (Bash)

## Overview
This document provides detailed information about all path-related Bash scripts in the `path-scripts` folder. These scripts are designed to be sourced rather than executed directly, providing functions that can be called after sourcing.

## How to Use
Source the main.sh file to load all path script functions:
```bash
source /path/to/path-scripts/main.sh
```

Then call any of the functions described below. All paths are configured in the `.env` file at the root of the custom-scripts directory.

## Scripts

### ws.sh
* **Purpose**: Quick navigation to workspace directory
* **Function**: `ws`
* **Usage**: `ws`
* **Examples**:
  ```bash
  ws
  ```
* **Notes**:
  - Changes directory to the workspace path defined in `.env` file
  - Uses the `BASH_WORKSPACE_PATH` environment variable

### kie.sh
* **Purpose**: Navigate to KIE project directories
* **Function**: `kie`
* **Usage**: `kie [project]`
* **Parameters**:
  - `project`: Project name to navigate to (sit, bee, hrms, medidesk, upa, ups)
* **Examples**:
  ```bash
  kie sit
  kie bee
  kie hrms
  kie medidesk
  kie upa
  kie ups
  ```
* **Notes**:
  - Changes directory to the specified KIE project path defined in `.env` file
  - Uses the corresponding `BASH_KIE_*_PATH` environment variables

### common.sh
* **Purpose**: Common path navigation functions
* **Function**: `scripts_path`
* **Usage**: `scripts_path`
* **Examples**:
  ```bash
  scripts_path
  ```
* **Notes**:
  - Changes directory to the custom scripts path defined in `.env` file
  - Uses the `BASH_SCRIPTS_PATH` environment variable

## Environment Configuration
All path scripts rely on the `.env` file at the root of the custom-scripts directory. This file contains path definitions for both PowerShell and Bash scripts.

### .env File Structure
```
# Path definitions for both PowerShell and Bash scripts
# PowerShell paths
WORKSPACE_PATH="C:\workspace"
SCRIPTS_PATH="C:\Users\User\PowerShell\custom-scripts"

# KIE project paths
KIE_SIT_PATH="D:\sit-pos-web"
KIE_BEE_PATH="D:\beework-hrms-ui"
KIE_HRMS_PATH="D:\kie-hrms-ui"
KIE_MEDIDESK_PATH="D:\medidesk-web"
KIE_UPCODE_CLOUD_PATH="D:\upcode-cloud"
KIE_UPCODE_STUDENT_PATH="D:\upcode-student-web"

# Bash paths (use forward slashes for compatibility)
BASH_WORKSPACE_PATH="/c/workspace"
BASH_SCRIPTS_PATH="/c/Users/User/PowerShell/custom-scripts"

# KIE project paths for Bash
BASH_KIE_SIT_PATH="/d/sit-pos-web"
BASH_KIE_BEE_PATH="/d/beework-hrms-ui"
BASH_KIE_HRMS_PATH="/d/kie-hrms-ui"
BASH_KIE_MEDIDESK_PATH="/d/medidesk-web"
BASH_KIE_UPCODE_CLOUD_PATH="/d/upcode-cloud"
BASH_KIE_UPCODE_STUDENT_PATH="/d/upcode-student-web"
```

### Modifying Paths
To change any path, edit the `.env` file rather than modifying the scripts directly. This allows for centralized path management for both PowerShell and Bash environments.
