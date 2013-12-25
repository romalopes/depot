require 'test_helper'

class StoreControllerTest < ActionController::TestCase
	test "should get index not used" do
		get :index
		assert_response :success
	end
end