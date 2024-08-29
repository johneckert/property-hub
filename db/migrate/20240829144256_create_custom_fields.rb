class CreateCustomFields < ActiveRecord::Migration[7.0]
  def change
    create_table :custom_fields do |t|
      t.string :label, null: false
      t.string :internal_name, null: false
      t.string :field_type, default: 0, limit: 2, null: false
      t.belongs_to :client, null: false, foreign_key: { delete: :cascade }
      t.timestamps
    end
    add_index :custom_fields, %i[internal_name], unique: true
  end
end
