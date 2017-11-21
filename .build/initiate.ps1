Install-Module psake -Scope CurrentUser -Force
Install-Module PSScriptAnalyzer -Scope CurrentUser -Force
Import-Module psake, PSScriptAnalyzer

Invoke-PSake $PSScriptRoot\Build.ps1