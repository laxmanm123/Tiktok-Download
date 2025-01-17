
$currentDirectory = [System.IO.Path]::GetDirectoryName([System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName)
$textFile = "tiktoks-list.txt"
$userData = "user_data_tiktok.json"
$ytDlp = "yt-dlp.exe" 


$jsonFilePath = Join-Path -Path $currentDirectory -ChildPath $userData 
$textFilePath = Join-Path -Path $currentDirectory -ChildPath $textFile
$ytDlpPath = Join-Path -Path $currentDirectory -ChildPath $ytDlp

Write-Host 'Checking for necessary files...' -ForegroundColor Yellow;

#Check if user input is there
if (Test-Path -Path $jsonFilePath) {
    Write-Host "user_data_tiktok.json found at: $jsonFilePath" -ForegroundColor Green
} else {
    Write-Host "Error: The user data isn't here!! >:( make sure you put it in the same folder: $jsonFilePath" -ForegroundColor Red
    Start-Sleep -Seconds 5;
}


# Check if yt-dlp.exe is there
if (Test-Path -Path $ytDlpPath) {
    Write-Host "yt-dlp.exe found at: $ytDlpPath" -ForegroundColor Green
} else {
    Write-Host "Error: yt-dlp.exe not found! You need this to get ur tiktoks dude!! >:(" -ForegroundColor Red
    Start-Sleep -Seconds 5;
    exit 1 
}


Write-Host 'All Files found!' -ForegroundColor Green;


# Read the JSON file
try {
    $jsonData = Get-Content -Path $jsonFilePath | ConvertFrom-Json;
    $videoList = $jsonData.Activity.'Favorite Videos'.FavoriteVideoList;
    if (-Not $videoList) {
        Write-Host 'Error: FavoriteVideoList not found or is empty in user_data_tiktok.json.' -ForegroundColor Red;
        Start-Sleep -Seconds 5;
        exit 1;
    }
} 
catch {
    Write-Host "Error: Couldn't find user_data_tiktok";
    Start-Sleep -Seconds 5;
    exit 1;
}

# Create text file for yt-dlp
try {
    $videoList | ForEach-Object { $_.Link } | Out-File -FilePath $textFile -Encoding UTF8;
    Write-Host 'Success: FavoriteVideoList written to tiktoks-list.txt.' -ForegroundColor Green;
} catch {
    Write-Host 'Error: Failed to create list!' -ForegroundColor Red;
    Start-Sleep -Seconds 5;
    exit 1;
}


# Define the download folder 
$downloadFolder = Join-Path -Path $currentDirectory -ChildPath "downloads"

# Check if the folder exists, and create it if it doesn't
if (-Not (Test-Path -Path $downloadFolder)) {
    # Directory does not exist, create it
    Write-Host "Creating folder: $downloadFolder" -ForegroundColor Green
    New-Item -ItemType Directory -Path $downloadFolder
} else {
    Write-Host "Folder already exists: $downloadFolder" -ForegroundColor Yellow
}


# # Write-Host "Running yt-dlp to download videos to $downloadFolder" -ForegroundColor Green
# # yt-dlp -o "$downloadFolder\%(title)s.%(ext)s" -a $textFilePath

Start-Process -FilePath $ytDlpPath -ArgumentList @("-o", ".\downloads\%(title)s.%(ext)s", "-a", $textFilePath)

$userInput = Read-Host "Press Enter to continue or type 'exit' to quit"
if ($userInput -eq "exit") {
    Write-Host "Exiting script as per user request." -ForegroundColor Yellow
    exit
}