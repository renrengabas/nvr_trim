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
NVR_MAXDAYRECORD="10"
NVR_ZERODAY="100"
NVR_CAMERAS="1 2"
LOG_FILE="/var/log/trimvideotree"


# IMPLEMENTATION
if [ ! -f $LOG_FILE ]
    then
        echo "No log file available: $LOG_FILE"
        exit 0
fi

# Check that the base directory has been set properly
if [ ! -d $NVR_BASEDIR ]
    then
        echo "`date`: NVR_BASEDIR does not exist!"
        exit 0
fi

# From "zero day" up to day-NVR_MAXDAYRECORD
for (( DAY=NVR_ZERODAY; DAY>NVR_MAXDAYRECORD ; DAY-- ))
do
    # Record the target year, month and day
    TARGET_YEAR=`date -d "now -$DAY days" +%y`
    TARGET_MONTH=`date -d "now -$DAY days" +%m`
    TARGET_DAY=`date -d "now -$DAY days" +%d`

    echo "`date`: Deleting records for $TARGET_YEAR-$TARGET_MONTH-$TARGET_DAY" >> $LOG_FILE

    # Look for the targets and delete the contents
    for CAMERA in $NVR_CAMERAS
    do
        rm -rf $NVR_BASEDIR/$CAMERA/$TARGET_YEAR/$TARGET_MONTH/$TARGET_DAY
        find $NVR_BASEDIR/$CAMERA/. -type d -empty -exec rmdir {} \;
    done
done
