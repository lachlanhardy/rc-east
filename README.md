# Railscamp USA - East Coast

A first cut at a landing page to take signups for interested folks

## Setup

It's a simple Sinatra app to serve a few static pages.

### Local

1.  `$ cp .env.example .env`
2. Assign local or staging keys to variables in .env
3.  `$ bundle install`
4.  `$ foreman start`
5. Go to http://0.0.0.0:5000

### Heroku

#### Staging
1. Set up your-app-name-staging.herokuapp.com
2. Set staging config vars
  a. RACK_ENV=staging

#### Production
1. Set up your-app-name.herokuapp.com
2. Set production config vars


Deployment
----------

We're using Heroku Pipelines with Github integration so:

* Pull Requests create their own Review Apps on Heroku
* Any update to `master` deploys to *staging*
* *staging* can be promoted to *production* via the Heroku interface or this command: `$ heroku pipelines:promote -r staging`

**Staging**

To deploy to staging: Create a pull request on Github and have it accepted before merging.

If you need to deploy directly to staging: `git push staging master`

[http://rc-east-staging.herokuapp.com/]()

**Production**

To deploy to production: `heroku pipelines:promote -r staging`

[http://rc-east.herokuapp.com/]()