# README
### Setup
* Clone Repo
* run bundle install and rake db:setup

### Insertions
* Update Username and Api token in `app/services/api_client/campaigns_client.rb` to Authorize campaign resource.
* Process cmpaign cretion with rake command `rails campaign:insert` or launch rails console and run `CampaignsService.new.insert_campaigns`

### Fetching compaigns from `tap_cc` 
* End point for ordered campaigns `http://localhost:3000/api/campaigns/ordered_campaigns` 

