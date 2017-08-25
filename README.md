
# Dashing Dashboard Example

This a list of widget examples in one global dashboard.

# Installation

- clone the project
- cd /Users/YOURUSERNAME/../mba-dashing-dashbord
- sudo gem install bundler
- sudo gem install dashing
- bundle install
- bundle update
- bundle
- dashing start

# Use

Just visit the url : http://localhost:3030/_cycle  and you will all dashboards.

You can visit directly the chosen dashbord by replacing _cycle by the dashboard name.

To change the duration please use : /_cycle?duration=10


You can modify information of dashboard remotely using the api of dashing with auth_token = 'MBAToken' :

```
curl -d '{ "auth_token": "MBAToken", "_YourKey_": "_YourValue_" }' http://localhost:3030/widgets/_widgetName_
```

# More Info

Check out http://shopify.github.com/dashing for more information.
