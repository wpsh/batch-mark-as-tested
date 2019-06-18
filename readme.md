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


## Credits

Created by [Kaspars Dambis](https://kaspars.net).
