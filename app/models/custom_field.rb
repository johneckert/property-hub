class CustomField < ApplicationRecord
  belongs_to :client

  validates :client, :field_type, :label, :internal_name, presence: { message: "can't be blank" }
  validates :internal_name, uniqueness: { scope: :client_id }
  validate :validate_enum_choices

  before_validation :parameterize_internal_name
  

  enum field_type: {
    number: 0,
    freeform: 1,
    enumerator: 2
  }.freeze


  private

  def validate_enum_choices
    return unless enumerator?

    if choices.blank? || !choices.is_a?(Array)
      errors.add(:choices, "must be a non-empty array when field type is 'enumerator'")
    end
  end

  def parameterize_internal_name
    return if internal_name.blank?

    self.internal_name =  internal_name.parameterize(separator: '_').underscore
  end

end
