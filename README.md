# Tiktok-Download
This repository contains the files necessary to download your saved tiktoks to your computer.

Make sure you have enough space in whatever location you are running this program, as there will likely be alot of videos,
for reference, I had about 1200 videos saved which took 4.6 GB. 

It will take a long time, so don't close the terminal until it has completed, it will then close on its own.

If the sound or video was removed, the video will not be downloaded

Target.exe is the executable version of convert-json-txt-win.ps1, feel free to look at the code

I did not create yt-dlp.exe, it is a free and open source video and audio downloading tool that you can find more about here: https://github.com/yt-dlp/yt-dlp

The purpose of this project is to simplify the steps of the manual process so anyone can do it in 20 seconds.

Instructions:

1. Download your tiktok user data to your computer, go to the tik-tok website,
   login, settings -> data -> download your data -> Select File Format as JSON -> request data -> download data

2. Download the contents of this repository, click the green button -> download as zip

3. Create a new folder in your desired location(desktop, wherever you want) where you want your downloaded videos to go
  
4. Extract the contents of both the user data, and the tiktok-download folder into your newly created folder. Your new folder should now contain user_data_tiktok.json, target.exe, yt-dlp.exe, convert-json-to-txt-win.ps1, and README.md
   (note: convert-json-to-txt-win.ps1, and README.md are not necessary to do this, they are only there for visibility)

6. Double click and run target.exe, and your saved videos will be downloaded!

