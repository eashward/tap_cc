class AddCampaignQualificationsCountToCampaignQuota < ActiveRecord::Migration[5.2]
  def change
    add_column :campaign_quota, :campaign_qualifications_count, :integer
  end
end
