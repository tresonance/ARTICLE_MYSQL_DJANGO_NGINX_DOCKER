#!/bin/bash

# Check if required environment variables are set
if [ -z "$SQL_DATABASE" ] || [ -z "$SQL_USER" ] || [ -z "$SQL_HOST" ] || [ -z "$SQL_ROOT_PASSWORD" ]; then
    echo -e "\n############################################\n\
    #\n\ [ERROR ]:
    #\t\tRequired environment variables are not set.\n\
    #\n\
    ####################################################\n"
    echo -e "ERROR SQL_DATABASE: $SQL_DATABASE\n"
    echo -e "ERROR SQL_USERNAME: $SQL_USER\n"
    echo -e "ERROR SQL_HOST: $SQL_HOST\n"
    echo -e "ERROR SQL_ROOT_PASSWORD: $SQL_ROOT_PASSWORD\n"

    exit 1
fi

echo -e "\n############################################\n\
#\n\
#\t\t START GRANTING MYSQL PRIVILEGE \n\
#\n\
####################################################\n"
DB_NAME=$SQL_DATABASE
USERNAME=$SQL_USER
HOSTNAME=$SQL_HOST #this must be the same as service name in docker compose
MYSQL_CONT_IP_ADDRSS="172.29.0.2"

# Execute the MySQL command
#mysql -u root -p"password" -e "GRANT ALL PRIVILEGES ON mydb.* TO 'user'@'192.168.48.3';" for mysql container ip
#mysql -u root -p"password" -e "GRANT ALL PRIVILEGES ON mydb.* TO 'user'@'%';" for all kind of host
echo -e "SQL_DATABASE: $SQL_DATABASE\n"
echo -e "SQL_USERNAME: $SQL_USER\n"
echo -e "SQL_HOST: $SQL_HOST\n"
echo -e "SQL_ROOT_PASSWORD: $SQL_ROOT_PASSWORD\n"

# mysql_ip=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql_cont`

# docker ps -a | grep django | awk '{print $1}' | xargs docker rm -f

# docker volume rm djangocms_micro_services_db_data

echo mysql -h $MYSQL_CONT_IP_ADDRSS  -P 3306  -u root -p "$SQL_ROOT_PASSWORD" -e "mysql  -uroot   -e GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$USERNAME'@'172.28.0.2';"
#mysql  --no-defaults --protocol=tcp -uroot -hdb   -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$USERNAME'@'$HOSTNAME';"

# >> mysql -h $SQL_HOST  -P 3306  -u root -p "$SQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$USERNAME'@'172.28.0.2';"

mysql -h db -P 3306 -u root -p rootpassword -e "GRANT ALL PRIVILEGES ON mydb.* TO 'user'@'172.28.0.2';"

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
