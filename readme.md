# XRootD Disk Cache Local Access

## Description
An XRootD - Vagrant setup using multiple XRootD plug-ins to implement fast access for clients to an XRootD Cache sitting on top of a shared filesystem.
Updated libXrdPfc-5.so which alters the UNIX permission of the cached files to 644 similar to "world" option in dca mode.

## Usage
- git clone https://git.gsi.de/atay/xrootd-disk-caching-on-the-fly.git -b direct-mode_v2
- cd xrootd-disk-caching-on-the-fly
- vagrant up --provision
- vagrant ssh client
- cd /tmp
- ./proxyprefixtest.sh
Note that the file exists locally per default. To test the case of it not being available, remove /tmp/shfs/Testfile.test.

## Procedure explanation
The client wants to copy a file from an external dataserver to the local filesystem:
- The client employs a plug-in, which replaces the address of the redirector/datamanager.
- The client then connects to the redirector, which checks for existence of the searched file on the shared filesystem in the used cms-plugin
	- if the file exists, the client gets redirected to the shared filesystem, where it opens the file locally without involvement of any other server
	- if the file does not exist, the plug-in redirects the client to the cachingproxy
		-the client now connects to the cachingproxy, which opens a connection to the externalDataserver
		-the file gets returned to the client and is simultaneously cached by the proxy on the shared filesystem

## Used plug-ins
There are two plug-ins being used:
- XrdProxyPrefix: https://github.com/GaugeTheory/XrdProxyPrefix/tree/kit-proj_v2
	- used by the client.
	- prefixes the configured datamanager, so the outgoing request is first sent to the datamanager
- RedirLocal: https://github.com/GaugeTheory/RedirPlugin/tree/kit-proj_v2
	- handles the prefixed url
	- determines if the searched for file is available locally
	- redirects to either the cachingproxy or the local filesystem

## Configuration
The credentials.yml file needs to be edited. For the basic functionality, nothing needs to be changed.
An exemplary list of important configurations:
- The forwardproxy needs the cache location:
	- oss.localroot /tmp/shfs
- The manager/redirector needs the cache location:
	- oss.localroot /tmp/shfs
- The client plugin for the proxy prefix needs the prefix in XrdProxyDefault.conf
	- proxyPrefix=://192.168.60.200:1094/
