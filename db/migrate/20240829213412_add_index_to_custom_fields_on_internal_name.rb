class AddIndexToCustomFieldsOnInternalName < ActiveRecord::Migration[7.0]
  def change
    add_index :custom_fields, [:client_id, :internal_name], unique: true
  end
end
