class CreateCustomFields < ActiveRecord::Migration[7.0]
  def change
    create_table :custom_fields do |t|
      t.string :label, null: false
      t.string :internal_name, null: false
      t.integer :field_type, default: 0, limit: 2, null: false
      t.belongs_to :client, null: false, foreign_key: { delete: :cascade }
      t.timestamps
    end
  end
end
