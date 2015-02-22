Setup:
```
cd <project dir>/configurer
# create virtualenv (skip if you already have one)
virtualenv -p /usr/bin/python3 ./env/.virtualenv
# activate virtual environment (if not already active)
source env/.virtualenv/bin/activate
# install server requirements
pip install -r env/requirements.txt
# install client requirements
(cd src/configurer && bower install)
# add include path
export PYTHONPATH=$PWD/src
# run app
python manage.py runserver
# go to http://127.0.0.1:8000/
```


Записки по разговорите с Ники: 

```
check for lotus notes
ODBC adapter for Python
Informix - силен човек от informix
https://code.google.com/p/ibm-db/
http://www14.software.ibm.com/webapp/download/search.jsp?go=y&rs=ifxjdbc

non-automatic update, през UI-я да може да натискаш Update и да ти смуче от github

suggestion: use sql_alchemy instead default Django ORM
`