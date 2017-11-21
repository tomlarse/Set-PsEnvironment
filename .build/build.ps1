# Grab nuget bits, install modules, set build variables, start build.
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null

#Install required modules
Install-Module psake -Scope CurrentUser -Force
Install-Module PSScriptAnalyzer -Scope CurrentUser -Force
Install-Script Install-Git -Scope CurrentUser -Force
Install-Module posh-git -Scope CurrentUser -Force
Install-Script Install-VSCode -Scope CurrentUser -Force
Install-Module Pester -Force -SkipPublisherCheck
Import-Module Psake, Pester, PSScriptAnalyzer

Invoke-psake .build\psake.ps1

exit ( [int]( -not $psake.build_success ) )