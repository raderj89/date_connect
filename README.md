# Date Connect

Date Connect is a fun date-matching app built in one week (June 23 - June 27, 2014) during my apprenticeship at [DevShop](http://nycdevshop.com).

This app analyzes your Facebook friends, ranking your 'perfect matches' based on gender, location, relationship status, and overlapping interests.

## Install

1. Clone the repo
2. Run `bundle install`
3. Remove the .example extension from database.yml.example and secrets.yml.example and replace them with your credentials. You'll need to set up an app on Facebook.
4. Run `rake db:create && rake db:migrate`
5. Run `rake jobs:work`
6. Have fun.