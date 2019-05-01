import datetime
import json

from flask import Flask, request

from bson import json_util
from bson.json_util import dumps
from bson.objectid import ObjectId
from pymongo import MongoClient

CLIENT = MongoClient()
DB = CLIENT['todolist']
COLLECTION = DB['items']
APP = Flask(__name__)

@APP.route('/')
def hello_world():
    return 'Hello, World!'

@APP.route('/api/items', methods=['GET'])
def get_cells():
    return dumps(COLLECTION.find().sort('_id', -1))

@APP.route('/api/<item>', methods=['GET'])
def get_cell(item):
    cell_id = ObjectId(item)
    cell = COLLECTION.find_one({"_id":cell_id})

    if cell is not None:
        cell['success'] = True
        return json.dumps(cell, default=json_util.default), 200, \
            {'ContentType' : 'APPlication,json'}
    else:
        return json.dumps({"success":False}), 404, {'ContentType' : 'APPlication,json'}

@APP.route('/api/submit', methods=['POST'])
def post_cell():
    received_json_data = json.loads(request.data)

    data = {
        "content": received_json_data["content"],
        "date": datetime.datetime.utcnow()
    }

    try:
        post_id = COLLECTION.insert_one(data).inserted_id
        post = str(post_id)

        return json.dumps({'success':True, 'post_id':post}), 201, {'ContentType':'APPlication/json'}
    except:
        raise
        # return json.dumps({'success':False}), 408, {'ContentType':'APPlication/json'}


@APP.route('/api/edit/<item>', methods=['PUT'])
def edit_cell(item):
    received_json_data = json.loads(request.data)
    content = received_json_data['content']
    cell_id = ObjectId(item)
    try:
        COLLECTION.update_one({'_id':cell_id}, {'$set':{'content':content}})
        return json.dumps({'success':True, 'post_id':item}), 201, {'ContentType':'APPlication/json'}
    except:
        return json.dumps({'success':False}), 408, {'ContentType':'APPlication/json'}
        # raise

@APP.route('/api/delete/<item>', methods=['DELETE'])
def delete_cell(item):
    try:
        cell_id = ObjectId(item)
        COLLECTION.delete_one({'_id':cell_id})
        return json.dumps({'success':True}), 201, {'ContentType':'APPlication/json'}
    except:
        # return json.dumps({'success':False}), 408, {'ContentType':'APPlication/json'}
        raise
