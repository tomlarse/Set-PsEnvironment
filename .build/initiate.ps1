Install-Module psake -Scope CurrentUser -Force
Import-Module psake

Invoke-PSake $PSScriptRoot\.build\Build.ps1