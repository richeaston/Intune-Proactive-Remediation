clear-host

function Show-Window {
  param(
    [Parameter(Mandatory)]
    [string] $ProcessName
  )

  # As a courtesy, strip '.exe' from the name, if present.
  $ProcessName = $ProcessName -replace '\.exe$'

  # Get the ID of the first instance of a process with the given name
  # that has a non-empty window title.
  # NOTE: If multiple instances have visible windows, it is undefined
  #       which one is returned.
  $procId = (Get-Process -ErrorAction Ignore $ProcessName).Where({ $_.MainWindowTitle }, 'First').Id

  
  # Note: 
  #  * This can still fail, because the window could have been closed since
  #    the title was obtained.
  #  * If the target window is currently minimized, it gets the *focus*, but is
  #    *not restored*.
  #  * The return value is $true only if the window still existed and was *not
  #    minimized*; this means that returning $false can mean EITHER that the
  #    window doesn't exist OR that it just happened to be minimized.
  $null = (New-Object -ComObject WScript.Shell).AppActivate($procId)

}

start-process chrome
$wshell = New-Object -ComObject wscript.shell; # shell for sending keys
$windowcheck = $wshell.AppActivate('chrome.exe') # make sure edge is the active window
start-sleep 10
Show-Window Chrome
$wshell.SendKeys('^t')
$wshell.SendKeys('chrome://settings/help')
Start-Sleep -milliseconds 100
$wshell.SendKeys("{ENTER}")
Start-sleep -Milliseconds 300
Exit 0
