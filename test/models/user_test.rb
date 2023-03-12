require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user =
      User.new(
        name: "Example User",
        email: "user@example.com",
        password: "secure123",
        password_confirmation: "secure123",
      )
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "   "
    refute @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    refute @user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "name should be under 50 chars" do
    @user.name = "a" * 51
    refute @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    refute @user.valid?
  end

  test "email validation should accept valid emails" do
    valid_addresses = %w[
      user@example.com
      TEST@run.edu
      trial_snake-case@place.co.uk
    ]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should rejected invalid emails" do
    invalid_addresses = %w[
      user@example,com
      user_at_work.org
      user.name@example.
      user@test+run..com
    ]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      refute @user.valid? "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lowercase" do
    mixed_case_email = "Name@ExamPLE.cOM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, "")
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    jordan = users(:jordan)
    archer = users(:archer)
    assert_not jordan.following?(archer)
    
    jordan.follow(archer)
    assert jordan.following?(archer)
    assert archer.followers.include?(jordan)

    jordan.unfollow(archer)
    assert_not jordan.following?(archer)

    jordan.follow(jordan)
    assert_not jordan.following?(jordan)
  end
end
