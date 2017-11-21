Task default -Depends Test

Task Test -Depends Init, Clean {
    Invoke-Pester ..\
}

Task Clean -Depends Init {
    "clean"
}

Task Init {
    $profile = "$($ENV:BHProjectPath)\profile.ps1"
}