import os
import sys
from selenium import webdriver
from selenium.webdriver.chrome.options import Options

if __name__ == "__main__":
    # File Name
    FILENAME = "/tmp/data/screen.png"

    # set driver and url
    options = webdriver.ChromeOptions()
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    driver = webdriver.Chrome(options=options)
    url = 'https://www.google.com/'
    driver.get(url)

    # get width and height of the page
    w = driver.execute_script("return document.body.scrollWidth;")
    h = driver.execute_script("return document.body.scrollHeight;")

    # set window size
    driver.set_window_size(w,h)

    # Get Screen Shot
    driver.save_screenshot(FILENAME)

    # Close Web Browser
    driver.quit()
