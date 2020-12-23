class CampaignQuota < ActiveRecord::Base
  belongs_to :campaign
  has_many :campaign_qualifications, dependent: :destroy
  accepts_nested_attributes_for :campaign_qualifications, allow_destroy: true
end
