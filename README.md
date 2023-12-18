# Team Members

- Erica McGillicuddy, em3489
- Rutvik Rau, rr3366
- Andrew Jung, asj2156
- Eithan Jahja-Loo, eij2108

## To Start and Test Locally

- git clone https://github.com/andy-sy-jung/Bridge.git
- bundle install --without production
- rails db:migrate
- rake db:seed
- rails server -b 0.0.0.0

**Heroku Link**: https://guarded-escarpment-94993-1fc742c1d1ba.herokuapp.com

**Basic Features**

- Creating an account, we save the info in a pg databse
- Login/Logout
- You will now see other postings of people and their services, interact with them by looking into their info
- Creating a new posting for you and the services you offer.

**Additional Features**

- Added post creation validation
- Added editing feature for posts (only for owner of posting)
- Added deletion method for posts (only for owner of posting)
- Made UI slightly prettier
- Added filtering based on subject, and user or professional
- Added page for viewing own postings
