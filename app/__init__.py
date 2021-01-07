from flask import Flask
from config import Config

# flask setup
app = Flask(__name__)
app.config.from_object(Config)

# importing all modules
from app import routes, models