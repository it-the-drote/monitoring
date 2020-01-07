#!/usr/bin/env bash

memory_usage=`free | grep Mem | awk '{print $3/$2 * 100.0}'`

rrdtool update /var/storage/wastebox/operations/memory_usage.rrd N:${memory_usage}

echo "GRAPH - see https://status.rcmd.space/builds/operations/memory_usage.png"