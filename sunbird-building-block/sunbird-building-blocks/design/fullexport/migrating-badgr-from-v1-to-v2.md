
1. Download and install PostgreSQL ([https://www.postgresql.org/download/).](https://www.postgresql.org/download/).) Create a database using pgAdmin 4 (e.g. ‘badgrDB’).


1. Install virtualenv.



sudo pip install virtualenv virtualenvwrapper


1. Run following commands to setup badgr.



mkdir badgr && cd badgr

virtualenv env

source env/bin/activate

git clone [https://github.com/concentricsky/badgr-server.git](https://github.com/concentricsky/badgr-server.git) code

cd code

pip install -r requirements.txt

cp apps/mainsite/settings_local.py.example apps/mainsite/settings_local.py

Edit the settings_local.py file and insert local credentials for DATABASES

e.g.

DATABASES = {


```
'default': {

    'ENGINE': 'django.db.backends.postgresql_psycopg2', # 'postgresql_psycopg2', 'postgresql', 'mysql', 'sqlite3' or 'oracle'.

    'NAME': 'badgrDB',                      # Or path to database file if using sqlite3.

    'USER': 'postgres',                      # Not used with sqlite3.

    'PASSWORD': 'postgres',                  # Not used with sqlite3.

    'HOST': 'localhost',                      # Set to empty string for localhost. Not used with sqlite3.

    'PORT': '5432',                      # Set to empty string for default. Not used with sqlite3.

    'OPTIONS': {
      }
    }
```


put this line on top in code/apps/mainsite/settings_local.py

import string

pip install psycopg2

#Before running this -- (make sure you set security_key in apps/mainsite/settings.py )

./manage.py migrate

./manage.py createsuperuser

###Generate swagger file

./manage.py dist

4) Run badgr server.

Before running badgr server, we need to put the host in settings_local.py at line 117, for local use below line

ALLOWED_HOSTS = \[u'localhost', ]

./manage.py runserver


1. Navigate to [http://localhost:8000/accounts/login.](http://localhost:8000/accounts/login.) Login, verify email address. (Note: Verify link is present in badgr server log).


1. API reference is available at [http://127.0.0.1:8000/docs/](http://127.0.0.1:8000/docs/)









Important Docs:-

[https://badgr.org/app-developers/api-guide/](https://badgr.org/app-developers/api-guide/)





*****

[[category.storage-team]] 
[[category.confluence]] 
