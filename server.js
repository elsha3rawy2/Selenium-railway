const express = require("express");
const { Builder, By, until } = require("selenium-webdriver");

const app = express();

// تشغيل المتصفح باستخدام Selenium
async function runSelenium(url) {
  let driver = await new Builder()
    .forBrowser("chrome")
    .setChromeOptions(
      require("selenium-webdriver/chrome").Options().headless()
    )
    .build();

  try {
    await driver.get(url);
    let title = await driver.getTitle();
    return `Page Title: ${title}`;
  } catch (error) {
    return `Error: ${error.message}`;
  } finally {
    await driver.quit();
  }
}

// نقطة الوصول الرئيسية
app.get("/", async (req, res) => {
  let url = req.query.url || "https://www.google.com";
  let result = await runSelenium(url);
  res.send(result);
});

// تشغيل السيرفر على بورت 4444
const PORT = process.env.PORT || 4444;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
