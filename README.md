## How to Download Astrotalk Call Recording

### Step 1 - Open the Recording URL
Open the Astrotalk recording link in Chrome.

### Step 2 - Open Developer Console
Press Cmd + Option + I on your keyboard.
Click on the Console tab.

### Step 3 - Paste this code in Console and press Enter

// Paste this in Console, press Enter
let url = null;
document.querySelectorAll('*').forEach(e => {
  Object.keys(e).filter(k => k.startsWith('__ngContext__')).forEach(k => {
    (e[k] || []).forEach(item => {
      if (item?.recordingData?.recording) url = item.recordingData.recording;
    });
  });
});
console.log(url.split('?')[0]);  // prints the clean m3u8 URL

Step 4 - Copy the URL
Copy the link that appears starting with https://at-agora-voip-prod.s3...

Step 5 - Open Terminal
Just open the Terminal app on your Mac. That's it. No need to go to any folder.

Step 6 - Run this command
ffmpeg -i "PASTE-YOUR-URL-HERE" -c:a libmp3lame -q:a 2 ~/Downloads/recording.mp3
Replace PASTE-YOUR-URL-HERE with the URL you copied.

Step 7 - Done
Your MP3 file will be saved in your Downloads folder as recording.mp3
