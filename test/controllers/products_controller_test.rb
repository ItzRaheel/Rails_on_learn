require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get products_home_url
    assert_response :success
  end
end
