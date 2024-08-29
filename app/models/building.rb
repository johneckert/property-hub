class Building < ApplicationRecord
  belongs_to :client, dependent: :delete

  after_initialize :init_custom_accessors

  private

  def init_custom_accessors
    return unless client

    fields = client.custom_fields.pluck(:internal_name)
    return if fields.empty?

    # Dynamically define accessors for each custom field
    self.singleton_class.class_eval do
      store_accessor :custom_fields, *fields
    end
  end
end