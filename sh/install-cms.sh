#!/bin/bash

echo " ....... installing django-cms ........"

pip install --upgrade pip

if [ $? -eq 0 ]; then
    echo "pip upgrade     OK"
else
    echo "pip upgrade     FAIL"
fi

pip install -r requirements.txt

if [ $? -eq 0 ]; then
    echo "pip install -r requirements.txt     OK"
else
    echo "pip install -r requirements.txt     FAIL"
fi

echo
pip install djangocms-installer
if [ $? -eq 0 ]; then
    echo "djangocms-installer     OK"
else
    echo "djangocms-installer    FAIL"
fi

pip install pytz
if [ $? -eq 0 ]; then
    echo "pytz     OK"
else
    echo "pytz   FAIL"
fi

pip install django-tinymce
if [ $? -eq 0 ]; then
    echo "django-tinymce    OK"
else
    echo "django-tinymce    FAIL"
fi

djangocms myproject
if [ $? -eq 0 ]; then
    echo "djangocms myproject    OK"
else
    echo "djangocms myproject    FAIL"
fi

/usr/bin/env python myproject/manage.py makemigrations
if [ $? -eq 0 ]; then
    echo "makemigrations         OK"
else
    echo "makemigrations         FAIL"
fi
/usr/bin/env python myproject/manage.py migrate
if [ $? -eq 0 ]; then
    echo "migrate                OK"
else
    echo "migrate                FAIL"
fi

cp  ~/Downloads/BizLand.zip ./
if [ $? -eq 0 ]; then
    echo "mv ~/Downloads/BizLand.zip       OK"
else
    echo "mv ~/Downloads/BizLand.zip     FAIL"
fi

tar -xf BizLand.zip
if [ $? -eq 0 ]; then
    echo "tar -xf BizLand.zip             OK"
else
    echo "tar -xf BizLand.zip            FAIL"
fi
rm -rf BizLand.zip
if [ $? -eq 0 ]; then
    echo "rm -rf BizLand.zip            OK"
else
    echo "rm -rf BizLand.zip          FAIL"
fi


/usr/bin/env python myproject/manage.py shell -c "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'adminpass')"

/usr/bin/env python myproject/manage.py runserver
