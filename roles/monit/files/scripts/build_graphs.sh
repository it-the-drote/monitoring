#!/usr/bin/env bash

rrdtool graph /var/www/healthchecks/builds/operations/disk_space.png \
    -w 1024 -h 512 \
    DEF:disk=/var/storage/wastebox/operations/disk_space.rrd:diskspace:AVERAGE \
    LINE2:disk#0000ff:"Disk space"
rrdtool graph /var/www/healthchecks/builds/operations/loadavg_5min.png \
    -w 1024 -h 512 \
    DEF:loadavg=/var/storage/wastebox/operations/loadavg_5min.rrd:loadavg:AVERAGE \
    LINE2:loadavg#0000ff:"Load average for 5 minutes"
rrdtool graph /var/www/healthchecks/builds/operations/memory_usage.png \
    -w 1024 -h 512 \
    DEF:loadavg=/var/storage/wastebox/operations/memory_usage.rrd:memory_usage:AVERAGE \
    LINE2:memory_usage#0000ff:"Memory usage"