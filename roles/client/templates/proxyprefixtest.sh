#!/bin/bash

export XRD_PLUGIN="/usr/lib64/XrdProxyPrefix.so"
export XRD_DEFAULT_PLUGIN_CONF="/tmp/XrdProxyDefault.conf"
export XRD_LOGLEVEL="Dump"

xrdcp root://{{extDataserver_ip}}:{{extDataserver_port}}//Testfile.test ./tfile
cat tfile
rm tfile
