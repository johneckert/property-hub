class Building < ApplicationRecord
  belongs_to :client
  validates :client, presence: true

  after_initialize :init_custom_accessors

  validate :validate_custom_fields

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

  def validate_custom_fields
    return unless client
  
    client.custom_fields.each do |custom_field|
      next unless custom_fields.key?(custom_field.internal_name)

      value = custom_fields[custom_field.internal_name]

      if custom_field.enumerator? && !custom_field.choices.include?(value)
        errors.add(custom_field.internal_name, "is not a valid choice")
      end
  
      case custom_field.field_type
      when "number"
        validate_number_field(custom_field.internal_name, value)
      when "freeform"
        validate_freeform_field(custom_field.internal_name, value)
      when "enumerator"
        validate_enumerator_field(custom_field.internal_name, value)
      end
    end
  end

  def validate_number_field(field_name, value)
    unless value.is_a?(Numeric)
      errors.add(:custom_fields, "#{field_name} must be a number")
    end
  end

  def validate_freeform_field(field_name, value)
    unless value.is_a?(String)
      errors.add(:custom_fields, "#{field_name} must be a string")
    end
  end

  def validate_enumerator_field(field_name, value)
    unless value.is_a?(String)
      errors.add(:custom_fields, "#{field_name} must be a string")
    end
  end
end