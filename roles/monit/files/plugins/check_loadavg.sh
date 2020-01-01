#!/usr/bin/env bash

loadavg=`cat /proc/loadavg | awk '{print $2}'`

rrdtool update /var/storage/wastebox/operations/loadavg_5min.rrd N:${loadavg}