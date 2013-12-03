#!/bin/bash 

killpstree(){
	local children=`ps --ppid $1 --no-heading | awk '{ print $1 }'`
	for child in $children
	do
		killpstree $child #子殺し,孫殺し,ひ孫殺し...
	done

	echo "--->>> kill $1"
	kill $1 #親殺し
}

[ $# -ne 1 ] && echo "Usage:$0 [target process name]" && exit

kill_family_list=`ps ax | grep $1 | grep -v 'grep' | grep -v $0  | awk '{ print $1 }'`
for parent_pid in $kill_family_list
do
	echo "=== start:family killing target=[$parent_pid] ==="
	pstree -pha $parent_pid #抹殺する家の家族構成を表示

	killpstree $parent_pid
done
