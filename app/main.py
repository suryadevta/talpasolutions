from flask import Flask
import psycopg2
import os

app = Flask(__name__)

@app.route('/')
def index():

    try:
        f = open('/vault/secrets/db-creds', 'r').readlines()
        conn_string = (f[0].strip())

        conn = psycopg2.connect(conn_string)
        
        return "Connection: OK"
    except Exception as e:
        return "Connection: Failed"

