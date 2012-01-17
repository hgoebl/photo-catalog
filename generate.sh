#!/bin/bash
#
# Photo Catalog Generator
#

. ./setenv.sh

INPUT_DIR=${1:-sample}
CATALOG_NAME=${2:-catalog}

CWD=$(pwd)
XSLT_DIR=${CWD}/xslt

if [ ! -d ${INPUT_DIR} ]; then
    echo "input directory not found"
    echo ${INPUT_DIR}
    exit 1
fi

cd ${INPUT_DIR}

XML=${CATALOG_NAME}.xml
FO=${CATALOG_NAME}.fo

if [ ! -f ${XML} ]; then
    echo "input not found (file does not exist)"
    exit 2
fi

# generate intermediate FO files
$FOP -xml ${XML} -xsl ${XSLT_DIR}/catalog-fop.xsl -foout ${FO}

# generate PDF
$FOP -fo ${FO} -pdf ${CATALOG_NAME}.pdf

# removing intermediate files
rm ${FO}

cd ${CWD}
