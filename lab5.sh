#!/bin/bash
#3 files as parametres with 2 numbers in each file (<1>@<2>), solve <1>%<2>, then dest sort and show on screen

#possible errors
PARAM_ERROR="3 parametres need"
FILE_INPUT_ERROR="2 numbers need in "
ZERO_DETOMINATOR_ERROR="Detominator is 0 - incorrect math in "
BAD_ARGS="Incorrect numbers in "

#check count of parametres
if [ "$#" -ne 3 ]
then
	echo "$PARAM_ERROR"
	exit 1
else
	echo "3 files entered - it's ok..."
fi

count=0
declare -a results=(0 0 0)

#for all files
for i in 1 2 3
do
#read from file
	str=$(<$1)
#	echo "$str"

#check @
	if [[ "$str" == *"@"* ]];
	then
		echo "@ found in "$1
	else
		echo "@ not found in "$1 && exit 1
	fi

#delete all spaces
	clear_str="${str#"${str%%[![:space:]]*}"}"
	clear_str="${clear_str%"${clear_str##*[![:space:]]}"}"
#	echo "$clear_str"

#first number
	value1=`echo ${clear_str%\@[0-9]*}`
#	echo "$value1"

#second number
	value2=`echo ${clear_str#[0-9]*\@}`
#	echo "$value2"

	case $value1 in
#    		*[0-9]*) echo "Number1 located" ;;
    		*[^0-9]*) echo $BAD_ARGS$1 && exit 1 ;;
	esac

        case $value2 in
#               ^[1-9]?[0-9]*$) echo "Number2 located" ;;
                *[^0-9]*) echo $BAD_ARGS$1 && exit 1 ;;
		0) echo $ZERO_DETOMINATOR_ERROR$1 && exit 1 ;;
        esac

#show result
	result=$(($value1%$value2))
	echo "$value1 % $value2 = $result"

#add to array
	results[count]=$result
	count=$(($count+1))

	shift
done

#reversed sort and show sorted array
echo "Sorted result:"
for i in 0 1 2
do
	echo ${results[i]}
done | sort -r
exit 0
