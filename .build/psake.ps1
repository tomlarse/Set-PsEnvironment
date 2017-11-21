Task default -Depends Test

Task Test -Depends Init, Clean {
    $profile = "$($ENV:BHProjectPath)\profile.ps1"
    New-Item -ItemType File -Path $profile
    Set-Content -Path $profile -Value "profile"
    Invoke-Pester ..\
}

Task Clean -Depends Init {
    "clean"
}

Task Init {
    "init"
}