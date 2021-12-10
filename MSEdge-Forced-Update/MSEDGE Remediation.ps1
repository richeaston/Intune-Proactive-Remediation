clear-host

function Show-Window {
  param(
    [Parameter(Mandatory)]
    [string] $ProcessName
  )

  $ProcessName = $ProcessName -replace '\.exe$'
  $procId = (Get-Process -ErrorAction Ignore $ProcessName).Where({ $_.MainWindowTitle }, 'First').Id

  if (-not $procId) { Throw "No $ProcessName process with a non-empty window title found." }
  $null = (New-Object -ComObject WScript.Shell).AppActivate($procId)

}


Start-Process "MSEDGE.exe"
Start-Sleep -seconds 3
$wshell = New-Object -ComObject wscript.shell; # shell for sending keys

    Start-Sleep 3
    Show-Window MSEDGE
    Start-Sleep -milliseconds 500
    $wshell.SendKeys('edge://settings/help')
    Start-Sleep -milliseconds 500
    $wshell.SendKeys("{ENTER}")
    Start-sleep -Milliseconds 300
    Exit 0
    
