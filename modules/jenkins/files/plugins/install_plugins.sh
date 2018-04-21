#!/usr/bin/env bash

PLUGIN_REPO="http://repo.if083/soft/jenkins/plugins"
PLUGIN_DIR="/usr/share/tomcat/.jenkins/plugins"

while IFS='' read -r line || [[ -n "$plugin" ]]; do
    #if [-f "${PLUGIN_DIR}/"]
    echo "Install plugin: $plugin"
    sudo wget "${PLUGIN_REPO}/${plugin}.jpi -P ${PLUGIN_DIR}"
done < "${1}"
