class CampaignQualification < ActiveRecord::Base
  belongs_to :campaign_quota, counter_cache: true
end