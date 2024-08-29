require "test_helper"
class ClientTest < ActiveSupport::TestCase
  test "should not save client without name" do
    client = Client.new
    assert_not client.valid?, "Client is valid without a name."
  end
end
