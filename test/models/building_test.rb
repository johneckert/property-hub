require "test_helper"

class BuildingTest < ActiveSupport::TestCase
  fixtures :clients, :buildings

  def setup
    @client = clients(:client_1)
    @custom_field_enumerator = @client.custom_fields.create!(internal_name: 'has_pool', label: 'Has Pool', field_type: :enumerator)
    @custom_field_number = @client.custom_fields.create!(internal_name: 'number_of_bathrooms', label: 'Number of Bathrooms', field_type: :number)
    @custom_field_freeform = @client.custom_fields.create!(internal_name: 'description', label: 'Description', field_type: :freeform)
    @building = Building.new(client: @client)
    @building.valid?
  end

  test 'should not save building without client' do
    building = Building.new(street_address: '742 Evergreen Terrace', city: 'Springfield', state: 'OH', zip: '12345')
    assert_not building.save, 'Saved the building without a client'
  end

  test 'should define accessors for custom fields' do
    assert_respond_to @building, :has_pool
    assert_respond_to @building, :number_of_bathrooms
    assert_respond_to @building, :description
  end

  test 'should handle enumerator fields' do
    @building.has_pool = true
    assert_equal true, @building.has_pool
  end

  test 'should handle number fields' do
    @building.number_of_bathrooms = 3.5
    assert_equal 3.5, @building.number_of_bathrooms
  end

  test 'should handle freeform fields' do
    @building.description = 'A nice building'
    assert_equal 'A nice building', @building.description
  end

end
