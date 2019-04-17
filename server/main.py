from flask import Flask, request
from pymongo import MongoClient
from bson.json_util import dumps
from bson import json_util
import json
from bson.objectid import ObjectId
import datetime

client = MongoClient()
db = client['todolist']
collection = db['items']
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'

@app.route('/api/items',methods=['GET'])
def getCells():
    return dumps(collection.find().sort('_id', -1))

@app.route('/api/<item>',methods=['GET'])
def getCell(item):
    cell_ID = ObjectId(item)
    cell = collection.find_one({"_id":cell_ID})

    if cell is not None:
        cell['success'] = True
        return json.dumps(cell,default=json_util.default), 200, {'ContentType' : 'application,json'}
    else:
        return json.dumps({"success":False}), 404, {'ContentType' : 'application,json'}

@app.route('/api/submit',methods=['POST'])
def postCell():
    received_json_data=json.loads(request.data)

    data = {
        "content": received_json_data["content"],
        "date": datetime.datetime.utcnow()
    }

    try:
        post_id = collection.insert_one(data).inserted_id
        post = str(post_id)

        return json.dumps({'success':True, 'post_id':post}), 201, {'ContentType':'application/json'} 
    except:
        raise
        return json.dumps({'success':False}), 408, {'ContentType':'application/json'}


@app.route('/api/edit/<item>',methods=['PUT'])
def editCell(item):
    received_json_data=json.loads(request.data)
    content = received_json_data['content']
    cellID = ObjectId(item)
    try:
        post = collection.update_one({'_id':cellID},{'$set':{'content':content}})
        return json.dumps({'success':True, 'post_id':item}), 201, {'ContentType':'application/json'} 
    except:
        return json.dumps({'success':False}), 408, {'ContentType':'application/json'} 
        raise

@app.route('/api/delete/<item>',methods=['DELETE'])
def deleteCell(item):
    try:
        cellID = ObjectId(item)
        collection.delete_one({'_id':cellID})
        return json.dumps({'success':True}), 201, {'ContentType':'application/json'} 
    except:
        raise
        return json.dumps({'success':False}), 408, {'ContentType':'application/json'} 
        

# MongoDB Document Structure:
"""
{
    'content' : 'content of note',
    'date' : DATE object,
}
"""