$ModuleManifestName = 'Set-PsEnvironment.psd1'
$ModuleManifestPath = "$PSScriptRoot\..\$ModuleManifestName"
Import-Module "$PSScriptRoot\..\Set-PsEnvironment.psd1"

Describe 'Module Manifest Tests' {
    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path $ModuleManifestPath
        $? | Should Be $true
    }
}

Describe 'Create environment config file tests' {
    New-PsEnvironmentConfig -OutputFilePath "$env:TEMP\config.json" -InstallGit -GitUserName "Your Name" -GitEmail "your@email.com" -InstallVscode -AdditionalVsCodeExtensions 'eamodio.gitlens' -PsModules 'pester','plaster' -PsProfile c:\path\to\source\profile.ps1 -IncludeTests

    It 'Creates a config file' {
        Test-Path "$env:TEMP\config.json" | Should Be $true
    }

    if (Test-Path "$env:TEMP\config.json") {
        $config = Get-Content "$env:TEMP\config.json" | ConvertTo-Json

        It "Git should be set to true" {
            $config.InstallGit | Should be 'true'
        }

        It "Git username should be set" {
            $config.GitUsername | Should be "Your Name"
        }
    }

}

