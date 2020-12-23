class CreateCampaignQualifications < ActiveRecord::Migration[5.2]
  def change
    create_table :campaign_qualifications do |t|
      t.integer :question_id, null: false
      t.text :pre_codes, null: false
      t.references :campaign_quota, foreign_key: true, index: true
      t.timestamps
    end
  end
end
