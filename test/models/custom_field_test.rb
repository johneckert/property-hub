require "test_helper"

class CustomFieldTest < ActiveSupport::TestCase
  def setup
    @client = clients(:client_1) # Assuming you have a client fixture
    @custom_field = CustomField.new(label: "Test Field", internal_name: "test field", field_type: "number", client: @client)
  end

  test "should be valid with valid attributes" do
    assert @custom_field.valid?
  end

  test "should require a client" do
    @custom_field.client = nil
    assert_not @custom_field.valid?
    assert_includes @custom_field.errors[:client], "can't be blank"
  end

  test "should require an internal name" do
    @custom_field.internal_name = nil
    assert_not @custom_field.valid?
    assert_includes @custom_field.errors[:internal_name], "can't be blank"
  end

  test "should require a field type" do
    @custom_field.field_type = nil
    assert_not @custom_field.valid?
    assert_includes @custom_field.errors[:field_type], "can't be blank"
  end

  test "should require choices for enumerator field_type" do
    @custom_field.field_type = "enumerator"
    @custom_field.choices = nil
    assert_not @custom_field.valid?
    assert_includes @custom_field.errors[:choices], "must be a non-empty array when field type is 'enumerator'"
  end
  
  test "should validate choices as an array when field_type is enumerator" do
    @custom_field.field_type = "enumerator"
    @custom_field.choices = "not_an_array"
    assert_not @custom_field.valid?
    assert_includes @custom_field.errors[:choices], "must be a non-empty array when field type is 'enumerator'"
  end

  test "should allow blank choices for non-enumerator field_type" do
    @custom_field.field_type = "freeform"
    @custom_field.choices = nil
    assert @custom_field.valid?
  end

  test "should parameterize internal_name before validation" do
    @custom_field.internal_name = "Test Field Name"
    @custom_field.valid?
    assert_equal "test_field_name", @custom_field.internal_name
  end

  test "should handle unusual characters in internal_name" do
    @custom_field.internal_name = "Test Field!@#Name"
    @custom_field.valid?
    assert_equal "test_field_name", @custom_field.internal_name
  end

  test "should not allow duplicate internal_name for same client" do
    duplicate_field = @custom_field.dup
    @custom_field.save
    assert_not duplicate_field.valid?
    assert_includes duplicate_field.errors[:internal_name], "has already been taken"
  end
end
