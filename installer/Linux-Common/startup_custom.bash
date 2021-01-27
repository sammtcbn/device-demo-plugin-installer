#!/bin/bash

# Custom Section
INS_DIR=/usr/local/EdgeSense/${PROJECT_NAME}
CONF_FOLDER_PATH=${INS_DIR}/config

function install_dependency ()
{
    return
}

function backup_config ()
{
    if [ -d $CONF_FOLDER_PATH ]; then
        echo "backup config ..."
        rm -rf /tmp/${PROJECT_NAME} || exit 1
        cp -rpf $CONF_FOLDER_PATH /tmp/${PROJECT_NAME} || exit 1
        echo "backup config ... done"
    fi
    return
}

function restore_config ()
{
    if [ -d /tmp/${PROJECT_NAME} ]; then
        echo "restore config ..."
        rm -rf $CONF_FOLDER_PATH || exit 1
        cp -rpf /tmp/${PROJECT_NAME} $CONF_FOLDER_PATH || exit 1
        rm -rf /tmp/${PROJECT_NAME} || exit 1
        echo "restore config ... done"
    fi
    return
}

function install_others ()
{
    return
}
