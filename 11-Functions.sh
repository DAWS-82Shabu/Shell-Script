#!/bin/bash

USERID=$(id -u) # id -u is to check ID of the user (u) and store in USERID variable

VALIDATE(){

    if [ $? -ne 0 ] #$? command is to check last command status called exit status 
    then
        echo "Installing MySQL ... FAILURE"
        exit 1
    else
        echo "Installing MySQL ... SUCCESS"
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
    echo "MySQL is already installed"
fi

#-------------------------------#

dnf list installed git

if [$? -ne 0]
then 
    dnf install git -y
    VALIDATE $? "Installing Git"
else    
    echo "Git is already installed"
fi

#-------------------------------#