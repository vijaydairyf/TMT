#!/bin/bash

RC='\033[0;31m'  #Red color
GC='\033[0;32m'  #Green color
NC='\033[0m'     # No Color

# Config file path and name.
CONFIG_FILE=`pwd`/config
# Read config file data.
source "$CONFIG_FILE"

DATA_SCHEME=$DATA_SCHEME$VERSION

if [ $PASSWORD ]
then
  CONNECT_STRING=$USERNAME/$PASSWORD@$TNS$CONNECT_MODE
else
  CONNECT_STRING=$USERNAME@$TNS$CONNECT_MODE
fi


echo
echo -e " Installing into database: ${GC}"$TNS"${NC}"
echo -e "         Data scheme name: ${GC}"$DATA_SCHEME"${NC}"
echo -e "   Data scheme tablespace: ${GC}"$DATA_SCHEME_TABLESPACE"${NC}"
echo 
echo -e " Check parameters (${RC}Ctrl-C to break${NC})"
read
echo 

export NLS_LANG=.UTF8

sqlplus $CONNECT_STRING @install-data-scheme.sql $DATA_SCHEME $DATA_SCHEME_TABLESPACE $PARUS_SCHEME

export GREP_COLORS="sl=1;31"
grep --color=always -e "ORA-" -e "PLS-" -e "SP2-" ./logs/data-installation.log
