#!/bin/bash
set -e

echo "1/5 What is the name of this instance?"
read INSTANCE_NAME

echo "2/5 Who is maintaining it?"
read INSTANCE_MAINTAINER

echo "3/5 What is the IP of the target server?"
read SERVER_IP
SERVER_IP=${SERVER_IP:-"0.0.0.0"}

echo "4/5 What is the Sendinblue update list id ?"
read SIB_UPDATE_LIST_ID
SIB_UPDATE_LIST_ID=${SIB_UPDATE_LIST_ID:-0}

echo "5/5 What is the Sendinblue update template id ?"
read SIB_UPDATE_TEMPLATE_ID
SIB_UPDATE_TEMPLATE_ID=${SIB_UPDATE_TEMPLATE_ID:-0}

usage() {
  echo "At least instance name and maintainer are needed"
  exit 1
}

if ! test $INSTANCE_NAME || ! test "$INSTANCE_MAINTAINER"
then
  usage
fi  

echo "Replacing variables in template files..."
echo "$\{instanceName\}: ${INSTANCE_NAME}"
echo "$\{instanceMaintainer\}: ${INSTANCE_MAINTAINER}"
echo "$\{serverIp\}: ${SERVER_IP}"
echo "$\{sendinblueUpdateListId\}: ${SIB_UPDATE_LIST_ID}"
echo "$\{sendinblueUpdateTemplateId\}: ${SIB_UPDATE_TEMPLATE_ID}"
IFS=$'\n' # This makes the find method below allow space in file names
TEMPLATE_FILES=$(find templates -type f)
# Use intermediate backup files (`-i`) with a weird syntax due to lack of portable 'no backup' option. See https://stackoverflow.com/q/5694228/594053.
# Credit to https://github.com/openfisca/country-template/blob/master/bootstrap.sh
sed -i.template "s|\${instanceName}|$INSTANCE_NAME|g" $TEMPLATE_FILES
sed -i.template "s|\${instanceMaintainer}|$INSTANCE_MAINTAINER|g" $TEMPLATE_FILES
sed -i.template "s|\${serverIp}|$SERVER_IP|g" $TEMPLATE_FILES
sed -i.template "s|\${sendinblueUpdateListId}|$SIB_UPDATE_LIST_ID|g" $TEMPLATE_FILES
sed -i.template "s|\${sendinblueUpdateTemplateId}|$SIB_UPDATE_TEMPLATE_ID|g" $TEMPLATE_FILES
find . -name "*.template" -type f -delete

echo "Using templates"
shopt -s dotglob # If set, bash includes filenames beginning with a '.' in the results of pathname expansion.
mv templates/* .
rm -Rf templates

echo "🎉 You're all done, congratulations"
echo "Now, just commit the files in Git launching"
echo ""
echo "git add . && git commit -m \"Initiate instance\""
rm init.sh
