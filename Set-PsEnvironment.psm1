function Set-PsEnvironment {
    <#
    .SYNOPSIS
    Installs software and creates profiles to provide for a uniform PowerShell coding environment across
    machines and ease setup of new environments.

    .DESCRIPTION
    Takes a set of parameters or a config file which detirmines what software is installed and how it is
    set up. Will also set a PowerShell profile for the user

    .EXAMPLE
    Set-PsEnvironment -InstallGit -GitUserName "Your Name" -GitEmail "your@email.com" -InstallVscode -AdditionalVsCodeExtensions 'eamodio.gitlens', 'vscodevim.vim' -PsModules 'pester','plaster' -PsProfile c:\path\to\source\profile.ps1 -IncludeTests

    Will set up an environment based on the parameters.

    .EXAMPLE
    Set-PsEnvironment -ConfigFile c:\path\to\config.json

    Will set up an environment based on the parameters in the given file in the path specified

    .EXAMPLE
    Set-PsEnvironment -ConfigFile (iwr http://gist.github.com/username/gistid/raw)

    Will set up an environment based on the parameters in the given file in the url specified

    .EXAMPLE
    Set-PsEnvironment -ConfigFile c:\path\to\config.json -Update

    Will update the environment based on the parameters in the given file in the path specified

    .PARAMETER ConfigFile
    Path to a json file containing the config

    .PARAMETER InstallGit
    Include this if git should be installed

    .PARAMETER GitUserName
    The value that git config --global user.name should be

    .PARAMETER GitEmail
    The value that git config --global user.email should be

    .PARAMETER InstallVscode
    Include this if vscode should be installed. Will also install the PowerShell vscode extension

    .PARAMETER AdditionalVsCodeExtensions
    Any additional vscode extensions that should be installed.The fully qualified
    name is formatted as "<publisher name>.<extension name>" and can be found
    next to the extension's name in the details tab that appears when you
    click an extension in the Extensions panel in Visual Studio Code.

    .PARAMETER PsModules
    List of PowerShell modules that should be installed. These should be published in the PowerShell gallery.

    .PARAMETER PsProfile
    Path to a file containing the PowerShell profile that should be configured with the module.

    .PARAMETER IncludeTests
    If this is set, the resulting PowerShell profile will create a set of tests that will be run every time
    the profile is loaded. This parameter will require that pester is an installed PowerShell module.

    .NOTES
    General notes
    #>
    [CmdletBinding(DefaultParameterSetName="Manual")]
    Param (
        [parameter(ParameterSetName="Config",Mandatory=$true)]
        [string]ConfigFile,
        [parameter(ParameterSetName="Manual",Mandatory=$true)]
        [string]PsProfile,
        [parameter(ParameterSetName="Manual",Mandatory=$false)]
        [switch]InstallGit,
        [parameter(ParameterSetName="Manual",Mandatory=$false)]
        [string]GitUserName,
        [parameter(ParameterSetName="Manual",Mandatory=$false)]
        [string]GitEmail,
        [parameter(ParameterSetName="Manual",Mandatory=$false)]
        [switch]InstallVscode,
        [parameter(ParameterSetName="Manual",Mandatory=$false)]
        [string[]]AdditionalVsCodeExtensions,
        [parameter(ParameterSetName="Manual",Mandatory=$false)]
        [string[]]PsModules,
        [parameter(ParameterSetName="Manual",Mandatory=$false)]
        [switch]IncludeTests
    )

    begin {
    }

    process {
    }

    end {
    }
}

function New-PsEnvironmentConfig {
    <#
    .SYNOPSIS
    Creates a config file for use with Set-PsEnvironment

    .DESCRIPTION
    Takes the same input as Set-PsEnvironment, but instead of running it it will create a json config file that can be used to
    make Set-PsEnvironment behave the same each time it is run. The file can be hosted anywhere it can be retrieved as a text string
    i.e a GitHub gist, or on an SMB fileshare.

    .EXAMPLE
    New-PsEnvironmentConfig -OutputFilePath c:\temp\config.json -InstallGit -GitUserName "Your Name" -GitEmail "your@email.com" -InstallVscode -AdditionalVsCodeExtensions 'eamodio.gitlens', 'vscodevim.vim' -PsModules 'pester','plaster' -PsProfile c:\path\to\source\profile.ps1 -IncludeTests

    Will generate a json file containing all parameters needed to run Set-PsEnvironment -Config c:\path\to\config.json

    .PARAMETER OutputFilePath
    Path to export the resulting json file

    .PARAMETER InstallGit
    Include this if git should be installed

    .PARAMETER GitUserName
    The value that git config --global user.name should be

    .PARAMETER GitEmail
    The value that git config --global user.email should be

    .PARAMETER InstallVscode
    Include this if vscode should be installed. Will also install the PowerShell vscode extension

    .PARAMETER AdditionalVsCodeExtensions
    Any additional vscode extensions that should be installed.The fully qualified
    name is formatted as "<publisher name>.<extension name>" and can be found
    next to the extension's name in the details tab that appears when you
    click an extension in the Extensions panel in Visual Studio Code.

    .PARAMETER PsModules
    List of PowerShell modules that should be installed. These should be published in the PowerShell gallery.

    .PARAMETER PsProfile
    Path to a file containing the PowerShell profile that should be configured with the module.

    .PARAMETER IncludeTests
    If this is set, the resulting PowerShell profile will create a set of tests that will be run every time
    the profile is loaded. This parameter will require that pester is an installed PowerShell module.

    #>
    [CmdletBinding()]
    Param (
        [parameter(Mandatory=$true)]
        [string]OutputFilePath,
        [parameter(Mandatory=$true)]
        [string]PsProfile,
        [parameter(Mandatory=$false)]
        [switch]InstallGit,
        [parameter(Mandatory=$false)]
        [string]GitUserName,
        [parameter(Mandatory=$false)]
        [string]GitEmail,
        [parameter(Mandatory=$false)]
        [switch]InstallVscode,
        [parameter(Mandatory=$false)]
        [string[]]AdditionalVsCodeExtensions,
        [parameter(Mandatory=$false)]
        [string[]]PsModules,
        [parameter(Mandatory=$false)]
        [switch]IncludeTests
    )

    begin {
    }

    process {
    }

    end {
    }
}

#Set aliases
New-Alias -Name spe -Value Set-PsEnvironment

# Export only the functions using PowerShell standard verb-noun naming.
# Be sure to list each exported functions in the FunctionsToExport field of the module manifest file.
# This improves performance of command discovery in PowerShell.
Export-ModuleMember -Function *-* -Alias *
