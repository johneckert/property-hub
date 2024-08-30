require "test_helper"

class BuildingTest < ActiveSupport::TestCase
  def setup
    @client = clients(:client_1)
    @custom_field_enumerator = @client.custom_fields.create!(internal_name: 'has_solar', label: 'Has solar', field_type: :enumerator, choices: ["true", "false"])
    @custom_field_number = @client.custom_fields.create!(internal_name: 'number_of_bathrooms', label: 'Number of Bathrooms', field_type: :number)
    @custom_field_freeform = @client.custom_fields.create!(internal_name: 'description', label: 'Description', field_type: :freeform)
    @building = Building.new(client: @client)
    @building.valid?
  end

  test 'should not save building without client' do
    building = Building.new(street_address: '742 Evergreen Terrace', city: 'Springfield', state: 'OH', zip: '12345')
    assert_not building.valid?, 'Saved the building without a client'
  end

  test 'should define accessors for custom fields' do
    assert_respond_to @building, :has_solar
    assert_respond_to @building, :number_of_bathrooms
    assert_respond_to @building, :description
  end

  test 'should be valid without custom fields if none are provided' do
    @building.custom_fields = {}
    assert @building.valid?
  end

  test 'should handle enumerator fields' do
    @building.has_solar = "true"
    assert_equal "true", @building.has_solar
  end

  test 'should handle number fields' do
    @building.number_of_bathrooms = 3.5
    assert_equal 3.5, @building.number_of_bathrooms
  end

  test 'should handle freeform fields' do
    @building.description = 'A nice building'
    assert_equal 'A nice building', @building.description
  end

  test 'should not save building with invalid enumerator value' do
    @building.has_solar = "maybe"  # Invalid choice
    assert_not @building.valid?
    assert_includes @building.errors[:has_solar], "is not a valid choice"
  end

  test 'should not save building with non-numeric value for number field' do
    @building.number_of_bathrooms = "three"  # Invalid type
    assert_not @building.valid?
    assert_includes @building.errors[:custom_fields], "number_of_bathrooms must be a number"
  end
  
  test 'should not save building with non-string value for freeform field' do
    @building.description = 12345  # Invalid type
    assert_not @building.valid?
    assert_includes @building.errors[:custom_fields], "description must be a string"
  end
end
