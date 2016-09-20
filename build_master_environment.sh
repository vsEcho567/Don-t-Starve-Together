#!/bin/bash

#you have to modify this
SERVER_NAME=type_your_server_name
SERVER_DESCRIPTION=type_your_server_description
SERVER_PASSWORD=                                #blank means no password
STEAM_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#

CLUSTER_KEY=abcabcabc                           #

#create file
mkdir -p ~/steamcmd
cd ~/steamcmd
wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
tar -xvzf steamcmd_linux.tar.gz

mkdir -p ~/.klei/DoNotStarveTogether/MyDediServer/Master
mkdir -p ~/.klei/DoNotStarveTogether/MyDediServer/Caves

echo $STEAM_KEY > ~/.klei/DoNotStarveTogether/MyDediServer/cluster_token.txt
base64 -di > ~/.klei/DoNotStarveTogether/MyDediServer/cluster.ini <<< 'W0dBTUVQTEFZXQpnYW1lX21vZGUgPSBzdXJ2aXZhbAptYXhfcGxheWVycyA9IDYKcHZwID0gZmFs
c2UKcGF1c2Vfd2hlbl9lbXB0eSA9IHRydWUKCltORVRXT1JLXQpjbHVzdGVyX2Rlc2NyaXB0aW9u
ID0KY2x1c3Rlcl9uYW1lID0KY2x1c3Rlcl9wYXNzd29yZCA9CmNsdXN0ZXJfaW50ZW50aW9uID0g
Y29vcGVyYXRpdmUKCltNSVNDXQpjb25zb2xlX2VuYWJsZWQgPSB0cnVlCgpbU0hBUkRdCnNoYXJk
X2VuYWJsZWQgPSB0cnVlCmJpbmRfaXAgPSAxMjcuMC4wLjEKbWFzdGVyX2lwID0gMTI3LjAuMC4x
Cm1hc3Rlcl9wb3J0ID0gMTA4ODkKY2x1c3Rlcl9rZXkgPQo='
base64 -di > ~/.klei/DoNotStarveTogether/MyDediServer/Master/server.ini <<< 'W05FVFdPUktdCnNlcnZlcl9wb3J0ID0gMTEwMDAKCgpbU0hBUkRdCmlzX21hc3RlciA9IHRydWUK
CgpbU1RFQU1dCm1hc3Rlcl9zZXJ2ZXJfcG9ydCA9IDI3MDE4CmF1dGhlbnRpY2F0aW9uX3BvcnQg
PSA4NzY4Cg=='

#modify setting file
sed -i "s/cluster_name =.*/& $SERVER_NAME/" ~/.klei/DoNotStarveTogether/MyDediServer/cluster.ini
sed -i "s/cluster_description =.*/& $SERVER_DESCRIPTION/" ~/.klei/DoNotStarveTogether/MyDediServer/cluster.ini
sed -i "s/cluster_password =.*/& $SERVER_PASSWORD/" ~/.klei/DoNotStarveTogether/MyDediServer/cluster.ini
sed -i "s/cluster_key =.*/& $CLUSTER_KEY/" ~/.klei/DoNotStarveTogether/MyDediServer/cluster.ini

#recheck
steamcmd_dir="$HOME/steamcmd"
install_dir="$HOME/dontstarvetogether_dedicated_server"
cluster_name="MyDediServer"
dontstarve_dir="$HOME/.klei/DoNotStarveTogether"

function fail()
{
        echo Error: "$@" >&2
        exit 1
}

function check_for_file()
{
    if [ ! -e "$1" ]; then
            fail "Missing file: $1"
    fi
}

cd "$steamcmd_dir" || fail "Missing $steamcmd_dir directory!" # TODO

check_for_file "steamcmd.sh"
check_for_file "$dontstarve_dir/$cluster_name/cluster.ini"
check_for_file "$dontstarve_dir/$cluster_name/cluster_token.txt"
check_for_file "$dontstarve_dir/$cluster_name/Master/server.ini"

#download and update
./steamcmd.sh +force_install_dir "$install_dir" +login anonymous +app_update 343050 validate +quit

check_for_file "$install_dir/bin"
