
# Flask App Template

### Installation

#### First, clone this repository.

    $ git clone git@github.com:kiransbaliga/Market_assistant.git
    $ cd Market_assistant

#### Create a virtualenv, and activate this: 

    $ python3 -m venv env
    $ source env/bin/activate

#### After, install all necessary to run:

    $ pip install -r requirements.txt


#### Configuration

 - Create .env file
	
		$ touch .env		 

 - Add the below config:
		 
		FLASK_ENV=development
		FLASK_APP=market.py

#### Then, run the application:

	$ flask run

#### To see your application, access this url in your browser: 

	http://localhost:5000
