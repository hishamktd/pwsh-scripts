function kie {
    param (
        [string]$project
    )

    # Load paths from .env file
    $envFile = Join-Path $PSScriptRoot "../.env"
    if (Test-Path $envFile) {
        $envContent = Get-Content $envFile | Where-Object { $_ -notmatch '^\s*#' -and $_ -match '=' }
        $envVars = @{}
        foreach ($line in $envContent) {
            if ($line -match '^\s*([^=]+?)\s*=\s*"(.*)"\s*$') {
                $envVars[$Matches[1]] = $Matches[2]
            }
        }
    } else {
        Write-Warning "Environment file not found: $envFile"
        return
    }

    switch ($project) {
        "sit" {
            Set-Location $envVars["KIE_SIT_PATH"]
            Write-Host "Switched to SIT" -ForegroundColor Green
            break
        }
        "bee" {
            Set-Location $envVars["KIE_BEE_PATH"]
            Write-Host "Switched to Bee work" -ForegroundColor Green
            break
        }
        "hrms" {
            Set-Location $envVars["KIE_HRMS_PATH"]
            Write-Host "Switched to HRMS" -ForegroundColor Green
            break
        }
        "medidesk" {
            Set-Location $envVars["KIE_MEDIDESK_PATH"]
            Write-Host "Switched to MediDesk" -ForegroundColor Green
            break
        }
        "upa" {
            Set-Location $envVars["KIE_UPCODE_CLOUD_PATH"]
            Write-Host "Switched to Upcode Cloud" -ForegroundColor Green
            break
        }
        "ups" {
            Set-Location $envVars["KIE_UPCODE_STUDENT_PATH"]
            Write-Host "Switched to Upcode student web" -ForegroundColor Green
            break
        }
	"araca" {
	    Set-Location "D:\arca-emr"
            Write-Host "Switched to Arca emr" -ForegroundColor Green
            break
	}
        Default {
            $basePath = "D:"
            $targetPath = Join-Path -Path $basePath -ChildPath $project
            if (Test-Path $targetPath) {
                Set-Location $targetPath
                Write-Host "Switched to $project" -ForegroundColor Green
            } else {
                Set-Location $basePath
                Write-Host "Switched to kiebot projects" -ForegroundColor Green
            }
            break
        }
    }
}
