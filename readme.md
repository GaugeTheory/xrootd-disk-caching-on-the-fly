# XRootD Disk Cache Local Access

## Description
An XRootD - Vagrant setup using multiple XRootD plug-ins to implement fast access for clients to an XRootD Cache sitting on top of a shared filesystem.

## Usage
- git clone https://git.gsi.de/atay/xrootd-disk-caching-on-the-fly.git -b direct-mode_dca
- cd xrootd-disk-caching-on-the-fly
- vagrant up --provision
- vagrant ssh client
- cd /tmp
- ./proxyprefixtest.sh
Note that the file exists locally per default. To test the case of it not being available, remove /tmp/shfs/Testfile.test.

## Procedure explanation
The client wants to copy a file from an external dataserver to the local filesystem:
- The client employs a plug-in, which replaces the address of the cachingproxy.
- The client then connects to the cachingproxy, which checks for existence of the searched file on the shared filesystem
	- if the file exists, the client gets redirected to the shared filesystem, where it opens the file locally without involvement of any other server
	- if the file does not exist, the client gets redirected to the cachingproxy
		-the client now connects to the cachingproxy, which opens a connection to the externalDataserver
		-the file gets returned to the client and is simultaneously cached by the proxy on the shared filesystem

## Used plug-ins
There are two plug-ins being used:
- XrdProxyPrefix: https://github.com/GaugeTheory/XrdProxyPrefix/tree/kit-proj_v2
	- used by the client.
	- prefixes the configured cachingproxy, so the outgoing request is first sent to the cachingproxy

## Configuration
The credentials.yml file needs to be edited. For the basic functionality, nothing needs to be changed.
An exemplary list of important configurations:
- The cachingproxy needs the cache location:
	- oss.localroot /tmp/shfs
- The client plugin for the proxy prefix needs the prefix in XrdProxyDefault.conf
	- proxyPrefix=://192.168.60.202:1094/
