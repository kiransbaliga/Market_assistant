from flask import Flask
from config import Config
from flask_sqlalchemy import SQLAlchemy

# flask setup
app = Flask(__name__)
app.config.from_object(Config)

# extensions
db = SQLAlchemy(app)

# importing all modules
from app import routes, models