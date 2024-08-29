require "test_helper"

class ClientTest < ActiveSupport::TestCase
  test 'should not save client without a name' do
    client = Client.new
    assert_not client.valid?, 'Saved the client without a name'
  end
end
