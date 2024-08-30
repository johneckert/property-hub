require "test_helper"

class BuildingsControllerTest < ActionDispatch::IntegrationTest
  test "should get client buildings with pagination" do
    get buildings_index_url, params: { page: 1, per_page: 5 }
    assert_response :success
    assert_equal "success", JSON.parse(response.body)["status"]
    assert_equal JSON.parse(response.body)["data"]["buildings"].length, 5
  end

  test "should return empty list for pagination page out of range" do
    get buildings_index_url, params: { page: 9999, per_page: 5 }
    assert_response :success
    response_body = JSON.parse(response.body)
    assert_equal "success", response_body["status"]
    assert_empty response_body["data"]["buildings"]
  end
end
