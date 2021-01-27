#!/bin/bash
PROJECT_NAME=DemoPlugin
PROJECT_TOP=$(cd "$(dirname "$1")/../.."; pwd)

CURRDIR=$(cd $(dirname $0) && pwd)
ARCHIVES_TOP=${CURRDIR}/archives
INS_ROOTFS=${ARCHIVES_TOP}/rootfs
DESTDIR=${INS_ROOTFS}/usr/local/EdgeSense/${PROJECT_NAME}

rm -rf ${ARCHIVES_TOP} || exit 1
mkdir -p ${ARCHIVES_TOP} || exit 1
mkdir -p ${INS_ROOTFS} || exit 1
mkdir -p ${DESTDIR} || exit 1
mkdir -p ${INS_ROOTFS}/etc/systemd/system || exit 1

# copy epack config
cd ${CURRDIR} || exit 1
cp -f ePack_custom.bash ${ARCHIVES_TOP} || exit 1
cp -f ../Linux-Common/startup_custom.bash ${ARCHIVES_TOP} || exit 1

# copy project files
cd ${PROJECT_TOP} || exit 1
npm install || exit 1
cp -rf agent_config.json index.js node_modules module config ${DESTDIR} || exit 1

# copy misc
cd ${CURRDIR} || exit 1
cp -f ../Linux-Common/${PROJECT_NAME}.service ${INS_ROOTFS}/etc/systemd/system || exit 1
cp -f ../Linux-Common/uninstall.bash ${DESTDIR} || exit 1

# copy platform dependency
cd ${CURRDIR} || exit 1
curl -f --output ${DESTDIR}/node https://gitlab.edgecenter.io/edgesense-open/nodejs-binary/-/raw/node-v12.14.0-linux-x64/node || exit 1
chmod +x ${DESTDIR}/node || exit 1

# advsc.ini
cp -f ${PROJECT_TOP}/installer/advsc.ini ${DESTDIR} || exit 1

# advsc
curl -f --output ${DESTDIR}/advsc https://gitlab.edgecenter.io/edgesense-open/advsc-binary/-/raw/master/Ubuntu18.04-x64/1.0.5/advsc || exit 1
chmod +x ${DESTDIR}/advsc || exit 1

echo "done"
