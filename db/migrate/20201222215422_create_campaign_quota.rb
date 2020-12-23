class CreateCampaignQuota < ActiveRecord::Migration[5.2]
  def change
    create_table :campaign_quota do |t|
      t.string :name, null: false
      t.references :campaign, foreign_key: true, index: true
      t.timestamps
    end
  end
end
