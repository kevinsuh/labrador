require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

  def setup #this is used to set variables to be used throughout test suite
    @base_title = "Cardagain"
  end
  
  test "should get home" do
    get :home
    assert_response :success
    # assert_select finds the html (aka <title>) selector
    assert_select "title", "#{@base_title}"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get about" do
  	get :about
  	assert_response :success
  	assert_select "title", "About | #{@base_title}"
  end

end
