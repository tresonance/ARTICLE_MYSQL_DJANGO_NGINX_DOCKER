#echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'admin@myproject.com', 'password')" | python myproject/manage.py shell

echo "import django; django.setup(); \
   from django.contrib.auth.models import User; \
   from django.contrib.auth.management.commands.createsuperuser import get_user_model; \
   User.objects.get(username='$DJANGO_SU_NAME', is_superuser=True).delete(); \
   get_user_model()._default_manager.db_manager('$DJANGO_DB_NAME').create_superuser( \
   username='$DJANGO_SU_NAME', \
   email='$DJANGO_SU_EMAIL', \
   password='$DJANGO_SU_PASSWORD')"  | python manage.py shell