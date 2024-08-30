require "test_helper"

class ClientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client = clients(:client_1)
    @building = buildings(:building_1)
  end

  test "should get client buildings with pagination" do
    get read_buildings_client_path(@client.id), params: { page: 1, per_page: 5 }
    assert_response :success
    assert_equal "success", JSON.parse(response.body)["status"]
    assert_equal JSON.parse(response.body)["data"]["buildings"].length, 5
  end

  test "should return empty list for pagination page out of range" do
    get read_buildings_client_path(@client.id), params: { page: 9999, per_page: 5 }
    assert_response :success
    response_body = JSON.parse(response.body)
    assert_equal "success", response_body["status"]
    assert_empty response_body["data"]["buildings"]
  end

  test "should return not found if client does not exist for read_buildings" do
    get read_buildings_client_path(-1)
    assert_response :not_found
  end

  test "should return not found if building does not exist for update" do
    patch edit_building_client_path(@client.id), params: {
      building: {
        id: -1
      }
    }
  
    assert_response :not_found
    response_body = JSON.parse(response.body)
    assert_equal "Record not found: Couldn't find Building with 'id'=-1", response_body["error"]
  end

  test "should create building with custom fields" do
    assert_difference('Building.count') do
      post create_building_client_path(@client.id), params: {
        building: {
          street_address: "123 Custom Lane",
          city: "Custom City",
          state: "CC",
          zip: "12345",
          color: "Mauve"
        }
      }
    end
  
    assert_response :created
    response_body = JSON.parse(response.body)
    assert_equal "Building created successfully", response_body["message"].first
    assert_includes response_body["data"], "color"
  end

  test "should update building with custom fields" do
    patch edit_building_client_path(@client.id), params: {
      building: {
        id: @building.id,
        street_address: "789 Updated Lane",
        color: "Blue"
      }
    }
  
    assert_response :created
    response_body = JSON.parse(response.body)
    assert_equal "Building updated successfully", response_body["message"].first
    @building.reload
    assert_equal "789 Updated Lane", @building.street_address
    assert_equal "Blue", @building.custom_fields["color"]
  end
end