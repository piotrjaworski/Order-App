## README
[ ![Codeship Status for piotrjaworski/Order-App](https://codeship.com/projects/b97953b0-16af-0132-1b16-5e9521f3a2db/status)](https://codeship.com/projects/33934)
# Live on Heroku
```bash
http://zamawiarka.herokuapp.com/
```
## Readme
Application based on Ruby 2.1.5, Rails 4.1.4, PostreSQL and Bootstrap 2. <br>
The idea is to collect all orders from your workplace for dinner into one place - this application and make a one common order for a food. <br>
After you try your dinner, you can share with your co-workers your opinion about products / restaurants and rate them. <br>
This application also makes stats, how much you spent for ordering food, your orders history and many other great features - just try it. <br>
I left in repo database.yml file intentionally - feel free to cutomize it.
## Facebook login
Application enables to login via Facebook, so you need to configure your private "development" application on Facebook.<br>
Add this lines below to your application.yml:<br>
```ruby
development:
  FACEBOOK_APP_ID: "your app id"
  FACEBOOK_SECRET: "your secret key"
```
## Admin panel
You can manage whole application from an admin panel, just go to a localhost/admin page.
```bash
login: admin@example.com
password: password
```
## Application setup
```bash
git clone git@github.com:piotrjaworski/Order-App.git
cd Order-App
bundle install
rake db:create
rake db:migrate
rails s
```
