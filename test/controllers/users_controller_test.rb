require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:jordan)
    @alternate_user = users(:elaine)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: {
      user: {
        name: @user.name,
        email: @user.email
      }
    }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@alternate_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@alternate_user)
    patch user_path(@user), params: {
      user: {
        name: @user.name,
        email: @user.email
      }
    } 
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should prevent editing admin attribute via patch request" do
    log_in_as(@alternate_user)
    assert_not @alternate_user.admin?
    patch user_path(@alternate_user), params: {
      user: {
        password: "password",
        password_confirmation: "password",
        admin: true
      }
    }
    assert_not @alternate_user.reload.admin?
  end

end
