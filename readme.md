# Automatic setup of Powershell environment

![Build Status](https://tominge.visualstudio.com/_apis/public/build/definitions/5be33ea8-ecba-453d-9196-425208514541/3/badge)

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