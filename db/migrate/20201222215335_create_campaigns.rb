class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.bigint :source_id, null: false
      t.integer :length_of_interview, null: false
      t.decimal :cpi, null: false
      t.string :name
      t.timestamps
    end
  end
end
