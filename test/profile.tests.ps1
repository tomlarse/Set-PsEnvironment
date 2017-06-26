
Describe "New machine Powershell environment setup" {
    It "has Vscode installed" {
        (Test-Path 'C:\Program Files (x86)\Microsoft VS Code') | Should be $true
    }

    It "has pester installed" {
        ## Use -ListAvailable because the module might not be loaded yet.
        (Get-Module -ListAvailable pester).Name -eq "pester" | Should Be $true
    }

    It "has plaster installed" {
        ## Use -ListAvailable because the module might not be loaded yet.
        (Get-Module -ListAvailable plaster).Name -eq "plaster" | Should Be $true
    }

    It "has posh-git installed" {
        ## Use -ListAvailable because the module might not be loaded yet.
        (Get-Module -ListAvailable posh-git).Name -eq "posh-git" | Should Be $true
    }
    
    It "has git installed" {
        (git --version) -match "git version" | Should Be $true
    }

    It "has git user.name set" {
        (git config --get user.name) -ne $null | Should be $true
    }

    It "has git user.email set" {
        (git config --get user.email) -ne $null | Should be $true
    }

    It "has git push.default simple set" {
        (git config --get push.default) -eq "simple" | Should be $true
    }
}

