#!/bin/bash

. ./booklibs.sh

show_menu(){
    input=-1

    while [ "$input" != "leave" ] 
    do
	    echo "Would you like to search, add, remove, edit or leave"
	    read input
	    case $input in
		    search)	
                search_info
			   	;; 
		    add)
                add_info
                ;;
	    	remove)
                remove_info
                ;;
	    	edit)
                edit_info
                ;;
    		leave)
		    	echo "Goodbye"
		    	exit 0	;;
            *)
                echo "Unrecognized input. Please try again" ;;
    	esac		
    done
}

echo "This is a merge test"

echo "Welcome to the Address Book"


if [ ! -f $addressBook ]; then
    echo "Creating addresses.txt"
    touch $addressBook
fi

if [ ! -r "$addressBook" ]; then
    echo "Error $addressBook is not readable"
    exit 1
fi

if [ ! -w "$addressBook" ]; then
    echo "Error: $addressBook is not writable"
    exit 2
fi

show_menu
