require "test_helper"

class MicropostsInterface < ActionDispatch::IntegrationTest
  def setup
    @user = users(:jordan)
    log_in_as(@user)
  end
end

class MicropostsInterfaceTest < MicropostsInterface
  test "should paginate microposts" do
    get root_path
    assert_select "div.pagination"
  end

  test "should show errors but not create micropost on invalid submission" do
    assert_no_difference "Micropost.count" do
      post microposts_path, params: { micropost: { content: "" } }
    end
    assert_select "div#error_explanation"
    assert_select "a[href=?]", "/?page=2" #correct pagination link
  end

  test "should have micropost delete links on own profile page" do
    get users_path(@user)
    assert_select "a", text: "delete"
  end

  test "should be able to delete own micropost" do
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference "Micropost.count", -1 do
      delete micropost_path(first_micropost)
    end
  end

  test "should not have delete links on other user's profile page" do
    get user_path(users(:archer))
    assert_select "a", { text: "delete", count: 0 }
  end
end

class ImageUploadTest < MicropostsInterface

  test "should have a file input field for images" do
    get root_path
    assert_select 'input[type=file]'
  end

  test "should be able to attach an image do" do
    cont = "this micropost really ties the room together"
    img = fixture_file_upload('test/fixtures/kitten.jpg', 'image/jpeg')
    post microposts_path, params: {
      micropost: {
        content: cont,
        image: img
      }
    }
    latest_post = assigns(:micropost)
    # debugger
    assert latest_post.image.attached?
  end
end  
