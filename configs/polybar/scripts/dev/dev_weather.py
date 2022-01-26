#!/usr/bin/env python

from configparser import ConfigParser
from uszipcode import SearchEngine
import subprocess
import argparse
import requests
import logging
import json
import time
import os
import re

conf_path = os.environ.get("HOME") + "/.config/polybar/scripts/dev/"
conf_file = conf_path + "py_scripts_dev.conf"
cache_file = conf_path + "py_weather_dev.cache"

class weather_CONFIG():
    def __init__(self):
        if not os.path.exists(conf_path):
            os.makedirs(conf_path)
        if not os.path.exists(cache_file):
            open(cache_file, 'a').close()
        if not os.path.exists(conf_file):
            cp.add_section('weather')
            cp.set('weather', 'use_geoloc', 'true')
            cp.set('weather', 'zipcode', '10001')
            cp.set('weather', 'cache_ageout', '900')
            cp.set('weather', 'forecast_type', 'short')
            with open(conf_file, 'w') as configfile:
                cp.write(configfile)
            logging.debug("WRITING: " + conf_file)
        cp.read(conf_file)
        self.use_geoloc = cp.getboolean('weather', 'use_geoloc')
        self.fc_type = cp.get('weather', 'forecast_type')
        self.cache_ageout = cp.get('weather', 'cache_ageout')
        self.zipcode = cp.get('weather', 'zipcode')

        def debug_config():
            logging.getLogger().setLevel(logging.DEBUG)
            logging.debug("---START CONFIG---")
            logging.debug("conf_file: " + conf_file)
            logging.debug("cache_file: " + cache_file)
            logging.debug("zipcode: " + self.zipcode)
            logging.debug("cache_ageout: " + self.cache_ageout)
            logging.debug("forecat_type: " + self.fc_type)
            if self.use_geoloc:
                logging.debug("use_geoloc: true")
            else:
                logging.debug("use_geoloc: false")
            logging.debug("---END CONFIG---")
        if args.verbose:
            debug_config()
        
        def getconfig(self):
            print(self.use_geoloc, self.fc_type, self.cache_ageout, self.zipcode)
            return [self.use_geoloc, self.fc_type, self.cache_ageout, self.zipcode]
 #       get_weather(use_geoloc, fc_type, cache_ageout, zipcode)

def get_weather(use_geoloc, fc_type, cache_ageout, zipcode):
    print(use_geoloc)
        
#    def url(location):
#        logging.debug("WEATHER.GOV ENTRY URL: https://api.weather.gov/points/%s" % location)    
#        fc_url = ("https://api.weather.gov/points/{0}").format(location)
#        response = fc_url_response(fc_url)
#        json = response.json()
#        fc_url = json["properties"]["forecast"]
#        loc = json["properties"]["relativeLocation"]["properties"]["city"] + ", " + json["properties"]["relativeLocation"]["properties"]["state"]
#        logging.debug("WEATHER.GOV FORECAST URL: " + fc_url)    
#        logging.debug("WEATHER.GOV FORECAST LOCATION: " + loc)    
#        return [fc_url, loc];
#    
#    def fc_url_response(fc_url):
#        logging.debug("TESTING URL : " + fc_url)
#        response = requests.get(fc_url)
#        try:
#            response.raise_for_status()
#        except requests.exceptions.HTTPError as e:
#            logging.debug(e)
#            return False
#        else:
#            return response


def arg_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument("-v", "--verbose", help="enable verbose logging", action="store_true")
    parser.add_argument("-t", "--toggle-fc-type", help="toggle between short and long forecast", action="store_true")
    parser.add_argument("-n", "--notify-5day", help="send 5 day forecast to send-notfiy", action="store_true")
    args = parser.parse_args()
    return args


def cache_refresh(cache_ageout):
    current_time = int(time.time())
    cache_mod = int(os.stat(cache_file).st_mtime)
    conf_mod = int(os.stat(conf_file).st_mtime)
    logging.debug("CURRENT TIME: " + str(current_time))
    logging.debug("CONF AGE: " + str(current_time - conf_mod))
    logging.debug("CACHE AGE: " + str(current_time - cache_mod))
    if (current_time - conf_mod) == "0":
        logging.debug("Conf file is NEW! REFRESHING")
        logging.debug(conf + "is 0")
    elif (current_time - conf_mod) < (current_time - cache_mod):
        logging.debug("Conf file is newer than Cache file!! REFRESHING ")
    elif (current_time - cache_mod) > int(cache_ageout):
        logging.debug("Cache file is older than " + cache_ageout + "!! REFRESHING ")
    elif (current_time - cache_mod) < int(cache_ageout):
        logging.debug("Cache file is newer than " + cache_ageout + " EXITING")
        return False
    return True

## ICONS
def fc_get_icon(icon, isDaytime):
    icon = re.findall(r"\/icons\/.*\/.*\/([^,\?]*)", icon)[0]
    if isDaytime:
        icons = { "skc": "", "few": "", "sct": "", "bkn": "", "ovc": "", "wind_skc": "", "wind_few": "", "wind_sct": "", "wind_bkn": "", "wind_ovc": "", "snow": "", "rain_snow": "", "rain_sleet": "", "snow_sleet": "", "fzra": "", "rain_fzra": "", "snow_fzra": "", "sleet": "", "rain": "", "rain_showers": "", "rain_showers_hi": "", "tsra": "", "tsra_sct": "", "tsra_hi": "", "tornado": "", "hurricane": "", "tropical_storm": "", "dust": "", "smoke": "", "haze": "", "hot": "", "cold": "", "blizzard": "", "fog": "" }
    else:
        icons = { "skc": "", "few": "", "sct": "", "bkn": "", "ovc": "", "wind_skc": "", "wind_few": "", "wind_sct": "", "wind_bkn": "", "wind_ovc": "", "snow": "", "rain_snow": "", "rain_sleet": "", "snow_sleet": "", "fzra": "", "rain_fzra": "", "snow_fzra": "", "sleet": "", "rain": "", "rain_showers": "", "rain_showers_hi": "", "tsra": "", "tsra_sct": "", "tsra_hi": "", "tornado": "", "hurricane": "", "tropical_storm": "", "dust": "", "smoke": "", "haze": "", "hot": "", "cold": "", "blizzard": "", "fog": "" }
    return icons.get(icon, "?")

def fc_get_windicon(windSpeed, windDir):
    windSpeed = re.match(r"^(\d+)", windSpeed)
    speedIcons = { "0": "0", "1": "1", "2": "2", "3": "3", "4": "4", "5": "5", "6": "6", "7": "7", "8": "8", "9": "9", "10": "10", "11": "11", "12": "12" }
#    dirIcons = { ("N", "NNE", "NNW"): "", "NE": "", ("E", "ENE", "ESE"): "", "SE": "", ("S", "SSE", "SSW"): "", "SW": "", ("W", "WSW", "WNW"): "", "NW": "" }
    dirIcons = { ("N", "NNE", "NNW"): "⭣", "NE": "⭩", ("E", "ENE", "ESE"): "⭠", "SE": "🡔", ("S", "SSE", "SSW"): "⭡", "SW": "⭧", ("W", "WSW", "WNW"): "⭢", "NW": "⭨" }
    windSpeed = speedIcons.get(windSpeed.group(0))
    windDir = next(v for k, v in dirIcons.items() if windDir in k)
    opts = windSpeed,windDir
    icon = "{0[0]}mph {0[1]}".format(opts)
    return icon


# def location(zipcode, use_geoloc):
#     if use_geoloc:
#         logging.debug("use_geoloc: true")
#         location = requests.get('https://ipinfo.io/json')
#         json = location.json()
#         location = json['loc']
#     else:
#         logging.debug("use_geoloc: true")
#         search = SearchEngine()
#         zip = search.by_zipcode(zipcode).to_dict()
#         latlong = zip['lat'],zip['lng']
#         location = ("{0[0]},{0[1]}").format(latlong)

def forecast_5day(use_geoloc, zipcode):
    get_weather(use_geoloc, zipcode)
    #isDaytime = fcjson["properties"]["periods"][0]["isDaytime"]
    #upcoming = fcjson["properties"]["periods"][0]["name"]
    #temp = str(fcjson["properties"]["periods"][0]["temperature"]) + "°F"
    #detailedForecast = fcjson["properties"]["periods"][0]["detailedForecast"]
    #icon = fc_get_icon(fcjson["properties"]["periods"][0]["icon"], isDaytime)
    #options = loc,upcoming, temp, icon, detailedForecast
    #forecast = "{0[0]}\n\n{0[1]} - {0[2]} {0[3]}\n{0[4]}".format(options)
    #subprocess.Popen(['notify-send', "-t", "100000", forecast])

if __name__ == "__main__":
    cp = ConfigParser()
    args = arg_parser()
    weather_CONFIG()
    
#    if args.notify_5day:
#        print(weather_CONFIG())
#        exit()
