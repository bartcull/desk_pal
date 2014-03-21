# DeskPal

A simple Ruby on Rails application utilizing Desk.com's API.

##Product Requirements
1. Write a Rails app that connects to the Desk.com API V2 at http://dev.desk.com. Make a test site for free at http://www.desk.com
2. The app should should use OAuth for communicating with the API
3. The app should have a menu of actions that the user can select
  a. Get a list of cases available in the first case filter and present them
  b. Get a list of labels in the site and present them
  c. Create a label called “prove it” ­ handle any API error conditions
  d. Assign that label to the first case in the case filter
