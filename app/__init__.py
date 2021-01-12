from flask import Flask
from config import Config
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

# flask setup
app = Flask(__name__)
app.config.from_object(Config)

# extensions
db = SQLAlchemy(app)
migrate = Migrate(app, db)

# importing all modules
from app import routes, models