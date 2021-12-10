try { 
        Clear
        #check MSEDGE version installed    
        #$EdgeVersionInfo = (Get-AppxPackage -Name "Microsoft.MicrosoftEdge.Stable").Version
        $edgeregistryver = Get-ItemPropertyvalue -Path 'HKCU:\\SOFTWARE\Microsoft\Edge\BLBeacon' -Name version
        Write-output "Installed MSEDGE Version: $edgeregistryver" 

        #Get latest version of MSEDGE
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $j = Invoke-WebRequest 'https://edgeupdates.microsoft.com/api/products?view=enterprise' | ConvertFrom-Json

        foreach ($ver in $j) {
            #$channel = $ver.Product 
            if ($ver.Product -eq 'Stable' ) {
                foreach ($v in $(($ver.Releases).ProductVersion[0])) {
                    if ($v -match $edgeregistryver ) {
                        #version installed is latest
                        Write-output "Stable Version: $v,  MSEDGE Version $edgeregistryver is the latest stable release"
                        Exit 0
                    } else {
                        #version installed is not latest
                        Write-output "Stable Version:$v, Installed Version $edgeregistryver, Not safe, trigger alert" 
                        Exit 1
                    }
                }
            }
        }
}
catch {
    $errMsg = $_.Exception.Message
    if ($errmsg -eq "Cannot bind argument to parameter 'Path' because it is null.") {
        write-output "MSEDGE does not appear to be installed"
        Exit 0
    } else {
        Write-output $errMsg
        Exit 1
    }
}
