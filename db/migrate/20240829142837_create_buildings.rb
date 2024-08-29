class CreateBuildings < ActiveRecord::Migration[7.0]
  def change
    create_table :buildings do |t|
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip
      t.belongs_to :client, null: false, foreign_key: { delete: :cascade }
      t.jsonb :custom_fields, null: false, default: {}, index: { using: :gin }

      t.timestamps
    end
  end
end
