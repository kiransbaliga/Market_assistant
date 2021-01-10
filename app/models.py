from app import app, db
from sqlalchemy.orm import validates
from werkzeug.security import generate_password_hash, check_password_hash
import re

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.String(50), unique=True, nullable=False)
    username = db.Column(db.String(50), unique=True, nullable=False)
    name = db.Column(db.String(50), nullable=False)
    email = db.Column(db.String(50), unique=True, nullable=False)
    password = db.Column(db.String(80), nullable=False)
    admin = db.Column(db.Integer, default=False)

    def set_password_hash(self, password):
        assert User.validate_password(password), "error:invalid password"
        self.password = generate_password_hash(password, method="sha256")

    def check_password(self, password):
        return check_password_hash(self.password, password)

    @validates('username')
    def validate_username(self, key, value):
        assert len(value) > 1, "error:invalid username"
        return value.lower()

    @validates('email')
    def validate_email(self, key, address):
        regex = '^[a-z0-9]+[\._]?[a-z0-9]+[@]\w+[.]\w{2,3}$'
        assert re.search(regex, address), "error:invalid email"
        return address

    @validates('name')
    def validate_name(self, key, value):
        assert len(value) > 1, "error:invalid name"
        return value.lower()

    @classmethod
    def validate_password(cls, password):
        regex = '^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$'
        if not re.search(regex, password):
            return False
        else:
            return True