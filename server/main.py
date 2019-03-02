from flask import Flask
from pymongo import MongoClient

client = MongoClient()
db = client['todolist']
collection = db['items']
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'

@app.route('/api/getitems',methods=['GET'])
def getCells():
    return collection.find()

#TODO: Submit item 
@app.route('/api/submit',methods=['POST'])
def postCell():

    return 'hi world'

#TODO: Edit item
@app.route('/api/edit/<item>',methods=['PUT'])
def editCell(item):
    return item

# MongoDB Document Structure:
"""
{
    'content' : 'content of note',
    'date' : DATE object,
}
"""