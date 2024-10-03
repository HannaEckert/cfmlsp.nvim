#!/usr/bin/bash

currentDirectory=$(cd $(dirname "$0") >/dev/null 2>&1; pwd -P)

downloadUrl=$(
	curl -s https://marketplace.visualstudio.com/items/com-adobe-coldfusion.adobe-cfml-lsp/changelog | \
	grep version | head -n1 | sed -r 's/.*"(.*\.VSIXPackage)".*/\1/'
)

if [ "x" = "x$downloadUrl" ] ; then
	echo "Unable to retrieve cfml builder download url."
	exit 1
fi

# Find latest ColdFusion Builder Version:
latestVersion=$(echo $downloadUrl | sed -r 's/.*\/adobe-cfml-lsp\/([0-9.]*)\/.*/\1/')

currentVersion="0"
currentVersionInfoFile="$currentDirectory/lsp.version"
if [ -f $currentVersionInfoFile ] ; then
	currentVersion=$(cat $currentDirectory/lsp.version)
fi

if [ $latestVersion = $currentVersion ] ; then
	exit 0
fi

extensionFile="$currentDirectory/extension.zip"

# Download latest ColdFusion Builder Package:
wget $downloadUrl -O "$extensionFile" 1>/dev/null 2>/dev/null

if [ ! -f "$extensionFile" ] ; then
	echo "Unable to download cfml builder extension version $latestVersion."
	exit 1
fi

libs=$(unzip -l "$extensionFile" | grep .jar | sed -r "s/.* (.*)$/\1/")

if [ "x" = "x$libs" ] ; then
	echo "Could not find any suitable jars within the cfml builder extension."
	rm $extensionFile
	exit 1
fi

# Reset the target lib folder
targetLibFolder="$currentDirectory/lib"
if [ -d "$targetLibFolder" ] ; then
	rm -r "$targetLibFolder"
	mkdir "$targetLibFolder"
fi

# Extract the lsp libs:
unzip -o -j "$extensionFile" $libs -d "$targetLibFolder" 1>/dev/null 2>/dev/null
rm "$extensionFile" 

echo "$latestVersion" > "$currentVersionInfoFile"
echo "Updated cfml builder: $latestVersion"
