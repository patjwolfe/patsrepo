def scrape():

        # # Mission to Mars

        from splinter import Browser
        from bs4 import BeautifulSoup


        executable_path = {'executable_path': '/usr/local/bin/chromedriver'}
        browser = Browser('chrome', **executable_path, headless=False)

        url = 'https://mars.nasa.gov/news/'
        browser.visit(url)

        html = browser.html
        soup = BeautifulSoup(html, 'html.parser')
        #print(soup.prettify())

        html = browser.html
        soup = BeautifulSoup(html, 'html.parser')
        articles = soup.find_all('li', class_='slide')
        mars_text = {}

        for article in articles:
                link = article.find('a')
                href = link['href']
                
                nasa_title = article.find('div', class_='content_title').text
                print(nasa_title)
                
                nasa_text = article.find('div', class_='article_teaser_body').text
                print(nasa_text)    
                mars_text[nasa_title] = nasa_text





        ### JPL Mars Space Images - Featured Image

        url = 'https://www.jpl.nasa.gov/spaceimages/?search=&category=Mars'
        browser.visit(url)

        html = browser.html
        soup = BeautifulSoup(html, 'html.parser')
        #print(soup.prettify())
        mars_image = {}

        for x in range(2):
                html = browser.html
                soup = BeautifulSoup(html, 'html.parser')
                articles = soup.find_all('section', class_='centered_text clearfix main_feature primary_media_feature single')
        
                for article in articles:
                        featured_image_title = article.find('h1', class_='media_feature_title').text
                        print(featured_image_title)
                        
                        featured_image_url = article.find('a')['data-fancybox-href']
                        featured_image_url = 'https://www.jpl.nasa.gov' + featured_image_url
                        print(featured_image_url)

                        mars_image[featured_image_title] = featured_image_url



        ### Mars Weather
        import json
        import tweepy 
        from pprint import pprint
        import sys
        sys.path.append('..')
        from config import consumer_key, consumer_secret, access_token, access_token_secret

        mars_temp = {}

        auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
        auth.set_access_token(access_token, access_token_secret)
        api = tweepy.API(auth, parser=tweepy.parsers.JSONParser())

        mars_weather = []
        tweets = api.user_timeline(id='MarsWxReport', count=1)
        #pprint(tweets)

        for tweet in tweets:
                mars_weather = tweet['text']
                print(mars_weather)
        
        mars_temp["weather"] = mars_weather
        


        ### Mars Facts
        import pandas as pd
        mars_facts = {}

        url = 'https://space-facts.com/mars/'

        tables = pd.read_html(url)
        fact_table = tables[0]

        fact_table.columns = ["Fact", "Fact"]
        html_table = fact_table.to_html()
        html_table

        mars_facts["table"] = html_table



        ### Mars Hemispheres
        executable_path = {'executable_path': '/usr/local/bin/chromedriver'}
        browser = Browser('chrome', **executable_path, headless=False)

        url = 'https://astrogeology.usgs.gov/search/results?q=hemisphere+enhanced&k1=target&v1=Mars'
        browser.visit(url)

        html = browser.html
        soup = BeautifulSoup(html, 'html.parser')
        #print(soup.prettify())

        mars_urls = {}
        hemisphere_image_urls = []
        hemisphere_url_base = 'https://astrogeology.usgs.gov'

        images = soup.find_all('div', class_='item')

        for image in images:
                # temp_dict = {}
                # hemisphere_url = image.find('a')['href']
                # browser.visit(hemisphere_url_base + hemisphere_url)
                # title = browser.title
                # #title = browser.find_by_css('h2')['title']

                # temp_dict.update({"title": title})    
                # img_url = browser.find_by_text('Sample')['href']
                # temp_dict.update({"img_url": img_url})
                # browser.back()
                # hemisphere_image_urls.append(temp_dict.copy())

                hemisphere_url = image.find('a')['href']
                browser.visit(hemisphere_url_base + hemisphere_url)
                title = browser.title

                img_url = browser.find_by_text('Sample')['href']
                browser.back()
                mars_urls[title] = img_url
        
        return mars_text, mars_image, mars_temp, mars_facts, mars_urls



