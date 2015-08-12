###############################################################
#This script main purpose is to extract movies in a simple way#
#Thats way it dosn't allow the "Sub"Folder becous of it gets  #
#realy messy in the folder after extractions.                 #
#                                                             #
#The script asks for sours Folder and destination folder.     #
#Thats all!                                                   #
#AND! This script need "UnRAR.exe" to work.                   #
#Google and download.                                         #
###############################################################

$files = @()

function Read-FolderBrowserDialog([string]$Message, [string]$InitialDirectory, [switch]$NoNewFolderButton)
{
    $browseForFolderOptions = 0
    if ($NoNewFolderButton) { $browseForFolderOptions += 512 }
 
    $app = New-Object -ComObject Shell.Application
    $folder = $app.BrowseForFolder(0, $Message, $browseForFolderOptions, $InitialDirectory)
    if ($folder) { $selectedDirectory = $folder.Self.Path } else { $selectedDirectory = '' }
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($app) > $null
    return $selectedDirectory
}


    $startpath = Read-FolderBrowserDialog -Message "Where is the RARs?" 
    $endpath = Read-FolderBrowserDialog -Message "Where do you wanna put it?" 
 

Get-ChildItem $startpath -Recurse  -Filter "*.rar" | % {
 
    $files = $files + $_.FullName
}

foreach ($file in $files) {   
$newfiles = @()    

if (!(Test-Path "Subs")){

    $newname = ($file -split '\\')[-2]
        Get-ChildItem $endpath -Recurse | % {
        $newfiles =$_.FullName
        }  
        
        if (!(Test-Path "$endpath\$($newname)")){
 
        mkdir "$endpath\$($newname)"
        
        C:\unrar\UnRAR.exe x -y $file "$endpath\$($newname)"
        }

    }

}
