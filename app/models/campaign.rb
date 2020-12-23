class Campaign < ActiveRecord::Base
  has_many :campaign_quotas, dependent: :destroy
end