#/usr/bin/env bash

Help() {
    echo Usage:
    echo '   sws <connect|disconnect> <destination application name> [source application name]'
    echo '   sws find-name <sources|destinations>'
    echo '   you can also use "c" instead of "connect", "d" instead of "disconnect" and "f" instead of "find-name"'
    echo
    echo '   note that the application name should be the name of the binary found in pw-dump. You can use "find-name" to get it.'
    echo '   source and destination can be writen as "s" and "d"'
    exit
}

if [ $1 == "connect" ] || [ $1 == "c" ];
then
    mode=1
elif [ $1 == "disconnect" ] || [ $1 == "d" ];
then
    mode=2
elif [ $1 == "find-name" ] || [ $1 == "f" ];
then
    mode=3
else
    Help
fi

FindName() {
    if [ $2 == "d" ] || [ $2 == "destination" ];
    then
        pw-link -Ii
    else
        pw-link -Io
    fi
    while :
    do
        read -p "which of these is your program? " inp
        inp=$(echo $inp | grep "^[0-9]*$")
        if [ -z $inp ];
        then
            echo please enter a number
        else
            break
        fi
    done

    node_id=$(pw-cli i $inp | grep node\.id | grep -o "[0-9]*")
    echo program name is: $(pw-cli i $node_id | grep application\.process\.binary | grep -o '".*"')

}

GetOutputUsingWindow() {
    echo selecting a window...
    output_pid=$(xprop | grep PID | grep -o \[0-9\]\*)
    echo pid is: $output_pid
    output_nodes=$(pw-dump | jq '.[] | if(.info.props."application.process.id" == '$output_pid' and .type == "PipeWire:Interface:Node") then .id else null end'| grep -v null)
    echo id of output nodes: $output_nodes

    for i in $output_nodes
    do
        output_ports=$(pw-dump | jq '.[] | if(.type == "PipeWire:Interface:Port" and .info.direction == "output" and .info.props."node.id" == '$i') then .id else null end' | grep -v null)
    done
}

GetOutputUsingName() {
    echo finding the nodes for $src_program
    output_nodes=$(pw-dump | jq '.[] | if(.info.props."application.process.binary" == "'$src_program'" and .type == "PipeWire:Interface:Node" and .info."max-output-ports" > 0) then .id else null end' | grep -v null)
    echo id of output nodes: $input_nodes
    for i in $output_nodes
    do
        echo finding ports for $i
        new_ports=$(pw-dump | jq '.[] | if(.type == "PipeWire:Interface:Port" and .info.direction == "output" and .info.props."node.id" == '$i') then .id else null end' | grep -v null)
        echo found $new_ports
        output_ports="${output_ports} ${new_ports}"
    done
    echo id of output ports: $output_ports

}

GetInput() {
    echo finding the nodes for $dest_program
    input_nodes=$(pw-dump | jq '.[] | if(.info.props."application.process.binary" == "'$dest_program'" and .type == "PipeWire:Interface:Node" and .info."max-input-ports" > 0) then .id else null end' | grep -v null)
    echo id of input nodes: $input_nodes
    for i in $input_nodes
    do
        echo finding ports for $i
        new_ports=$(pw-dump | jq '.[] | if(.type == "PipeWire:Interface:Port" and .info.direction == "input" and .info.props."node.id" == '$i') then .id else null end' | grep -v null)
        echo found $new_ports
        input_ports="${input_ports} ${new_ports}"
    done
    echo id of input ports: $input_ports
}

Connect() {
for j in $output_ports
do
    if [ $mode -eq 1 ];
    then
        for k in $input_ports
        do
            pw-link $j $k
            echo connected $j to $k
        done
    else
        for k in $input_ports
        do
            pw-link -d $j $k
            echo disconnected $j from $k
        done
    fi
done
}

if [ -z $2 ];
then
    Help
fi

if [ $mode == 3 ];
then
    if [ $2 == "source" ] || [ $2 == "s" ] || [ $2 == "d" ] || [ $2 == "destination" ];
    then
        FindName
    else
        Help
    fi
else
    dest_program="$2"
    if [ -z $3 ];
    then
        GetOutputUsingWindow
    else
        src_program="$3"
        GetOutputUsingName
    fi
    GetInput
    Connect
fi

# vim:filetype=bash
