#! /bin/bash

set -e;

# On failure: print usage and exit with 1
function print_usage {
  me=`basename "$0"`
  echo "Usage: ./$me -v <dhis2 version>";
  echo "Example: ./$me -v 2.23";
  exit 1;
}

function validate_parameters {
  if [ -z "$DHIS2_VERSION" ] ; then
    print_usage;
  fi
}

while getopts "v:" OPTION
do
  case $OPTION in
    v)  DHIS2_VERSION=$OPTARG;;
    \?) print_usage;;
  esac
done

validate_parameters

current_dir=`pwd`
releases_dir="releases/$DHIS2_VERSION"

if [ ! -d "$releases_dir" ]; then
    mkdir -p $releases_dir
fi

file_name=`date +dhis2-%Y%m%d.war`
dt=`date '+%Y%m%d'`

rm -f $current_dir/releases/dhis2.war


# They are making scripting this hard: https://releases.dhis2.org/2.31/2.31.1/dhis.war
# the way it used to be: https://s3-eu-west-1.amazonaws.com/releases.dhis2.org/$DHIS2_VERSION/dhis.war
# hard coding for now.  Because of this new database schema manager thing called flyway
# that is being used, the version of the WAR and the version of the database need to 
# line up.


wget -O "$current_dir/$releases_dir/$file_name" "https://www.dropbox.com/s/92ub7spi1ujur9j/ROOT.war?raw=1"

cp -a "$current_dir/$releases_dir/$file_name" "$current_dir/releases/dhis2.war"

# build new image using new dhis.war 
image_id=$(docker build -q -t researchtriangle/dhis2-web:$DHIS2_VERSION-tomcat7-jre8-$dt .)

echo "Image id: $image_id"
docker tag $image_id researchtriangle/dhis2-web:$DHIS2_VERSION-tomcat7-jre8-latest

docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
docker push researchtriangle/dhis2-web
