start chrome
Sleep 1
$wshell = New-Object -ComObject wscript.shell; # shell for sending keys
$wshell.AppActivate('Chrome') # make sure chrome is the active window
Sleep 1
$wshell.SendKeys('chrome://settings/help')
Sleep .5
$wshell.SendKeys("{ENTER}")
#Sleep 300 # sleep to allow updates to be processed 
# change sleep values if computer is slow.
Exit 0