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

  test "should return not found if client does not exist for read_buildings" do
    get read_buildings_client_path(-1)
    assert_response :not_found
  end

  test "should create building for a client" do
    assert_difference('Building.count') do
      post create_building_client_path(@client.id), params: {
        building: {
          street_address: "1313 Mockingbird Lane",
          city: "Mockingbird Heights",
          state: "KY",
          zip: "23412"
        }
      }
    end

    assert_response :created
    assert_equal "Building created successfully", JSON.parse(response.body)["message"].first
  end

  test "should update building for a client" do
    patch edit_building_client_path(@client.id), params: {
      building: {
        id: @building.id,
        street_address: "456 Main St"
      }
    }

    assert_response :created
    assert_equal "Building updated successfully", JSON.parse(response.body)["message"].first
    assert_equal "456 Main St", @building.reload.street_address
  end
end
