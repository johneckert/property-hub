#borrowed from this example: https://github.com/Syndicode/rails_custom_fields

class CustomFieldDecorator < SimpleDelegator
  def initialize(object)
    super
    init_custom_accessors
  end

  protected

  def init_custom_accessors
    client = __getobj__.client
    fields = client&.custom_fields&.pluck(:internal_name)
    return if fields.blank?

    __getobj__.singleton_class.class_eval do
      store_accessor :custom_fields, *fields
    end
  end
end