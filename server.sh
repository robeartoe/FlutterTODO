#!/bin/bash

cd server/

source venv/bin/activate

export FLASK_APP=main.py
export FLASK_ENV=development
flask run