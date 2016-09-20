#!/bin/bash

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

#return directory
cd - 

#add mods befor running
modarrfile=$dontstarve_dir/$cluster_name/Master/modoverrides.lua
modarrfilebak=$dontstarve_dir/$cluster_name/Master/modoverrides.lua.bak
moddownloader=$install_dir/mods/dedicated_server_mods_setup.lua
moddownloaderbak=$install_dir/mods/dedicated_server_mods_setup.lua.bak
mv $modarrfile $modarrfilebak
mv $moddownloader $moddownloaderbak

echo 'return' > $modarrfile
echo '{' >> $modarrfile
index=1
while read line || [[ -n ${line} ]]
do 
    line=`echo $line | awk '{print $1}'`
    if [ $line != '' ]; then
        if [ "$index" == "1" ]; then
            ((index++))
            printf "\t%s%s%s" '["workshop-' "$line" "\"] = { enabled = true }" >> $modarrfile
            echo 'ServerModSetup("'$line'")' >> $moddownloader
        else
            echo "," >> $modarrfile
            printf "\t%s%s%s" '["workshop-' "$line" "\"] = { enabled = true }" >> $modarrfile
            echo 'ServerModSetup("'$line'")' >> $moddownloader
        fi
    fi
done < ./modlist
printf "\n" >> $modarrfile
echo '}' >> $modarrfile

#run Master and auto download mods frome Steam

check_for_file "$install_dir/bin"
cd "$install_dir/bin" || fail 
run_shared=(./dontstarve_dedicated_server_nullrenderer)
run_shared+=(-console)
run_shared+=(-cluster "$cluster_name")
run_shared+=(-monitor_parent_process $$)
run_shared+=(-shard)
"${run_shared[@]}" Master | sed 's/^/Master: /'
