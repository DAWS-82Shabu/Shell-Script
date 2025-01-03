#!/bin/bash

USERID=$(id -u)
R="\e[31m"   # "\e[31m" syntax to use color red,green, yellow
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shellscript-logs" # create a folder in /var/log/ with name shellscript-logs
LOG_FILE=$(echo $0 | cut -d "." -f1 ) # echo $0 will give you script name | 
# cut -d "." -f1 will give you only file name without extension like 13-logs.sh --> 13-logs
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S) # will give time stamp
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log" # the genrated log file is will in this folder

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 ... $R FAILURE.. $N"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS.. $N"
    fi
}

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

# &>>$LOG_FILE_NAME will redirect this to log file you will not see on server screen

if [ $USERID -ne 0 ]
then
    echo "ERROR:: You must have sudo access to execute this script"
    exit 4 #other than 0
fi

dnf list installed mysql &>>$LOG_FILE_NAME

if [ $? -ne 0 ]
then # not installed
    dnf install mysql -y &>>$LOG_FILE_NAME
    VALIDATE $? "Installing MySQL"
else
    echo -e "MySQL is already ... $Y INSTALLED $N"
fi


dnf list installed git &>>$LOG_FILE_NAME

if [ $? -ne 0 ]
then
    dnf install git -y &>>$LOG_FILE_NAME
    VALIDATE $? "Installing Git.."
else
    echo -e "Git is already ... $Y INSTALLED $N"
fi




# Colors --> success(green), failure(red), already installed(yellow)

# R --> 31
# G --> 32
# Y --> 33

# \e[31m

# logs --> logging the result to some file

# redirectors

# < --> input
# > --> output

# 1 --> success
# 2 --> failure
# & --> both success and failure

# /var/logs/shellscirpt-logs/13-logs.sh.log

# script-name.log

# 13-logs.sh --> 13-logs
# 13-logs-01-01-2025.log
