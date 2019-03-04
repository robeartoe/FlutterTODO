from flask import Flask, request
from pymongo import MongoClient
import json

client = MongoClient()
db = client['todolist']
collection = db['items']
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'

@app.route('/api/items',methods=['GET'])
def getCells():
    return collection.find()

#TODO: Submit item 
@app.route('/api/submit',methods=['POST'])
def postCell():
    data = request.data['data']
    post_id = collection.insert_one(data).inserted_id
    if post_id.acknowledge == False:
        return json.dumps({'success':False}), 201, {'ContentType':'application/json'} 
    else:
        return json.dumps({'success':True}), 201, {'ContentType':'application/json'} 


#TODO: Edit item
@app.route('/api/edit/<item>',methods=['PUT'])
def editCell(item):
    # TODO: Put data into a dictionary that has (item.ID & new content)
    
    return item

# MongoDB Document Structure:
"""
{
    'content' : 'content of note',
    'date' : DATE object,
}
"""