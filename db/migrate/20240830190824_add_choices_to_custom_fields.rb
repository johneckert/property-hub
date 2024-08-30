class AddChoicesToCustomFields < ActiveRecord::Migration[7.0]
  def change
    add_column :custom_fields, :choices, :jsonb, default: [], null: false
  end
end
