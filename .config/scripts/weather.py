#!/bin/python

## need api key from ipstack.com defind as geo_key
## will make configurable with zip
## fonts are nerd-fonts-complete

from urllib.parse import urlparse
from configparser import ConfigParser
import argparse
import os
import requests
import json
import subprocess
import logging
import re
import time

logging.getLogger().setLevel(logging.WARNING)

def get_icon(icon, isDaytime):
   if isDaytime == 'false':
       parsed = urlparse(icon).path
       icon = re.search('[^/]+$', parsed)
       icon = icon.group(0)
       icon = re.sub(r',.*', '', icon)
       icons = {
                "skc": "",
                "few": "",
                "sct": "",
                "bkn": "",
                "ovc": "",
                "wind_skc": "",
                "wind_few": "",
                "wind_sct": "",
                "wind_bkn": "",
                "wind_ovc": "",
                "snow": "",
                "rain_snow": "",
                "rain_sleet": "",
                "snow_sleet": "",
                "fzra": "",
                "rain_fzra": "",
                "snow_fzra": "",
                "sleet": "",
                "rain": "",
                "rain_showers": "",
                "rain_shows_hi": "",
                "tsra": "",
                "tsra_sct": "",
                "tsra_hi": "",
                "tornado": "",
                "hurricane": "",
                "tropical_storm": "",
                "dust": "",
                "smoke": "",
                "haze": "",
                "hot": "",
                "cold": "",
                "blizzard": "",
                "fog": "",
                }
       result = str(icons.get(icon, "?"))
       return result
   else:
       parsed = urlparse(icon).path
       icon = re.search('[^/]+$', parsed)
       icon = icon.group(0)
       icon = re.sub(r',.*', '', icon)
       icons = {
                "skc": "",
                "few": "",
                "sct": "",
                "bkn": "",
                "ovc": "",
                "wind_skc": "",
                "wind_few": "",
                "wind_sct": "",
                "wind_bkn": "",
                "wind_ovc": "",
                "snow": "",
                "rain_snow": "",
                "rain_sleet": "",
                "snow_sleet": "",
                "fzra": "",
                "rain_fzra": "",
                "snow_fzra": "",
                "sleet": "",
                "rain": "",
                "rain_showers": "",
                "rain_shows_hi": "",
                "tsra": "",
                "tsra_sct": "",
                "tsra_hi": "",
                "tornado": "",
                "hurricane": "",
                "tropical_storm": "",
                "dust": "",
                "smoke": "",
                "haze": "",
                "hot": "",
                "cold": "",
                "blizzard": "",
                "fog": "",
                }
       result = str(icons.get(icon, "?"))
       return result

def wind_direction(winddir):
    icons = { 
            'N': "⭣",
            'NE': "⭩",
            'E': "⭠",
            'SE':"⭦",
            'S' : "⭡",
            'SW': "⭧",
            'W' :"⭢",
            'NW':"⭨"
            }
    winddir = icons.get(winddir)
    return winddir

def sendmessage(message):
    subprocess.Popen(['notify-send', "-t", "10000", message])
    return

def get5day(day):
    forecast = (get_geo())
    forecast = requests.get(forecast)
    forecast = json.loads(forecast.text)
    title = forecast["properties"]["periods"][day]["name"]
    isDaytime = forecast["properties"]["periods"][day]["isDaytime"]
    icon = get_icon(forecast["properties"]["periods"][day]["icon"], isDaytime)
    desc = forecast["properties"]["periods"][day]["detailedForecast"]
    temp = forecast["properties"]["periods"][day]["temperature"]
    message = ("%s %s\nH:%s - L: \n%s" % (title, icon, temp, desc))
    return message

def get_weather(config):
    if config['forecast_type'] == "short":
        forecast = (get_geo() + "/hourly")
        forecast = requests.get(forecast)
        forecast = json.loads(forecast.text)
    
        # set variables
        isDaytime = forecast["properties"]["periods"][0]["isDaytime"]
        icon = get_icon(forecast["properties"]["periods"][0]["icon"], isDaytime)
        temp = forecast["properties"]["periods"][0]["temperature"]
        info = forecast["properties"]["periods"][0]["shortForecast"]
        result = ("%s°F %s %s" % (temp, icon, info))
    elif config['forecast_type'] == "long":
        forecast = (get_geo())
        forecast = requests.get(forecast)
        forecast = json.loads(forecast.text)
    
        # set variables
        isDaytime = forecast["properties"]["periods"][0]["isDaytime"]
        icon = get_icon(forecast["properties"]["periods"][0]["icon"], isDaytime)
        temp = forecast["properties"]["periods"][0]["temperature"]
        info = forecast["properties"]["periods"][0]["shortForecast"]
        title = forecast["properties"]["periods"][0]["name"]
        windspd = forecast["properties"]["periods"][0]["windSpeed"]
        windicon = wind_direction(forecast["properties"]["periods"][0]["windDirection"])
        winddir = forecast["properties"]["periods"][0]["windDirection"]
        result = ("%s: %s°F %s %s      %s %s" % (title, temp, icon, info, windspd, windicon))
    with open(cache_path, 'w') as cache_file:
        logging.debug("Writing cache.")
        cache_file.write(result)
    return result 

def get_geo():
    # get geo location based on IP
    # finds forecastOffice from weather.gov
    geo_key = ""
    get_ip = requests.get('https://api.ipify.org?format=json')
    json_ip = json.loads(get_ip.text)
    ip = json_ip["ip"]

    # get current GeoLocation
    json_geo = requests.get("http://api.ipstack.com/%s?access_key=%s" % (ip, geo_key))
    json_geo = json.loads(json_geo.text)
    geo_lat = json_geo["latitude"]
    geo_long = json_geo["longitude"]
    geo_loc = ("%s,%s" % (geo_lat, geo_long))
    
    # get forecastOffice URL
    geo_base = requests.get("https://api.weather.gov/points/%s" % geo_loc)
    geojson = json.loads(geo_base.text)
    geolocation = geojson["properties"]["forecast"]    

    return geolocation

parser = argparse.ArgumentParser()
parser.add_argument("-t", "--toggle-forecast", help="toggle between 5 day and current", action="store_true")
parser.add_argument("-v", "--verbose", help="enable verbose logging", action="store_true")
parser.add_argument("-n", "--notify-send", help="send", action="store_true")

args = parser.parse_args()

if args.verbose:
    logging.getLogger().setLevel(logging.DEBUG)

home_dir = os.getenv("HOME")
config_path = ("%s/.config/utfweather/utfweather.conf" % home_dir)
cache_path = ("%s/.cache/utfweather/utfweather.cache" % home_dir)

# load config file
cp = ConfigParser()
cp.read(config_path)

logging.debug("Loaded the following settings:")
logging.debug(dict(cp.items('general')))

config = {
        'forecast_type': cp.get('general', 'forecast_type'),
        'cache_ageout': cp.get('general', 'cache_ageout')
        }

if args.notify_send:
    for day in range(1,10, 2):
        message = get5day(day)
        sendmessage(message)
    exit

if args.toggle_forecast:
    if config['forecast_type'] == "short":
        config['forecast_type'] = "long"
        cp.set('general', 'forecast_type', "long")
    elif config['forecast_type'] == "long":
        config['forecast_type'] = "short"
        cp.set('general', 'forecast_type', "short")

    logging.debug("Writing the following settings:")
    logging.debug(dict(cp.items('general')))

    with open(config_path, 'w') as config_file:
        cp.write(config_file)

    get_weather(config)

else:
    # check if cache exists and is current
    if os.path.exists(cache_path):
        mod_time = int(os.stat(cache_path).st_mtime)
        current_time = int(time.time())
        cache_age = current_time - mod_time

        logging.debug("Mod Time: " + str(mod_time))
        logging.debug("Current Time: " + str(current_time))
        logging.debug("Cache Age: " + str(cache_age))

        if cache_age > int(config["cache_ageout"]):
            logging.debug("Cache old.. Getting current weather..")
            result = get_weather(config)

        else:
            with open(cache_path, 'r') as cache_file:
                logging.debug("Reading cache.")
                result = cache_file.read()
    else:
        result = get_weather(config)

    print(result)
