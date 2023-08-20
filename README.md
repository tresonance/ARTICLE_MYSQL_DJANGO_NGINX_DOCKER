<p align="center">
  <img src="./image.png" width="350" alt="accessibility text">
</p>

### About This Django project
<h3 style="color:red; border:2px solid black" >0- my_djngo_project </h3>
<p>Please, make sure you have django installed and also i recommand to use virtualenv</p>

```
django-admin startproject my_django_project
```
  
```
- my_django_project
  > my_django_project
    >  __init__.py
    >  asgi.py
    >  settings;py
    >  urls.py
    >  wsgi.py
```


#### Services Inside Docker Compose
```
version: '3'

services:

  # Mysql Service
  db:
  ...

  # Web (Django) Service
  web:
  ...

  # Nginx Service
  nginx:
  ...
```
### About Used Services
<h3 style="color:red; border:1px solid black" >I- Mysql (db service) </h3>
<p style="color:grey">We use the latest image. We want our tables to be created once container is running so we shared our sql file(s) <span style="color:blue">./queries/init.sql</span> (inside host) with <span style="color:blue">/docker-entrypoint-initdb.d/init.sql</span> inside container.
By doing so, all the queries inside sql files will be automatically executed, just after the container is ready. Please, see Docker-compose.yml file.</p>

<br/>

<h3 style="color:red; border:1px solid black" >II- Dango (web service) </h3>
<p>This service must start after the first service (db service is ready), so we ned to add shell script <span style="color:blue">wait-for-it.sh </span>inside command attribute. Inside the same command attribute, we run collectstatic so that django collect all static files from all application (here i have only onecalled shoplink) into a folder we state here: STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles') in settings.py file </p>
