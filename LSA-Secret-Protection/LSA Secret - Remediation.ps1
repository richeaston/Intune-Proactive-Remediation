Try {
    $lsa = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name RunAsPPL -ErrorAction SilentlyContinue
    if ($lsa) {
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name RunAsPPL -value 1 -Force
    } else {
        New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name RunAsPPL -PropertyType DWORD -value 1 -Force -verbose
    }
    Write-Output "Secure!"
    exit 0
}
Catch {
    $errMsg = $_.Exception.Message
    write-output $errMsg
    exit 1
}
