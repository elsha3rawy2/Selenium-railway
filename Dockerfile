# استخدم صورة Node.js كأساس
FROM node:18

# تثبيت Google Chrome و Selenium
RUN apt-get update && apt-get install -y wget curl unzip \
    && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update && apt-get install -y google-chrome-stable \
    && curl -sS -o /usr/local/bin/chromedriver https://chromedriver.storage.googleapis.com/$(curl -sS https://chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip \
    && chmod +x /usr/local/bin/chromedriver

# نسخ ملفات المشروع
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .

# فتح البورت
EXPOSE 4444

# تشغيل السيرفر
CMD ["node", "server.js"]
