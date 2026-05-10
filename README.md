# Audio Downloader

## How to Download Astrotalk Call Recording

### Step 1 - Open the Recording URL
Open the Astrotalk recording link in Chrome.

### Step 2 - Open Developer Console
Press Cmd + Option + I on your keyboard.
Click on the Console tab.

### Step 3 - Paste this code in Console and press Enter

let url = null;
document.querySelectorAll('*').forEach(e => {
  Object.keys(e).filter(k => k.startsWith('__ngContext__')).forEach(k => {
    (e[k] || []).forEach(item => {
      if (item?.recordingData?.recording) url = item.recordingData.recording;
    });
  });
});
console.log(url.split('?')[0]);

### Step 4 - Copy the URL
Copy the link that appears starting with https://at-agora-voip-prod.s3...

### Step 5 - Open Terminal
cd ~/Developer/audio-downloader

### Step 6 - Run the Script
./download_audio.sh "PASTE-YOUR-URL-HERE" "my-recording.mp3"

### Step 7 - Done
Your MP3 file will be saved in the audio-downloader folder.
