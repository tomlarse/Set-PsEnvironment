#Install VsCode and Powershell extension
if (-not (Test-Path "C:\Program Files (x86)\Microsoft VS Code")) {
    Install-Script Install-VSCode -Scope CurrentUser; Install-VSCode.ps1
}

# Check that modules are installed
if ((Get-Module -ListAvailable pester) -eq $null) {
    Install-Module pester -Scope CurrentUser
} elseif ((Get-Module -ListAvailable posh-git) -eq $null) {
    Install-Module posh-git -Scope CurrentUser
} elseif ((Get-Module -ListAvailable plaster) -eq $null) {
    Install-Module plaster -Scope CurrentUser
}

$profilecontent = "
Push-Location (Split-Path -Path `$MyInvocation.MyCommand.Definition -Parent)

## Get other nice to have functions
Invoke-Expression (New-Object Net.WebClient).DownloadString(`"https://raw.githubusercontent.com/api0cradle/PowershellScripts/master/Hyper-V/New-DifferencingVM.ps1`")
Invoke-Expression (New-Object Net.WebClient).DownloadString(`"https://raw.githubusercontent.com/api0cradle/PowershellScripts/master/Hyper-V/Remove-VirtualMachine.ps1`")

## Create the default prompt and make it loadable on demand
Function DefaultPrompt {
    # Load modules from current directory
    Import-Module posh-git

    # Set up a simple prompt, adding the git prompt parts inside git repos
    function global:prompt {
        `$realLASTEXITCODE = `$LASTEXITCODE

        Write-Host(`$pwd.ProviderPath) -nonewline

        Write-VcsStatus

        `$global:LASTEXITCODE = `$realLASTEXITCODE
        return `"> `"
    }
}

#Create the presenter prompt
Function PresenterPrompt {
    function global:prompt {
        Write-Host `"I `" -nonewline
        Write-Host `"`$([char]0x2665) `" -ForegroundColor Red -nonewline
        return `"PS> `"
    }
}

Pop-Location

Start-SshAgent -Quiet

invoke-pester -path (join-path -path (split-path `$profile) -childpath test)

DefaultPrompt
"

$tests = "
Describe `"New machine Powershell environment setup`" {
    It `"has Vscode installed`" {
        (Test-Path 'C:\Program Files (x86)\Microsoft VS Code') | Should be `$true
    }

    It `"has pester installed`" {
        ## Use -ListAvailable because the module might not be loaded yet.
        (Get-Module -ListAvailable pester).Name -eq `"pester`" | Should Be `$true
    }

    It `"has plaster installed`" {
        ## Use -ListAvailable because the module might not be loaded yet.
        (Get-Module -ListAvailable plaster).Name -eq `"plaster`" | Should Be `$true
    }

    It `"has posh-git installed`" {
        ## Use -ListAvailable because the module might not be loaded yet.
        (Get-Module -ListAvailable posh-git).Name -eq `"posh-git`" | Should Be `$true
    }
    
    It `"has git installed`" {
        (git --version) -match `"git version`" | Should Be `$true
    }

    It `"has git user.name set`" {
        (git config --get user.name) -ne `$null | Should be `$true
    }

    It `"has git user.email set`" {
        (git config --get user.email) -ne `$null | Should be `$true
    }

    It `"has git push.default simple set`" {
        (git config --get push.default) -eq `"simple`" | Should be `$true
    }
}
"
$profilepath = split-path $profile
$profiletestpath = (join-path -path (split-path $profile) -childpath test)

If(!(test-path $profilepath))
{
    New-Item -ItemType Directory -Force -Path $profilepath
}

If(!(test-path $profiletestpath))
{
    New-Item -ItemType Directory -Force -Path $profiletestpath
}

Set-Content -Path $profile -Value $profilecontent
Set-Content -Path (join-path -path $profiletestpath -childpath profile.tests.ps1) -Value $tests