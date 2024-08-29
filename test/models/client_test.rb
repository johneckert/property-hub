require "test_helper"
class ClientTest < ActiveSupport::TestCase
  test "should save client" do
    client = clients(:client_1)
    assert client.valid?, "Can't save client."
  end

  test "should not save client without name" do
    client = Client.new
    assert_not client.valid?, "Client is valid without a name."
  end
end
