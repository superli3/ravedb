require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:jeff)
  end

  test "unsuccessful edit" do
  	log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { username:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
  end

  test "successful edit" do
  	log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    username  = "FooBar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { username:  username,
                                              email: email,
                                              password:              "testing",
                                              password_confirmation: "testing" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal username,  @user.username
    assert_equal email, @user.email
  end


   test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    username  = "FooBar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { username:  username,
                                              email: email,
                                              password:              "testing",
                                              password_confirmation: "testing" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal username,  @user.username
    assert_equal email, @user.email
  end
end

