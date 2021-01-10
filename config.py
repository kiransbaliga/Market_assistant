import os
from dotenv import load_dotenv

# loading .env file
basedir = os.path.abspath(os.path.dirname(__file__))
load_dotenv(os.path.join(basedir, '.env'))

# configuration
class Config(object):
    DEBUG = True
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'clark-kent-is-superman'
    SQLALCHEMY_DATABASE_URI = os.environ.get('SQLALCHEMY_DATABASE_URI') or "sqlite:///app.db"
    SQLALCHEMY_TRACK_MODIFICATIONS = False