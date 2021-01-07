from flask import render_template, jsonify, request
from app import app

@app.route('/')
def home():
    return render_template('index.html')


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