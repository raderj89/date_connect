# Date Connect

Date Connect is a fun date-matching app built in one week (June 23 - June 27, 2014) during my apprenticeship at [DevShop](http://nycdevshop.com).

This app analyzes your Facebook friends, ranking your top matches based on gender, location, relationship status, religion, and overlapping interests.

The site is no longer being maintained, but a demo can be viewed [here](http://dateconnect.herokuapp.com). The site relies on background jobs, which get expensive on Heroku, so if you really want to try it out, contact me, or simply install the app yourself and run it locally.

## Install

1. Clone the repo
2. Run `bundle install`
3. Configure your database in database.yml and add your Facebook app credentials to secrets.yml. You'll need to set up an app on Facebook.
4. Run `rake db:create && rake db:migrate`
5. Run `rake jobs:work`
6. Have fun.
