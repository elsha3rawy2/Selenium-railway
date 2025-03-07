# استخدم صورة Node.js كأساس
FROM node:18

# تثبيت المتطلبات الأساسية + Google Chrome + ChromeDriver
RUN apt-get update && apt-get install -y wget curl unzip \
    && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update && apt-get install -y google-chrome-stable \
    && wget -O /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/$(curl -sS https://chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip \
    && unzip /tmp/chromedriver.zip -d /usr/local/bin/ \
    && chmod +x /usr/local/bin/chromedriver \
    && rm -rf /var/lib/apt/lists/* /tmp/chromedriver.zip

# ضبط متغيرات البيئة
ENV DISPLAY=:99
ENV CHROME_BIN=/usr/bin/google-chrome
ENV CHROMEDRIVER_PATH=/usr/local/bin/chromedriver

# تحديد مجلد العمل
WORKDIR /app

# نسخ ملفات المشروع وتثبيت الحزم
COPY package.json package-lock.json ./
RUN npm install
COPY . .

# فتح البورت 4444
EXPOSE 4444

# تشغيل السيرفر
CMD ["node", "server.js"]
