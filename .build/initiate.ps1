Install-Module psake -Scope CurrentUser -Force
Import-Module psake

Invoke-PSake $PSScriptRoot\Build.ps1