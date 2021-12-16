# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 2.6.3

* System dependencies
gem 'aasm'
gem 'activeadmin'
gem 'chartkick'
gem 'devise'
gem 'groupdate'
gem 'kaminari'
gem 'mini_magick'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'paranoia', '~> 2.2'
gem 'ransack'
gem 'rollbar'
gem 'sendgrid-ruby'

* Deployment instructions
* 
* 1. Installing heroku
* 2. Log in using your Heroku account’s email address and password.
* 3. Create a app on Heroku: 
*    heroku create
* 4. Verify that the remote was added to the project running
*    git config --list --local | grep heroku
* 5. Deploy the code
*    git push heroku main
* 6. Migrate the database
*    heroku run rake db:migrate
* 7. Run the seeds
*    heroku run rake db:seed
* 8. Add the environment variables on heroku settings
*    GOOGLE_CLIENT_ID
*    GOOGLE_CLIENT_SECRET
*    SENDGRID_API_KEY
*    ROLLBAR_ACCESS_TOKEN
*    (Database variables was setted when you migrated the database)
* 9. Check the app's dynos with
*    heroku ps
* 10. Run the app with
*    heroku open
* Note: If you have any problem use heroku logs and check the heroku's documentation here: https://devcenter.heroku.com/articles/getting-started-with-rails6
* 
