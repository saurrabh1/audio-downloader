## How to Download Audio/Call Recording

### Quick Start (automated — no browser console needed)

**One-time setup:**

```bash
git clone https://github.com/saurrabh1/audio-downloader.git
cd audio-downloader
npm install
```

(Requires [Node.js](https://nodejs.org) and `ffmpeg` — install ffmpeg with `brew install ffmpeg` if you don't have it.)

**Every time you want a recording:**

```bash
./download_astrotalk.sh "PASTE-YOUR-SHARE-LINK-HERE"
```

That's it. The script opens the page in a headless browser, finds the recording
stream (whichever format Astrotalk happens to be using), and saves it as
`~/Downloads/recording_<timestamp>.mp3`.

To choose your own filename:

```bash
./download_astrotalk.sh "PASTE-YOUR-SHARE-LINK-HERE" ~/Downloads/my_call.mp3
```

---

### Manual method (fallback, if the automated script ever breaks)

**Demo Video:**

<a href="https://youtu.be/Ln_eJUQzoXk"><img src="https://img.youtube.com/vi/Ln_eJUQzoXk/hqdefault.jpg" width="600" alt="Watch Demo Video"/></a>

#### Step 1 - Open the Recording URL
Open the recording link in Chrome.

#### Step 2 - Open Developer Console
Press Cmd + Option + I on your keyboard.
Click on the Console tab.

#### Step 3 - Paste this code in Console and press Enter

```javascript
let url = document.querySelector('audio source')?.src
  || document.querySelector('audio')?.currentSrc
  || null;
if (!url) {
  document.querySelectorAll('*').forEach(e => {
    Object.keys(e).filter(k => k.startsWith('__ngContext__')).forEach(k => {
      (e[k] || []).forEach(item => {
        if (item?.recordingData?.recording) url = item.recordingData.recording;
      });
    });
  });
}
console.log(url ? url.split('?')[0] : 'NOT FOUND');
```

#### Step 4 - Copy the URL
Copy the link that appears in the console.

#### Step 5 - Open Terminal
Just open the Terminal app on your Mac. That's it. No need to go to any folder.

#### Step 6 - Run this command

If the URL ends in `.m3u8`:

```bash
ffmpeg -i "PASTE-YOUR-URL-HERE" -c:a libmp3lame -q:a 2 ~/Downloads/recording.mp3
```

If the URL ends in `.mp3`:

```bash
curl -L "PASTE-YOUR-URL-HERE" -o ~/Downloads/recording.mp3
```

#### Step 7 - Done
Your MP3 file will be saved in your Downloads folder as recording.mp3
