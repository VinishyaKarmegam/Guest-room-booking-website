from flask import Flask, render_template, request, redirect, url_for, session, flash
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
import os

# Initialize Flask application
app = Flask(__name__, template_folder='frontend/templates')
app.config['SECRET_KEY'] = b'\xc2[\xf2,\xf0\x9f\xe9\x1b.\xc7Q*5\xe1\xac\r^\x89F\x94Ux\r('
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:1234@localhost/guest_room_booking'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Initialize SQLAlchemy
db = SQLAlchemy(app)

class HouseOwner(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(150), unique=True, nullable=False)
    email = db.Column(db.String(150), unique=True, nullable=False)
    phone_number = db.Column(db.String(20), nullable=False)
    password_hash = db.Column(db.String(200), nullable=False)
    
    rooms = db.relationship('Room', back_populates='owner', lazy=True)


class Room(db.Model):
    __tablename__ = 'room'
    
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    floor_size = db.Column(db.Float, nullable=False)
    beds = db.Column(db.Integer, nullable=False)
    amenities = db.Column(db.String(200))
    rent_per_day = db.Column(db.Float, nullable=False)
    owner_id = db.Column(db.Integer, db.ForeignKey('house_owner.id'), nullable=False)
    
    owner = db.relationship('HouseOwner', back_populates='rooms')
    bookings = db.relationship('Booking', back_populates='room')

class Customer(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(150), unique=True, nullable=False)
    email = db.Column(db.String(150), unique=True, nullable=False)
    phone_number = db.Column(db.String(20), nullable=False)
    password_hash = db.Column(db.String(200), nullable=False)

    bookings = db.relationship('Booking', back_populates='customer')




class Booking(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    room_id = db.Column(db.Integer, db.ForeignKey('room.id'), nullable=False)
    customer_id = db.Column(db.Integer, db.ForeignKey('customer.id'), nullable=False)
    start_date = db.Column(db.Date, nullable=False)
    end_date = db.Column(db.Date, nullable=False)
    
    room = db.relationship('Room', back_populates='bookings')
    customer = db.relationship('Customer', back_populates='bookings')

Room.bookings = db.relationship('Booking', back_populates='room')
Customer.bookings = db.relationship('Booking', back_populates='customer')

# Routes
@app.route('/')
def home():
    return render_template('login.html')

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form.get('username')
        email = request.form.get('email')
        phone_number = request.form.get('phone_number')
        password = request.form.get('password')
        user_type = request.form.get('user_type')

        hashed_password = generate_password_hash(password, method='pbkdf2:sha256')

        if user_type == 'owner':
            existing_owner = HouseOwner.query.filter_by(email=email).first()
            if existing_owner:
                flash('Email already registered as an owner.')
                return redirect(url_for('register'))
            new_user = HouseOwner(username=username, email=email, phone_number=phone_number, password_hash=hashed_password)
        elif user_type == 'customer':
            existing_customer = Customer.query.filter_by(email=email).first()
            if existing_customer:
                flash('Email already registered as a customer.')
                return redirect(url_for('register'))
            new_user = Customer(username=username, email=email, phone_number=phone_number, password_hash=hashed_password)
        else:
            flash('Invalid user type')
            return redirect(url_for('register'))

        try:
            db.session.add(new_user)
            db.session.commit()
            flash('Registration successful! Please login.')
            return redirect(url_for('login'))
        except Exception as e:
            db.session.rollback()
            flash(f'Registration failed: {e}')
            return redirect(url_for('register'))

    return render_template('register.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')

        # Check in HouseOwner table
        owner = HouseOwner.query.filter_by(username=username).first()
        if owner:
            if check_password_hash(owner.password_hash, password):
                session['user_id'] = owner.id
                session['user_type'] = 'house_owner'
                flash('Login successful! Redirecting to owner dashboard...', 'success')
                return redirect(url_for('owner_dashboard'))
            else:
                flash('Invalid password for owner. Please try again.', 'danger')

        # Check in Customer table
        customer = Customer.query.filter_by(username=username).first()
        if customer:
            if check_password_hash(customer.password_hash, password):
                session['user_id'] = customer.id
                session['user_type'] = 'customer'
                flash('Login successful! Redirecting to search...', 'success')
                return redirect(url_for('customer_dashboard'))
            else:
                flash('Invalid password for customer. Please try again.', 'danger')

        # If no match
        flash('Invalid username. Please try again.', 'danger')

    return render_template('login.html')



@app.route('/owner_dashboard')
def owner_dashboard():
    if 'user_id' in session and session['user_type'] == 'house_owner':
        owner = HouseOwner.query.get(session['user_id'])
        if owner:
            rooms = Room.query.filter_by(owner_id=owner.id).all()
            return render_template('owner_dashboard.html', owner=owner, rooms=rooms)
    return redirect(url_for('login'))



@app.route('/add_room', methods=['GET', 'POST'])
def add_room():
    app.logger.info("Add room route accessed")
    if 'user_id' not in session or session['user_type'] != 'house_owner':
        return redirect(url_for('login'))
    
    if request.method == 'POST':
        name = request.form['name']
        floor_size = request.form['floor_size']
        beds = request.form['beds']
        amenities = request.form['amenities']
        rent_per_day = request.form['rent_per_day']

        new_room = Room(
            name=name,
            floor_size=floor_size,
            beds=beds,
            amenities=amenities,
            rent_per_day=rent_per_day,
            owner_id=session['user_id']
        )
        db.session.add(new_room)
        db.session.commit()
        flash('Room added successfully!')
        return redirect(url_for('owner_dashboard'))
    
    return render_template('add_room.html')

@app.route('/edit_room/<int:room_id>', methods=['GET', 'POST'])
def edit_room(room_id):
    # Fetch the room by its ID
    room = Room.query.get_or_404(room_id)
    
    if request.method == 'POST':
        # Update room details based on form data
        room.name = request.form.get('name')
        room.floor_size = request.form.get('floor_size')
        room.beds = request.form.get('beds')
        room.amenities = request.form.get('amenities')
        room.rent_per_day = request.form.get('rent_per_day')
        
        # Commit changes to the database
        db.session.commit()
        flash('Room updated successfully!')
        return redirect(url_for('owner_dashboard'))
    
    # Render the edit room template with the room data
    return render_template('edit_room.html', room=room)


@app.route('/room_details/<int:room_id>')
def room_details(room_id):
    app.logger.info("Room details route accessed")
    room = Room.query.get_or_404(room_id)
    return render_template('room_details.html', room=room)

@app.route('/delete_room/<int:room_id>', methods=['POST'])
def delete_room(room_id):
    app.logger.info("Delete room route accessed")
    if 'user_id' not in session or session['user_type'] != 'house_owner':
        return redirect(url_for('login'))

    room = Room.query.get_or_404(room_id)
    if room.owner_id != session['user_id']:
        flash('Unauthorized access')
        return redirect(url_for('owner_dashboard'))

    db.session.delete(room)
    db.session.commit()
    flash('Room deleted successfully!')
    return redirect(url_for('owner_dashboard'))

@app.route('/customer_dashboard', methods=['GET', 'POST'])
def customer_dashboard():
    if request.method == 'POST':
        start_date = request.form.get('start_date')
        end_date = request.form.get('end_date')

        # Query to find available rooms that are not booked within the specified date range
        available_rooms = Room.query.filter(~Room.bookings.any(
            (Booking.start_date <= end_date) & (Booking.end_date >= start_date)
        )).all()

        return render_template('customer_dashboard.html', rooms=available_rooms, start_date=start_date, end_date=end_date)
    
    return render_template('customer_dashboard.html', rooms=None)


@app.route('/book_room/<int:room_id>', methods=['POST'])
def book_room(room_id):
    app.logger.info("Book room route accessed")
    if 'user_id' not in session or session['user_type'] != 'customer':
        return redirect(url_for('login'))

    start_date = request.form['start_date']
    end_date = request.form['end_date']
    booking = Booking(start_date=start_date, end_date=end_date, room_id=room_id, customer_id=session['user_id'])
    db.session.add(booking)
    db.session.commit()
    flash('Room booked successfully!')
    return redirect(url_for('search'))

@app.route('/logout')
def logout():
    app.logger.info("Logout route accessed")
    session.pop('user_id', None)
    session.pop('user_type', None)
    return redirect(url_for('login'))

@app.route('/test_db')
def test_db():
    app.logger.info("Test DB route accessed")
    try:
        with db.engine.connect() as connection:
            result = connection.execute('SELECT VERSION()')
            version = result.fetchone()
            return f'Database version: {version[0]}'
    except Exception as e:
        return str(e)

if __name__ == '__main__':
    app.logger.info("Starting Flask app")  
    app.run(debug=True, port=5001)



