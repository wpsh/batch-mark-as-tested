# Batch Mark as Tested for WordPress Plugins

[![Build Status](https://travis-ci.com/wpsh/batch-mark-as-tested.svg?branch=master)](https://travis-ci.com/wpsh/batch-mark-as-tested)

A simply bash script to update the "Tested up to" version of all your plugins.

## Requirements

- Subversion client
- Bash
- sed, grep and awk


## Usage

    ./src/mark.sh plugin-slug,another-plugin-slug 5.2

where `plugin-slug,another-plugin-slug` is a comma-seperated list of plugin slugs to update and `5.2` is the WordPress version number to use.

It does a checkout of each plugin in the `src/plugins/plugin-name` directory, finds the stable tag in `trunk/readme.txt` and replaces the `Tested up to:` string in the readme of either `trunk/readme.txt` or the tagged `tags/1.2.3/readme.txt`. It shows a diff of the change before prompting for a commit confirmation.


## Credits

Created by [Kaspars Dambis](https://kaspars.net).
