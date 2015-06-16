#!/bin/bash

set -ex

PKG="${1}"
VERSION="${2}"
ZIPFILE="${PKG}-${VERSION}.zip"
ORIG_TARBALL="../${PKG}_${VERSION}.orig.tar.xz"

[ ! -f "${ORIG_TARBALL}" ] || exit 0

rm -rf "${PKG}"*
rm -rf "${PKG}-${VERSION}"
rm -f "${ZIPFILE}"

wget -c -t 1 -T 5 "https://github.com/sannies/mp4parser/archive/mp4parser-project-${VERSION}.zip" -O "${ZIPFILE}" || exit 1

unzip "${ZIPFILE}" || exit 1

rm -f "${ZIPFILE}"

mv "${PKG}"* "${PKG}-${VERSION}"

XZ_OPT=--best tar -c -v -J -f "${ORIG_TARBALL}" \
    --exclude='examples/src' \
    --exclude='androidtest/src' \
    --exclude='*.3gp' \
    --exclude='*.aac' \
    --exclude='*.ac3' \
    --exclude='*.f4v' \
    --exclude='*.m4a' \
    --exclude='*.m4p' \
    --exclude='*.m4s' \
    --exclude='*.mp4' \
    --exclude='*.mp4f' \
    --exclude='*.h264' \
    --exclude='*.srt' \
    --exclude='*.odf' \
    --exclude='.git*' \
    --exclude-vcs \
    "${PKG}-${VERSION}" || exit 1

rm -rf "${PKG}-${VERSION}"
rm -f "${ZIPFILE}"

