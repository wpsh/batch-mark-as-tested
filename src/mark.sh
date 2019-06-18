#!/bin/bash

PLUGINS="$1"
LATESTVERSION="$2"
SRCDIR=$(dirname "$0")

if [ -z "$PLUGINS" ]; then
	echo "Please specify a list of comma-seperated plugin slugs that you want to update as the first argument to this script."
	exit 1
fi

if [ -z "$LATESTVERSION" ]; then
	echo "Please specify the WordPress version string to use as the second argument."
	exit 1
fi

IFS=',' read -ra PLUGINSLUGS <<< "$PLUGINS"

for PLUGINSLUG in "${PLUGINSLUGS[@]}"; do
	svn checkout "https://plugins.svn.wordpress.org/$PLUGINSLUG" "$SRCDIR/plugins/$PLUGINSLUG"

	READMETOUPDATE="$SRCDIR/plugins/$PLUGINSLUG/trunk/readme.txt"

	if [ -f "$READMETOUPDATE" ]; then
		VERSION_TRUNK=$(grep "^Stable tag:" "$READMETOUPDATE" | awk -F' ' '{print $NF}')

		# Update only the current stable version.
		if [ "trunk" != "$VERSION_TRUNK" ]; then
			READMETOUPDATE="$SRCDIR/plugins/$PLUGINSLUG/tags/$VERSION_TRUNK/readme.txt"
		fi

		# Update the tested up to tag.
		sed -i "" "s/^Tested up to:.*/Tested up to: $LATESTVERSION/" "$READMETOUPDATE"

		# Show a diff of change for confirmation.
		svn diff "$SRCDIR/plugins/$PLUGINSLUG"

		# Confirm if we should commit the change.
		read -r -p "Commit the change? [y/N] " CONFIRMCOMMIT

		if [ "y" == "$CONFIRMCOMMIT" ]; then
			svn commit --message "Mark as tested with WordPress $LATESTVERSION" "$SRCDIR/plugins/$PLUGINSLUG"
		else
			echo "Commit aborted."
		fi
	else
		echo "Failed to find a readme.txt file in $SRCDIR/plugins/$PLUGINSLUG/trunk/readme.txt."
	fi
done

