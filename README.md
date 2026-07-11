## How to Download Audio/Call Recording


**Demo Video:**

<a href="https://youtu.be/Ln_eJUQzoXk"><img src="https://img.youtube.com/vi/Ln_eJUQzoXk/hqdefault.jpg" width="600" alt="Watch Demo Video"/></a>

### Step 1 - Open the Recording URL
Open the recording link in Chrome.

### Step 2 - Open Developer Console
Press Cmd + Option + I on your keyboard.
Click on the Console tab.

### Step 3 - Paste this code in Console and press Enter

### Step 3 - Paste this code in Console and press Enter

```javascript
let url = null;
document.querySelectorAll('*').forEach(e => {
  Object.keys(e).filter(k => k.startsWith('__ngContext__')).forEach(k => {
    (e[k] || []).forEach(item => {
      if (item?.recordingData?.recording) url = item.recordingData.recording;
    });
  });
});
console.log(url.split('?')[0]);
```

Step 4 - Copy the URL
Copy the link that appears starting with https://at-agora-voip-prod.s3...

Step 5 - Open Terminal
Just open the Terminal app on your Mac. That's it. No need to go to any folder.

### Step 6 - Run this command

```bash
ffmpeg -i "PASTE-YOUR-URL-HERE" -c:a libmp3lame -q:a 2 ~/Downloads/recording.mp3
```

Step 7 - Done
Your MP3 file will be saved in your Downloads folder as recording.mp3
