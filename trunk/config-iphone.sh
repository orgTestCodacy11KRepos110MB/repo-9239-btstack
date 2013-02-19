#!/bin/sh
echo "Configure BTstack for use with iOS using the theos build system"

# check if $THEOS is set

# remove autoconf created files
rm -f config.h Makefile src/Makefile example/Makefile

# use theos Makefiles
ln -s config-iphone.h config.h
ln -s Makefile.iphone Makefile
ln -s Makefile.iphone src/Makefile
ln -s Makefile.iphone example/Makefile
