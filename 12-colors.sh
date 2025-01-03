#!/bin/bash

USERID=$(id -u) # id -u is to check ID of the user (u) and store in USERID variable

R="\e[31m"  # "\e[31m" syntax to use color red,green, yellow
G="\e[32m"
Y="\e[33m"

VALIDATE(){

    if [ $? -ne 0 ] #$? command is to check last command status called exit status 
    then
        echo -e "$2.... $R FAILURE" # echo -e --> to enable colors in shell script
        exit 1
    else
        echo -e "$2.... $G SUCCESS"
    fi
}

if [USERID -ne 0]
then 
    echo "EEOR: you should have sudo access"
    exit 2
fi

#-------------------------------#

dnf list installed mysql

if [$? -ne 0]
then 
    dnf install mysql -y
    VALIDATE $? "Installing Mysql"
else    
    echo -e "MySQL is already...  $Y installed"
fi

#-------------------------------#

dnf list installed git

if [$? -ne 0]
then 
    dnf install git -y
    VALIDATE $? "Installing Git"
else    
    echo -e "Git is already... $Y installed"
fi

#-------------------------------#