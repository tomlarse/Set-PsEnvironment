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
    $config = New-PsEnvironmentConfig -InstallGit -GitUserName "Your Name" -GitEmail "your@email.com" -InstallVscode -AdditionalVsCodeExtensions 'eamodio.gitlens' -PsModules 'pester','plaster' -PsProfile $profile -IncludeTests

    It "Git should be set to true" {
        $config.InstallGit | Should be 'true'
    }

    It "Git username should be set" {
        $config.GitUsername | Should be "Your Name"
    }

    It "Git email should be set" {
        $config.GitEmail | Should be "your@email.com"
    }

    It "Install Vscode should be set to true" {
        $config.InstallVscode | Should be 'true'
    }

    It "Additional vscode extensions should be 1" {
        $config.AdditionalVsCodeExtensions.count | Should be 1
    }

    It "PsModules should be 2" {
        $config.PsModules.count | Should be 2
    }

    It "Includetests should be set to true" {
        $config.Includetests | Should be 'true'
    }
}

Describe "Configure environment tests -- All params configured" {
    $config = New-PsEnvironmentConfig -InstallGit -GitUserName "Your Name" -GitEmail "your@email.com" -InstallVscode -AdditionalVsCodeExtensions 'eamodio.gitlens' -PsModules 'pester', 'plaster' -PsProfile $profile -IncludeTests

    Mock Install-Git.ps1 -ModuleName Set-PsEnvironment
    Mock Install-Module -ParameterFilter {$name -eq "posh-git"} -ModuleName Set-PsEnvironment
    Mock Install-VSCode.ps1 -ParameterFilter {$AdditionalExtensions -eq $config.AdditionalVsCodeExtensions} -ModuleName Set-PsEnvironment
    Mock Install-VSCode.ps1 -ModuleName Set-PsEnvironment
    Mock Install-Module -ModuleName Set-PsEnvironment
    Mock New-Item -ModuleName Set-PsEnvironment
    Mock Set-Content -ParameterFilter {$path -and $path.EndsWith("profile.tests.ps1") } -ModuleName Set-PsEnvironment
    Mock Set-Content -ParameterFilter {$path -and $path -eq $profile } -ModuleName Set-PsEnvironment
    Mock Set-Content -ModuleName Set-PsEnvironment

    Set-PsEnvironment -Config $config

    It "Calls Install-Vscode" {
        Assert-MockCalled Install-VSCode.ps1 -ParameterFilter {$AdditionalExtensions -eq $config.AdditionalVsCodeExtensions} -Exactly 1 -ModuleName Set-PsEnvironment
    }

    It "Calls Install-Git" {
        Assert-MockCalled Install-Git.ps1 -Exactly 1 -ModuleName Set-PsEnvironment
    }

    It "Installs Posh-Git" {
        Assert-MockCalled Install-Module -ParameterFilter {$name -eq "posh-git"} -ModuleName Set-PsEnvironment -Exactly 1
    }

    It "Calls Install-Module" {
        Assert-MockCalled Install-Module -Exactly 3 -ModuleName Set-PsEnvironment
    }

    It "Adds Profile Tests" {
        Assert-MockCalled Set-Content -ParameterFilter {$path -and $path.EndsWith("profile.tests.ps1") } -Exactly 1 -ModuleName Set-PsEnvironment
    }

    It "Adds Profile content" {
        Assert-MockCalled Set-Content -ParameterFilter {$path -and $path -eq $profile } -Exactly 1 -ModuleName Set-PsEnvironment
    }
}