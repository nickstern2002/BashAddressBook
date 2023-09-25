# library file for AddressBook.sh

addressBook=./addresses.txt
export addressBook

# searchBook(){
#  grep -i "$@" $addressBook|wc -l| awk '{ print $1 }'
#}

locate_single_instance(){
    grep -n "$1" "$addressBook" | cut -d':' -f1
}
    

add_info() {

    echo "You will be prompted for three pieces of information"
    echo "Please provide the name in the format FIRST NAME LAST NAME"
    read name_input
    if grep -q "$name_input" $addressBook; then
        echo "Name already in address book"
        return
    fi
    echo "Provide ${name_input}'s email address"
    read email
    echo "Provide ${name_input}'s phone number"
    read number
    echo "${name_input}:${email}:${number}" >> $addressBook
    if [ $# -eq 0 ]; then 
        echo "The following info was added to your address book"
        grep "$name_input" "$addressBook"
    else
        echo "Your new info for $name_input is"
        grep "$name_input" "$addressBook"
    fi
  
}

remove_info() {
    if [ $# -eq 0 ]; then
        echo "Please provide the name of the indivudual you want to delete in the format FIRST NAME LAST NAME"
        read name_input
    fi
    result=$(locate_single_instance ${name_input})
    sed -i "${result}d" "$addressBook"
}

search_info(){
    echo -n "Please provide a list of last names to search for separated by a single space: "
    read name_input
    if [ -z "$name_input" ]; then
        echo "No search query provided"
        return
    fi
    old_IFS="$IFS"
    IFS=" "
    for name in $name_input
    do
        grep -i "$name" "$addressBook"
    done
    IFS=$old_IFS
}

edit_info(){
    echo -n "Provide the first and last name of the entry you would like to edit(Format FIRST_NAME LAST_NAME): "
    read name_input
    if [ -z "$name_input" ]; then
        echo "No name provided"
        return
    fi
    
    confirmation="n"
    while [ "$confirmation" = "n" ]
    do
        echo "Is this the correct person?(y or n)"
        grep -i "$name_input" "$addressBook"
        read confirmation
        if [ $confirmation != "y" ] && [ $confirmation != "n" ]; then
            while [ $confirmation != "y"  -a $confirmation != "n" ] # && [ $confirmation != "n" ] 
            do
                echo "Invalid Response. Please respond with y or n"
                read confirmation
            done
        fi
        if [ $confirmation = "y" ]; then
            break
        else
            echo "Please provide a new input"
            read name_input
        fi
    done
    
    remove_info "skip"
    
    add_info "skip"
    

}


















