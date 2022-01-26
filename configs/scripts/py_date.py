#!/bin/python

from configparser import ConfigParser
import argparse
import os
import datetime
import subprocess
import calendar

def sendmessage(message):
    subprocess.Popen(['notify-send', "-t", "10000", message])

def thecal():
    m = int(d.now().strftime("%-m"))
    y = int(d.now().strftime("%Y"))
    message = calendar.month(y,m)
    return message

def thedate(config):
    if config['format']  == "date":
        result = d.now().strftime("%a, %b %d ")
        cp.set('general', 'format', "clock")
        with open(config_path, 'w') as config_file:
            cp.write(config_file)
        return result
    else:
        result = d.now().strftime("%-I:%M:%S, %a %p")
        return result

# set config path
home_dir = os.getenv("HOME")
config_path = ("%s/.config/py_conf/py_date.conf" % home_dir)
if not os.path.exists("%s/.config/py_conf" % home_dir):
    os.makedirs("%s/.config/py_conf" % home_dir)

parser = argparse.ArgumentParser()
parser.add_argument("-t", "--toggle-thedate", help="toggle date display from clock to date", action="store_true")
parser.add_argument("-n", "--notify-send", help="send notification", action="store_true")

args = parser.parse_args()
cp = ConfigParser()
d = datetime.datetime.now()

# create default config
if not os.path.exists("%s/.config/py_conf/py_date.conf" % home_dir):
    cp.add_section('general')
    cp.set('general', 'format', 'date')
    with open('config_path', 'w') as configfile:
        cp.write(configfile)

cp.read(config_path)
config = {
        'format': cp.get('general', 'format')
        }

if args.notify_send:
    message = thecal()
    sendmessage(message)

if args.toggle_thedate:
    if config['format'] == "date":
        config['format'] = "clock"
        cp.set('general', 'format', "clock")
    elif config['format'] == "clock":
        config['format'] = "date"
        cp.set('general', 'format', "date")
    with open(config_path, 'w') as config_file:
        cp.write(config_file)

    result = thedate(config)

result = thedate(config)
print(result)
