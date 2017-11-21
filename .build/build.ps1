# Grab nuget bits, install modules, set build variables, start build.
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null

Install-Module Psake -force
Install-Module Pester -Force -SkipPublisherCheck
Import-Module Psake, Pester

Invoke-psake .\build\psake.ps1

exit ( [int]( -not $psake.build_success ) )