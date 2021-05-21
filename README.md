# CleanUp-Temp.ps1
![Image of CleanUp-Temp.ps1 running](https://github.com/larspassic/CleanUp-Temp.ps1/blob/main/images/CleanUp-Temp%20running.png?raw=true)
A script to clean up the temp folder, for a very specific issue I am encountering with lots and lots of folders being created and left behind by cleanmgr.exe

Here is what cleanmgr.exe has been leaving behind in my temp directory, eventually completely filling up my hard disk:

![Image of the folders that cleanmgr.exe is leaving behind](https://github.com/larspassic/CleanUp-Temp.ps1/blob/main/images/cleanmgr%20leaving%20many%20folders.png?raw=true)


Here is what each of those folders looks like inside:

![Image of one of the folders that cleanmgr.exe is leaving behind](https://github.com/larspassic/CleanUp-Temp.ps1/blob/main/images/example%20folder%20left%20behind%20by%20cleanmgr.png?raw=true)

These folders are usually about 9.6 MB each, but if there exists 15,000+ of these folders, you can see how the disk space will fill up quickly.

I used ProcMon from sysinternals to monitor the temp directory, and eventually found that cleanmgr.exe was the culprit and was creating these folders, and not deleting them after it was finished.

I tried using the built-in Disk Cleanup Utility (cleanmgr.exe) as well as Storage Sense, but neither of them succeeded in removing these particular folders from my temp directory.

So I wrote this PowerShell script to look for the patterns that these folders follow and remove them from the temp folder, to clean up what cleanmgr.exe left behind.

There is some inherent risk with programmatically mass-deleting folders, so please be careful with this script.
