#!/bin/bash

set -e

# echo "Arguments are: "
# echo $@
echo "Total number of arguments: $#"
#echo $#
if [ $# == 2 ]
    then 
    if [ $1 == "order" ] ||  [ $1 == "payment" ] ||  [ $1 == "login" ]
        then 
        if [ $2 -ge 1 ] && [ $2 -le 10 ]
            then 
                echo "Arguments are: $@"
                echo
        else 
            echo "Arg2 is not ok"
            echo "Aborting!! Please make sure arg2 is a number between 1 and 10"
            exit 1
        fi
    else 
        echo "Arg1 is not okay."  
        echo "Aborting!! Please make sure arg1 is ONLY: order, payment, login"
        exit 1
    fi
else
    echo "Aborting! "
    echo " Please make sure you provide only 2 arguments "
    exit 1
fi


# The input_checker script has to check the inputs passed to the script and it has to:
# 1. Only allow 2 arguments. Abort otherwise.
# 2. Argument #1 must be an app name. Allowed values are ONLY: order, payment, login. Abort otherwise.
# 3. Argument #2 must be a number between 1 and 10. Abort otherwise.

