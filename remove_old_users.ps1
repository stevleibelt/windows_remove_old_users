#!/usr/bin/env pwsh
# ================
# Script that removes non important user accounts older than x days.
# ================
# @see:
#   https://4sysops.com/archives/clean-up-user-profiles-with-powershell/
#   https://community.spiceworks.com/topic/1910810-cleaning-up-the-users-folder
#   https://zamarax.com/2020/04/20/how-to-delete-old-user-profiles-using-gpo-and-powershell/
# ================

#bo: setup
$oldVerbosePrefence   = $VerbosePreference
$VerbosePreference    = "Continue"
#eo: setup



If (!($DaysToKeep = Read-Host ":: Enter amount of days to keep users not logged in. (30) ")) {
    $DaysToKeep = 30
}

Write-Host $("   Removing fitting users with last log in date older than >>" + $DaysToKeep + "<< days.")

$ListOfUserLocalPath = Get-WMIObject -class Win32_UserProfile | Where {
    (!$_.Special) `
    -and (!$_.LocalPath.Contains("admin")) `
    -and ($_.LastUseTime.Length -gt 0) `
    -and ($_.ConvertToDateTime($_.LastUseTime) -lt $(Get-Date).AddDays(-$DaysToKeep)) `
} | Select LocalPath

$NumberOfUserLocalPath = $ListOfUserLocalPath.Count

If ($NumberOfUserLocalPath -gt 0) {
    Write-Verbose $(":: Listing >>" + $NumberOfUserLocalPath + "<< fitting user local paths.")
    $ListOfUserLocalPath | Format-Table | Write-Verbose

    $YesOrNo = Read-Host ":: Continue with removing the >>" + $NumberOfUserLocalPath + "<< users? (y|N) "

    If ($YesOrNo -eq "y") {
        Write-Verbose ":: Removing fitting entries."

        Get-WMIObject -class Win32_UserProfile | Where {
            (!$_.Special) `
            -and (!$_.LocalPath.Contains("admin")) `
            -and ($_.LastUseTime.Length -gt 0) `
            -and ($_.ConvertToDateTime($_.LastUseTime) -lt $(Get-Date).AddDays(-$DaysToKeep)) `
        } | Remove-WmiObject
    }
} Else {
    Write-Verbose ":: No fitting user entries found."
}