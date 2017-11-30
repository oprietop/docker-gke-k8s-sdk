#!/bin/sh

if [ -d /root/keys ] ; then
    cd /root/keys
    KEYS=`ls -1 *json`
    i=0
    echo "$KEYS" | while read LINE; do
        i=`expr $i + 1`
        echo -e "[$i] $LINE"
    done
    
    i=`echo "$KEYS" | wc -l`
    
    while true; do
        echo "Choose a accunt file: 1 - $i:"
        read -r choice
        [ $choice -ge 1 ] && [ $choice -le $i ] && break
    done
    ACCOUNT=`echo "$KEYS" | sed "s/ .*//;${choice}q;d"`
    echo "Using account: $ACCOUNT"
    gcloud auth activate-service-account --key-file $ACCOUNT
else
    echo "Got no keys dir, leaving..."
    exit 1
fi

LIST=`gcloud projects list | grep -v PROJECT_ID`
if [ -n "$LIST" ]; then
    i=0
    echo "$LIST" | while read LINE; do
        i=`expr $i + 1`
        echo -e "[$i] $LINE"
    done
    
    i=`echo "$LIST" | wc -l`
    
    while true; do
        if [ $i -eq 1 ]; then
            choice=1
            break
        fi
        echo "Choose a project: 1 - $i:"
        read -r choice
        [ $choice -ge 1 ] && [ $choice -le $i ] && break
    done
    
    PROJECT=`echo "$LIST" | sed "s/ .*//;${choice}q;d"`
    echo "Using project: $PROJECT"
    gcloud config set project $PROJECT
else
    echo "Got no projects."
fi

CLUSTERS=`gcloud container clusters list | grep RUNNING`
if [ -n "$CLUSTERS" ]; then
    i=0
    echo "$CLUSTERS" | while read LINE; do
        i=`expr $i + 1`
        [ -n $PROJECT_ID ] && echo -e "[$i] $LINE"
    done
    
    i=`echo "$CLUSTERS" | wc -l`
    while true; do
        if [ $i -eq 1 ]; then
            choice=1
            break
        fi
        echo "Choose a cluster: 1 - $i:"
        read -r choice
        [ $choice -ge 1 ] && [ $choice -le $i ] && break
    done
    
    LINE=`echo "$CLUSTERS" | sed "s/ \+/ /g;${choice}q;d"`
    CLUSTER=`echo "$LINE" | cut -d" " -f1`
    ZONE=`echo "$LINE" | cut -d" " -f2`
    echo "Using cluster: '$CLUSTER' from zone: '$ZONE'"
    gcloud container clusters get-credentials $CLUSTER --zone $ZONE --project $PROJECT
else
    echo "Project has no clusters."
fi

echo "Launching a shell:"
cd
sh
