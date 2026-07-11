const puppeteer = require('puppeteer');

(async () => {
  const shareUrl = process.argv[2];
  if (!shareUrl) {
    console.error('Usage: node extract_url.js <astrotalk-share-link>');
    process.exit(1);
  }

  const browser = await puppeteer.launch({ headless: true });
  try {
    const page = await browser.newPage();
    await page.goto(shareUrl, { waitUntil: 'networkidle2', timeout: 30000 });

    // Angular hydrates a moment after network idle; give it a beat.
    await new Promise((r) => setTimeout(r, 2000));

    const url = await page.evaluate(() => {
      // New page layout: a plain <audio><source> element.
      const source = document.querySelector('audio source');
      const audio = document.querySelector('audio');
      if (source && source.src) return source.src;
      if (audio && audio.currentSrc) return audio.currentSrc;

      // Old page layout: the recording URL lives inside Angular's
      // component state (recordingData.recording), not the DOM.
      let found = null;
      document.querySelectorAll('*').forEach((e) => {
        Object.keys(e)
          .filter((k) => k.startsWith('__ngContext__'))
          .forEach((k) => {
            (e[k] || []).forEach((item) => {
              if (item && item.recordingData && item.recordingData.recording) {
                found = item.recordingData.recording;
              }
            });
          });
      });
      return found;
    });

    if (!url) {
      console.error('NOT_FOUND');
      process.exit(2);
    }
    console.log(url);
  } finally {
    await browser.close();
  }
})();
