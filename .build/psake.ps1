Task default -Depends Test

Task Test -Depends Init, Clean {
    $profile = "$($ENV:BHProjectPath)\profile.ps1"
    New-Item -ItemType File -Path $profile
    Set-Content -Path $profile -Value "profile"
    $testresultsfile = .\Testresults.xml
    $res = Invoke-Pester ..\ -OutputFormat NUnitXml -OutputFile $testresultsfile -PassThru

    (New-Object 'System.Net.WebClient').UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path $testResultsFile))
        if ($res.FailedCount -gt 0) {
            throw "$($res.FailedCount) tests failed."
        }
}

Task Clean -Depends Init {
    "clean"
}

Task Init {
    "init"
}