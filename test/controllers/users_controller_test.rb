require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:joe)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

end
