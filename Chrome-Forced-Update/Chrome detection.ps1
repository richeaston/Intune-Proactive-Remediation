Clear-host

try { 
        Clear
        #check Chrome version installed    
        #$GCVersionInfo = (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe' -ErrorAction Ignore).'(Default)').VersionInfo
        #$GCVersion = $GCVersionInfo.ProductVersion
        $GCVersion = Get-ItemPropertyvalue -Path 'HKCU:\Software\Google\Chrome\BLBeacon' -Name version
        
        Write-output "Installed Chrome Version: $GCVersion" 

        #Get latest version of Chrome
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $j = Invoke-WebRequest 'https://omahaproxy.appspot.com/all.json' | ConvertFrom-Json

        foreach ($ver in $j) {
            if ($ver.os -like '*win') {
                $GCVer = $ver.versions.Current_Version
                foreach ($GCV in $GCVer[4]) {
                        if($GCV -eq $GCVersion) {
                            #version installed is latest
                            Write-output "$($Ver.os) Stable Version: $GCV,  Chrome $GCVersion is stable"
                            Exit 0
                        } else {
                            #version installed is not latest
                            Write-output "$($Ver.os) Stable Version:$GCV, Not safe, trigger alert" 
                            Exit 1
                        }
                }
            }
        }
}
catch {
    $errMsg = $_.Exception.Message
    if ($errmsg -eq "Cannot bind argument to parameter 'Path' because it is null.") {
        write-output "Google Chrome does not appear to be installed"
        Exit 0
    } else {
        Write-output $errMsg
        Exit 1
    }
}



