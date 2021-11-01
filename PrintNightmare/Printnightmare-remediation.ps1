Clear-host
$regpath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint"
$items = @("NoWarningNoElevationOnInstall,0", "UpdatePromptSettings,0", "RestrictDriverInstallationToAdministrators,1")

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
        } else {
            Write-host "$name non-compliant, setting correct Value : $value"
            Set-ItemProperty -Path $regpath -name $name -value $value -verbose -Force
        }
    }
    Catch [System.Management.Automation.RuntimeException] {
        Write-warning "$name does not exist, Creating"
        new-itemproperty -Path $regpath -PropertyType DWORD -Name $name -Value $value -FORCE
    }
    finally {
        $Error.Clear()
    }
}

Write-output "Compliant"
exit 0
