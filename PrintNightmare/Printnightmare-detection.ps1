Clear-host
$regpath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint"
$items = @("NoWarningNoElevationOnInstall,0", "UpdatePromptSettings,0", "RestrictDriverInstallationToAdministrators,1")
$good = 0
$bad = 0    

if (!(test-path $regpath)) {
    new-item -Path $regpath -ItemType Directory  -force
} 

foreach ($i in $items) {
    $regitem = $i.Split(",")
    $name = $regitem[0]
    $value = $regitem[1]

    try {
        $current = Get-ItemPropertyValue -path $regpath -name $name
        if ($value -match $current) {
                Write-host "$name Value: $current" -ForegroundColor Yellow
                $good++

        } else {
            Write-host "$name non-compliant, setting correct Value : $value"
            $bad++
        }
    }
    Catch [System.Management.Automation.RuntimeException] {
        Write-warning "$name does not exist, Creating"
        $bad++
    }
    finally {
        $Error.Clear()
    }
    
}

if ($good -eq 3 -and $bad -eq 0) {
    Write-output "Compliant"
    Exit 0
} elseif ($bad -gt 0) {
    Write-output "Non-Compliant"
    Exit 1
}
