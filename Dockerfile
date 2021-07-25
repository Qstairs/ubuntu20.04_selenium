FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y tzdata vim python3-pip wget curl unzip

# timezone setting
ENV TZ=Asia/Tokyo 

# chrome browser
RUN wget https://www.slimjet.com/chrome/download-chrome.php?file=files%2F76.0.3809.100%2Fgoogle-chrome-stable_current_amd64.deb -O google-chrome-stable_current_amd64.deb
RUN apt install -y fonts-liberation libappindicator3-1 libatk-bridge2.0-0 libatk1.0-0 libatspi2.0-0 libcairo2 libcups2 libdbus-1-3
RUN apt install -y libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 libx11-6 libx11-xcb1
RUN apt install -y libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 lsb-release xdg-utils
RUN dpkg -i --force-depends google-chrome-stable_current_amd64.deb || apt-get install -f -y

# chrome driver
RUN curl -OL https://chromedriver.storage.googleapis.com/76.0.3809.126/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip chromedriver
RUN mv chromedriver /usr/bin/chromedriver

# font
RUN apt-get -qqy update \
    && apt-get -qqy --no-install-recommends install \
    libfontconfig \
    libfreetype6 \
    xfonts-cyrillic \
    xfonts-scalable \
    fonts-liberation \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
    fonts-tlwg-loma-otf

# anaconda
RUN wget -P /opt https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh
RUN bash /opt/Anaconda3-2021.05-Linux-x86_64.sh -b
RUN rm /opt/Anaconda3-2021.05-Linux-x86_64.sh
ENV PATH $PATH:/root/anaconda3/bin
RUN echo "export PATH=/root/anaconda3/bin:$PATH" >> ~/.bashrc
RUN conda init

COPY . .

RUN conda env create --file py38env.yaml

CMD ["/bin/bash"]
