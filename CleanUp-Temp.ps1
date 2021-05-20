<#
Clean up the temp folder
Created by Lars Passic

This script searches the temp folder for folders like this: F6A3579C-997A-4A08-966F-617968446470
It looks for items with more than 35 characters
And that have 5 dashes in them
And that are of type directory
This is pretty dangerous, do not recommend running this.

After the folders are found it deletes them.
#>

#Change the working location to be the temp folder
Set-Location $env:TEMP

#Get all of the folders within the temp folder, then store them in a variable
$subFolders = Get-ChildItem -Directory | Where-Object {$_.Name.Length -gt 35 -and $_.Name -like "*-*-*-*-*" }

#Tell the user how many folders were found
Write-Host "There were $($subFolders.Count) folders found."

#Prompt user for input
$userInput = Read-Host -Prompt "Would you like to delete them? (Y / N) (default is N):"

#Check if the input from the user was yes
#If input from the user was yes - proceed with deletion
if ($userInput.ToLower() -eq "y") 
{
    $subFolders | ForEach-Object -Begin {
        Clear-Host
        $i = 0
    } -Process 
    {
        #If the item meets the criteria, then delete it
        if ((Get-Item $_).Mode -eq "d-----")
        {
            #Notify the user of when an item is deleted
            Write-Host "Removing item $($_.Name)"
            
            #Actually remove the folder
            #Remove-Item $_ -Confirm:$false
        }
        #If it doesn't meet the criteria, then do not remove it
        else 
        {
            #Notify the user when an item is not deleted
            Write-Host "NOT removing item $($_.Name)"
        }
        $i++
        
        #Update progress
        Write-Progress -Activity "Removing items" -Status "Progress: " -PercentComplete ($i/$subFolders.Count*100)
    }


}

#Otherwise do nothing and exit the script.
else 
{
    #Inform the user that no files were removed.
    Write-Host "No files were removed, exiting."
}