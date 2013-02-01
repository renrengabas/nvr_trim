#!/bin/bash

# TrimVidTree
#   Deletes old NVR recordings according to a set day on the
#   identified cameras
#
# Maintainer:
#   Rainier Gabas - renrengabas@diffsigma.com
#   diff sigma tech inc
#
# Version:
#   1.0 - 2013-02-01

# CONFIG
NVR_BASEDIR="/home/rainier/airvision-nvr/events"
NVR_MAXDAYRECORD="2"
NVR_CAMERAS="1 2 3"


# IMPLEMENTATION

# Check that the base directory has been set properly
if [ ! -d $NVR_BASEDIR ]
    then
        echo "NVR_BASEDIR does not exist!"
        exit 0
fi

# Record the target year, month and day
TARGET_YEAR=`date -d "now -$NVR_MAXDAYRECORD days" +%y`
TARGET_MONTH=`date -d "now -$NVR_MAXDAYRECORD days" +%m`
TARGET_DAY=`date -d "now -$NVR_MAXDAYRECORD days" +%d`

# Look for the targets and delete the contents
for CAMERA in $NVR_CAMERAS
do
    rm -rf $NVR_BASEDIR/$CAMERA/$TARGET_YEAR/$TARGET_MONTH/$TARGET_DAY
    find $NVR_BASEDIR/$CAMERA -type d -empty -exec rmdir {} \;
    find $NVR_BASEDIR/$CAMERA -type d -empty -exec rmdir {} \;
done


