require "test_helper"

class CreateUserTest < ActionDispatch::IntegrationTest

  test "should create a user" do
    assert_difference('User.count', 1) do
      post users_path, params: {user: {username: "Jane", email: "jane@gmail.com", password: "password123"}}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'Jane', response.body
  end

  test "should not create user if invalid" do
    assert_no_difference('User.count') do
      post users_path, params: {user:{username: "", email: "", password: ""}}
    end
    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

end
