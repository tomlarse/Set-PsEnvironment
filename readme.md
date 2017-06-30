# Automatic setup of Powershell environment

## Set-PsEnvironment
Sets up the environment based on given parameters or json configfile

Parameters
* Default Parameterset: Individual
 * InstallGit
  * GitUserName
  * GitEmail
 * InstallVscode
  * AdditionalVscodeExtensions
 * PsModules
 * PsProfile
 * IncludeTests

 * Parameterset: Configfile
  * Config

 * Common parameter
  * Update

## New-PsEnvironmentConfig
Creates a json configfile for use with Set-PsEnvironment

Parameters
 * OutputFilePath
 * InstallGit
  * GitUserName
  * GitEmail
 * InstallVscode
  * AdditionalVscodeExtensions
 * PsModules
 * PsProfile
 * IncludeTests