#Install required modules
Install-Module psake -Scope CurrentUser -Force
Install-Module PSScriptAnalyzer -Scope CurrentUser -Force
Install-Script Install-Git -Scope CurrentUser -Force
Install-Module posh-git -Scope CurrentUser -Force
Install-Script Install-VSCode -Scope CurrentUser -Force

Import-Module psake, PSScriptAnalyzer

#Create $profile location on agent.
New-Item -ItemType Directory -Force -Path (Split-Path $profile)
Set-Content -Path $profile -Value "Testprofile"

Invoke-PSake $PSScriptRoot\Build.ps1