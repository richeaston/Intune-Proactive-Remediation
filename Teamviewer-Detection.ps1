Try {
    if (Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | Where-Object {$_.DisplayName -Like "TeamViewer*"}) {
        Write-output "TeamViewer Installer"
        Exit 1
    } else {
        Write-output "TeamViewer not Installer"
        Exit 0
    }
     if (Get-ItemProperty "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | Where-Object {$_.DisplayName -Like "TeamViewer*"}) {
        Write-output "TeamViewer Installer"
        Exit 1
    } else {
        Write-output "TeamViewer not Installer"
        Exit 0
    }
}

Catch {
    $errMsg = $_.Exception.Message
    write-output $errMsg
    Exit 1
}
