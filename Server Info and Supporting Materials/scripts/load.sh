#!/bin/bash
/usr/bin/mysql --local-infile --user=prinappdata --password=PrinApp1! --database=prinappdata <<EOFMYSQL
load data local infile '/prinapp/Data/menu.csv' replace INTO table TABLE_1 fields terminated by ',' enclosed by '"' escaped by '\\\'
lines terminated by '\r';
\q
EOFMYSQL
#incompatibility issue alert
#if the csv file was saved using a make the line should be terminated by '\r'
