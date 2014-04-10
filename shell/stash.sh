#!/bin/bash

STASH_DIR=~/.stash
STASH_CTL_FILE="$STASH_DIR/ctl_file"

function show()
{
	ID="$1"
	STASH_FILE="$STASH_DIR/$ID.patch"

	cat $STASH_FILE
}

function save()
{
	echo "Descricao do seu stash: "
	read STASH_DESCRIPTION

	STASHID=`date +%s`
	STASH_FILE="$STASH_DIR/$STASHID.patch"

	if ( svn diff > $STASH_FILE )
	then
		echo "$STASHID - $STASH_DESCRIPTION - `pwd`" >> "$STASH_CTL_FILE"
		svn revert -R . > /dev/null
		echo "Stashed"
	else
		echo "Fail to stash"
	fi

	exit 0
}

function remove()
{
	ID="$1"
	NOW=`date +%s`
	cat $STASH_CTL_FILE |grep -v $ID > /tmp/."$ID_$NOW".tmp
	mv "/tmp/."$ID_$NOW".tmp" "$STASH_CTL_FILE"
	rm -f "$STASH_DIR/$ID.patch"
	echo "ID ($ID) removed"
}

function list()
{
	cat "$STASH_CTL_FILE" | awk -F"-" '{print $1" - "$2}'
	exit 0
}

function apply()
{
	ID="$1"

	if ( ! grep -q "$ID" "$STASH_CTL_FILE" 2>> /dev/null )
	then
		echo "Stashed ID not found"
		exit 1
	else
		echo "Stashed ID found, loading diff..."
	fi

	STASHED_FILE="$STASH_DIR/$ID.patch"

	if ( patch -p0 < "$STASHED_FILE" )
	then
		remove $ID
		exit 0
	else
		exit 1
	fi
}


function basic_check()
{
	if [ ! -d $STASH_DIR ]
	then
		mkdir -p $STASH_DIR
	fi

	if ( ! svn info > /dev/null )
	then
		echo "It doesn't look as a subversion directory"
		exit 1
	fi
}

function print_help()
{
	echo "Wrong parameters, please use: "
	echo "$0 <list>"
	echo "$0 <save>"
	echo "$0 <show> <id>"
	echo "$0 <apply> <id>"
	echo "$0 <remove> <id>"
}

basic_check

if [ $# -lt 1 ]
then
	print_help
	exit 1
fi

case $1 in
	list) list ;;
	save) save ;;
	apply) apply $2 ;;
	remove) remove $2 ;;
	show) show $2 ;;
	*) print_help;;
esac

