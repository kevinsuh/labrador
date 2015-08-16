require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do

    # currently no mail functionality yet
    user = User.create(name: "Test User",
                       email: "testuser@gmail.com",
                       password: "foobar1",
                       password_confirmation: "foobar1")
    mail = UserMailer.account_activation(user)
    assert_equal "Account Activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["hello@cardagain.com"], mail.from
    assert_match "Hi", mail.body.encoded
    assert_match user.name, mail.body.encoded

    # account_activation URL
    assert_match user.activation_token, mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end

  test "password_reset" do
    user = User.create(name: "Test User",
                       email: "testuser@gmail.com",
                       password: "foobar1",
                       password_confirmation: "foobar1")
    user.reset_password
    mail = UserMailer.password_reset(user)
    assert_equal "Reset Password", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["hello@cardagain.com"], mail.from
    assert_match "Hi", mail.body.encoded
    assert_match user.name, mail.body.encoded

    # password_reset URL
    assert_match user.password_reset_token, mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end

end
