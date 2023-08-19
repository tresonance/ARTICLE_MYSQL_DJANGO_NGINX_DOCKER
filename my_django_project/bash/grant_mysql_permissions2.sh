#!/bin/bash

echo -e "\n############################################\n\
#\n\
#\t\t START GRANTING MYSQL PRIVILEGE \n\
#\n\
####################################################\n"
DB_NAME=`${db_SQL_DATABASE}`
USERNAME=`${db_SQL_USER}`
HOSTNAME=`${db_SQL_HOST}` #this must be the same as service name in docker compose

# Execute the MySQL command
#mysql -u root -p"password" -e "GRANT ALL PRIVILEGES ON mydb.* TO 'user'@'192.168.48.3';" for mysql container ip
#mysql -u root -p"password" -e "GRANT ALL PRIVILEGES ON mydb.* TO 'user'@'%';" for all kind of host

echo -e "SQL_DATABASE: `${db_SQL_DATABASE}` \n"
echo -e "SQL_USERNAME: `${db_SQL_USER}` \n"
echo -e "SQL_HOST: `${db_SQL_HOST}` \n"
echo -e "SQL_ROOT_PASSWORD: `${db_SQL_ROOT_PASSWORD}` \n"

mysql_ip=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql_cont`

# docker ps -a | grep django | awk '{print $1}' | xargs docker rm -f

# docker volume rm djangocms_micro_services_db_data

echo mysql -h $mysql_ip  -P 3306  -u root -p "$SQL_ROOT_PASSWORD" -e "mysql  -uroot   -e GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$USERNAME'@'$mysql_ip';"
#mysql  --no-defaults --protocol=tcp -uroot -hdb   -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$USERNAME'@'$HOSTNAME';"

mysql -h $mysql_ip  -P 3306  -u root -p "$SQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$USERNAME'@'$mysql_ip';"

#echo -e "mysql  -u root  -e GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$USERNAME'@'$mysql_ip';"
#mysql  -u root -h db --protocol=tcp  -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$USERNAME'@'$mysql_ip';"


if [ "$?" -eq 0 ];then
    echo -e "\n############################################\n\
    #\n\
    #\t\t FINISH GRANTING MYSQL PRIVILEGE \n\
    #\n\
    ####################################################\n"
else
    echo -e "\n############################################\n\
    # [ERROR]: \n\
    #\t\t mysql command failed \n\
    #\n\
    ####################################################\n"
fi 
