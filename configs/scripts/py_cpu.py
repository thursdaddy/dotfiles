#!/usr/bin/python3

from configparser import ConfigParser
import argparse
import math
import os
import subprocess
import psutil
import warnings

warnings.filterwarnings("ignore")

p = psutil

def computer(config):
    if config['format']  == "hide":
        cpu_perc = round(p.cpu_percent(interval=1))
        mem_perc = round(p.virtual_memory().percent)
        mem_used_int = p.virtual_memory().used
        mem_used = round(mem_used_int / 1073741824, 1)
        cpu_temp = round(p.sensors_temperatures()["zenpower"][1][1])
        t = cpu_perc,mem_perc
        result = ' {0[0]}%   {0[1]}%  '.format(t)
        return result
    else:
        cpu_perc = round(p.cpu_percent(interval=1))
        cpu_freq = round(p.cpu_freq().current)
        cpu_temp = round(p.sensors_temperatures()["zenpower"][1][1])
        cpu_load = os.getloadavg()
        mem_perc = round(p.virtual_memory().percent)
        mem_used_int = p.virtual_memory().used
        mem_used = round(mem_used_int / 1073741824, 1)
        t = cpu_perc,cpu_temp,cpu_freq,cpu_load,mem_perc,mem_used
        result = ' {0[2]}   {0[0]}%  {0[3]}   {0[1]}C   {0[4]}% | {0[5]} GB '.format(t)

        return result

# set config path
home_dir = os.getenv("HOME")
config_path = ("%s/.config/py_conf/py_cpu.conf" % home_dir)
if not os.path.exists("%s/.config/py_conf" % home_dir):
    os.makedirs("%s/.config/py_conf" % home_dir)

parser = argparse.ArgumentParser()
parser.add_argument("-t", "--toggle-computer", help="toggle computer info", action="store_true")

args = parser.parse_args()
cp = ConfigParser()

# create default config
if not os.path.exists("%s/.config/py_conf/py_cpu.conf" % home_dir):
    cp.add_section('general')
    cp.set('general', 'format', 'hide')
    with open('config_path', 'w') as configfile:
        cp.write(configfile)

cp.read(config_path)
config = {
        'format': cp.get('general', 'format')
        }

if args.toggle_computer:
    if config['format'] == "display":
        config['format'] = "hide"
        cp.set('general', 'format', "hide")
    elif config['format'] == "hide":
        config['format'] = "display"
        cp.set('general', 'format', "display")
    with open(config_path, 'w') as config_file:
        cp.write(config_file)

    result = computer(config)

result = computer(config)
print(result)
