require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#columns #side a' , :minimum => 4   #Minimum of 4 elements
	assert_select '#main .entry' , 3		# 3 products in test defined in fixtures/products.yml
	assert_select 'h3' , 'Programming Ruby 1.9'
	assert_select '.price' , /\$[,\d]+\.\d\d/
  end

end
