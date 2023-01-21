require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:jordan)
  end

  test "layout header and footer links when logged out" do    
    get root_path
    assert_template 'static_pages/home'
    # Rails is automatically inserting the value of the path where the ? is
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")
  end

  test "layout links when logged in" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", users_path
  end

  test "sign up path" do
    get signup_path
    assert_select "title", full_title("Sign up")
  end
end
