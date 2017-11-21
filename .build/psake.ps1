Task default -Depends Test

Task Test -Depends Init, Clean {
    $profile = "$($ENV:BHProjectPath)\profile.ps1"
    Invoke-Pester ..\
}

Task Clean -Depends Init {
    "clean"
}

Task Init {
    "init"
}