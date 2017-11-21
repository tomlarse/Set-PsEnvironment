# Automatic setup of Powershell environment

![Build Status](https://tominge.visualstudio.com/_apis/public/build/definitions/5a8e29b5-a12f-4e3f-9398-eed3ad2b53e3/2/badge)

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