from flask import render_template, jsonify, request, make_response
from app import app, db
from app.models import User, Rating
import uuid
import jwt
from functools import wraps
from ml.predictor import predictor

def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = None

        if 'Authorization' in request.headers:
            token = request.headers['Authorization'].replace("Bearer ", "")

        if not token:
            return jsonify({'message': 'Token is missing'}), 401
        
        current_user = None

        try:
            data = jwt.decode(token, app.config.get('SECRET_KEY'), algorithms=["HS256"])
            current_user = User.query.filter_by(user_id=data['user_id']).first()
            if not current_user:
                raise Exception()
        except:
            return jsonify({'message': 'Token is invalid!'}), 401

        return f(current_user, *args, **kwargs)
    
    return decorated

@app.route('/api/register', methods=['POST'])
def create_user():
    data = request.get_json()
    required = ['username', 'name', 'email', 'password']
    
    for r in required:
        if not data.get(r):
            return jsonify({"error": f"missing argument [{r}]"})

    user = User.query.filter_by(username=data['username']).first()
    if user: return jsonify({"error": "username is taken"})

    user = User.query.filter_by(email=data['email']).first()
    if user: return jsonify({"error": "email already registered"})

    try:
        user = User(user_id=str(uuid.uuid4()), username=data['username'], name=data['name'], email=data['email'], admin=False)
        user.set_password_hash(data['password'])
        db.session.add(user)
        db.session.commit()
    except AssertionError as e:
        msg = str(e).split(":")[1]
        return jsonify({"error": msg})
    except Exception as e:
        return jsonify({"error": "invalid data"})

    output = {
        'username': user.username,
        'user_id': user.user_id,
        'name': user.name,
        'email': user.email
    }

    return jsonify({"message": "user created!", "user": output})


@app.route('/api/user')
@token_required
def get_all_users(current_user):
    if not current_user.admin:
        return jsonify({"error": "cannot perform that function!"})

    print(current_user)

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
@token_required
def get_one_user(current_user, user_id):
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
@token_required
def delete_user(current_user, user_id):
    user = User.query.filter_by(user_id=user_id).first()

    if current_user==user:
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

    return jsonify({"error": "cannot perform that function!"}), 403


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
        return jsonify({"token": token, "user_id": user.user_id})

    return make_response("could not verify", 401, {'WWW-Authenticate': 'Basic realm="login required!"'})


@app.route('/api/ml/shoppinglist')
@token_required
def get_shopping_list(current_user):
    quality = current_user.ratings.quality
    brand = current_user.ratings.brand
    price = current_user.ratings.price
    offers = current_user.ratings.offers
    
    res = predictor(quality, brand, price, offers)
    return jsonify({"class": res})


@app.route('/api/user/rating', methods=['POST'])
@token_required
def set_rating(current_user):
    args = request.get_json()
    required = ['quality', 'brand', 'price', 'offers']

    for r in required:
        if not args.get(r):
            return jsonify({"error": f"missing argument [{r}]"})

    try:
        rating = Rating(quality=args['quality'], brand=args['brand'], price=args['price'], offers=args['offers'])
        current_user.ratings = rating
        db.session.add(rating)
        db.session.commit()

    except AssertionError as e:
        msg = str(e).split(":")[1]
        return jsonify({"error": msg})
    except Exception as e:
        return jsonify({"error": "invalid data"})

    output = {
        'username': current_user.username,
        'quality': rating.quality,
        'brand': rating.brand,
        'price': rating.price,
        'offers': rating.offers
    }

    return jsonify({"message": "rating added!", "output": output})


@app.route('/api/user/promote/<user_id>', methods=['PUT'])
@token_required
def promote_user(current_user, user_id):
    user = User.query.filter_by(user_id=user_id).first()
    if not user:
        return jsonify({"error": "user not found!"}), 404

    user.admin = True
    db.session.commit()
    output = {
        'username': user.username,
        'user_id': user.user_id,
        'name': user.name,
        'email': user.email,
        'admin': user.admin
    }
    return jsonify({"message": "user promoted", "user": output})










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