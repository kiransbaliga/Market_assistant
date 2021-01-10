from flask import render_template, jsonify, request, make_response
from app import app, db
from app.models import User
import uuid
import jwt

@app.route('/api/register', methods=['POST'])
def create_user():
    data = request.get_json()
    required = ['username', 'name', 'email', 'password']
    
    for r in required:
        if not data.get(r):
            return jsonify({"error": f"missing argument [{r}]"})

    user = User.query.filter_by(username=data['username']).first()
    if user: return jsonify({"error": "username already exist"})

    user = User.query.filter_by(email=data['email']).first()
    if user: return jsonify({"error": "email already registered"})

    try:
        u = User(user_id=str(uuid.uuid4()), username=data['username'], name=data['name'], email=data['email'], admin=False)
        u.set_password_hash(data['password'])
        db.session.add(u)
        db.session.commit()
    except AssertionError as e:
        msg = str(e).split(":")[1]
        return jsonify({"error": msg})
    except Exception as e:
        return jsonify({"error": "invalid data"})

    return jsonify({"message": "user created!"})


@app.route('/api/user')
def get_all_users():
    users = User.query.all()
    output = []

    for user in users:
        user_data={}
        user_data['username'] = user.username
        user_data['user_id'] = user.user_id
        user_data['name'] = user.name
        user_data['email'] = user.email
        user_data['admin'] = user.admin

        output.append(user_data)

    return jsonify({"users":output})


@app.route('/api/user/<user_id>')
def get_one_user(user_id):
    user = User.query.filter_by(user_id=user_id).first()
    if not user:
        return jsonify({"error": "user not found!"}), 404

    output = {
        'username': user.username,
        'user_id': user.user_id,
        'name': user.name,
        'email': user.email,
        'admin': user.admin
    }
    return jsonify({"user": output})


@app.route('/api/user/<user_id>', methods=['DELETE'])
def delete_user(user_id):
    user = User.query.filter_by(user_id=user_id).first()
    if not user:
        return jsonify({"error": "user not found!"}), 404

    try:
        db.session.delete(user)
        db.session.commit()
    except Exception:
        return jsonify({"error": "Internal Server Error"}), 500

    output = {
        'username': user.username,
        'user_id': user.user_id,
        'name': user.name,
        'email': user.email
    }
    return jsonify({"message": "user deleted", "user": output})


@app.route('/api/login')
def login():
    auth = request.authorization
    if not auth or not auth['username'] or not auth['password']:
        return make_response("could not verify", 401, {'WWW-Authenticate': 'Basic realm="login required!"'})
    
    user = User.query.filter_by(email=auth.username).first()
    if not user:
        user = User.query.filter_by(username=auth.username).first()
        if not user:
            return make_response("could not verify", 401, {'WWW-Authenticate': 'Basic realm="login required!"'})

    if user.check_password(auth['password']):
        token = jwt.encode({'user_id': user.user_id}, app.config.get('SECRET_KEY'), algorithm="HS256")
        return jsonify({"token": token})

    return make_response("could not verify", 401, {'WWW-Authenticate': 'Basic realm="login required!"'})






















@app.route('/api/test', methods=['GET', 'POST'])
def test():
    '''Test GET and POST methods
    
    Returns food dictionary on GET request
    and an updated dictionary with new items
    on POST request
    '''

    food={
        'biriyani': 85,
        'oat meal': 25,
        'fried rice': 100
    }

    if request.method == 'POST':
        food.update(request.json)
        
    return jsonify(food), 200