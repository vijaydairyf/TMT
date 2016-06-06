#!/bin/bash
#Black        0;30     Dark Gray     1;30
#Blue         0;34     Light Blue    1;34
#Green        0;32     Light Green   1;32
#Cyan         0;36     Light Cyan    1;36
#Red          0;31     Light Red     1;31
#Purple       0;35     Light Purple  1;35
#Brown/Orange 0;33     Yellow        1;33
#Light Gray   0;37     White         1;37

RC='\033[0;31m'  #Red color
GC='\033[0;32m'  #Green color
NC='\033[0m'     # No Color

# Config file path and name.
CONFIG_FILE=`pwd`/config
# Read config file data.
source "$CONFIG_FILE"

DATA_SCHEME=$DATA_SCHEME$VERSION
SOURCE_SCHEME=TIMETABLE_DATA


if [ $PASSWORD ]
then
  CONNECT_STRING=$USERNAME/$PASSWORD@$TNS$CONNECT_MODE
else
  CONNECT_STRING=$USERNAME@$TNS$CONNECT_MODE
fi


echo
echo -e "Source scheme name: ${GC}"$SOURCE_SCHEME"${NC}"
echo -e "  Data scheme name: ${GC}"$DATA_SCHEME"${NC}"
echo
echo -e " Check parameters (${RC}Ctrl-C to break${NC})"
read
echo

export NLS_LANG=.UTF8

sqlplus $CONNECT_STRING @move-data.sql $SOURCE_SCHEME $DATA_SCHEME

export GREP_COLORS="sl=1;31"
grep --color=always -e "ORA-" -e "PLS-" -e "SP2-" ./logs/move-data-installation.log
