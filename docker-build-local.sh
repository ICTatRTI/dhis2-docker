#! /bin/bash

set -e;


file_name='dhis-web-portal-2.30.war'
current_dir=`pwd`
releases_dir="releases/$DHIS2_VERSION"

cp -a "$current_dir/$releases_dir/$file_name" "$current_dir/releases/dhis2.war"

# build new image using new dhis.war 
image_id=$(docker build -q -t researchtriangle/dhis2-web-custom .)

echo "Image id: $image_id"



