<#
Clean up the temp folder
Created by Lars Passic

This script searches the temp folder for folders like this: F6A3579C-997A-4A08-966F-617968446470
It looks for items with more than 35 characters
And Attributes are of type "Directory"
This is pretty dangerous, do not recommend running this.

After the folders are found it deletes them.
#>

#Explain what the script does
Write-Host "This script finds and removes folders within the temp directory ($env:TEMP) that match this pattern:"
Write-Host "00000000-0000-0000-0000-000000000000"
Write-Host ""

#Create regex pattern to match the folders 00000000-0000-0000-0000-000000000000
$folderRegex = "^\w{8}-\w{4}-\w{4}-\w{4}-\w{12}$"

#Get all of the folders within the temp folder, then store them in a variable
$subFolders = Get-ChildItem $env:TEMP -Directory | Where-Object {$_.Name.Length -eq 36 -and $_.Name -match $folderRegex}

#Tell the user how many folders were found
Write-Host "There were $($subFolders.Count) folders found."

#Prompt user for input
$userInput = Read-Host -Prompt "Would you like to delete them? (Y / N) (default is N)"

#Check if the input from the user was yes
#If input from the user was yes - proceed with deletion
if ($userInput.ToLower() -eq "y") 
{
    $subFolders | ForEach-Object -Begin {

        #Create the variable for the write progress command
        $i = 0
    } -Process {
                #If the item is a directory, then delete it
                
                if ((Get-Item $_).Attributes -eq "Directory")
                {
                    #Introduce some latency
                    Start-Sleep -Milliseconds 100
                    
                    #Remove the folder
                    Remove-Item $_ -Recurse -Confirm:$false

                    #Update progress
                    Write-Progress -Activity "Removing items" -Status "Removing folder $($_.Name): " -PercentComplete ($i/$subFolders.Count*100)
                }
                #If the folder doesn't meet the criteria, then do not remove it
                else 
                {
                    #Introduce some latency
                    Start-Sleep -Milliseconds 100
                    
                    #Update progress
                    Write-Progress -Activity "Skipping items" -Status "Skipping folder $($_.Name): " -PercentComplete ($i/$subFolders.Count*100)
                }
                $i++
                
                }


}

#Otherwise do nothing and exit the script.
else 
{
    #Inform the user that no files were removed.
    Write-Host "No files were removed, exiting."
}