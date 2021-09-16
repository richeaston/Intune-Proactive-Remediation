Try {
    $lsa = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name RunAsPPL -ErrorAction SilentlyContinue
    if ($LSA) {
        $secure = Get-ItemPropertyValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name RunAsPPL
        if ($secure -eq 1) {
            Write-Output "All Good"
            Exit 0
        } else {
            Write-Output "Not Secure!"
            Exit 1
        }
    } else {
        Write-Output "Not Secure!"
        exit 1
    }
}
Catch {
    $errMsg = $_.Exception.Message
    write-output $errMsg
    exit 1
}
