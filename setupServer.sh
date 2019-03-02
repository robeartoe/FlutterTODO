#!/bin/bash
pip install virtualenv
pip install autoenv


cd server/

virtualenv venv

source venv/bin/activate

pip install -r requirements.txt

echo "Installing: MongoDB"
if [[ "$OSTYPE" == "linux-gnu" ]]; then
        # https://docs.mongodb.com/v3.4/tutorial/install-mongodb-on-ubuntu/
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
        echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
        sudo apt-get update
        sudo apt-get install -y mongodb-org
        sudo service mongod start
elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        # https://docs.mongodb.com/v3.4/tutorial/install-mongodb-on-os-x/
        brew tap mongodb/brew
        brew install mongodb-community@3.4
        brew services start mongodb-community@3.4
fi

echo "All is installed. CD to the server folder, and it should automatically enter the virtualenv."