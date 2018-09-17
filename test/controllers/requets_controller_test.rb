require 'test_helper'

class RequetsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get requets_new_url
    assert_response :success
  end

end
