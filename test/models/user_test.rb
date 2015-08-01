require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup		
		@user = User.new(name: "Kevin Suh", email: "ksuh@dinnerlab.com", password: "kevinsuh", password_confirmation: "kevinsuh")
	end

	test "should be valid" do
		assert @user.valid?
	end

	test "name should be present" do
		@user.name = "    "
		assert_not @user.valid?
	end

	test "name cannot be too long" do
		name = 'a' * 51
		@user.name = name
		assert_not @user.valid?
	end

	test "email should be present" do
		@user.email = "   "
		assert_not @user.valid?
	end

	test "email cannot be too long" do
		email = 'a' * 256
		@user.email = email
		assert_not @user.valid?
	end

	test "email validation should accept valid emails" do
		valid_emails = %w[foobar@mail.com USER@foo.com A_US-ER@foo.com aUsEr_43Rbb@baz.cn]
		valid_emails.each do |email|
			@user.email = email
			assert @user.valid?, "#{email.inspect} should be valid"
		end
	end

	test "email validation should not accept these emails" do
		invalid_emails = %w[invalidEmail@.COM invalidEmail@mail,com invalidEmail_at_test.org email@mail+mail.com mail@gmail..com]
		invalid_emails.each do |email|
			@user.email = email
			assert_not @user.valid?, "#{email} should be marked as invalid, but it's not"
		end
	end

	test "email should be unique" do
		duplicate_user = @user.dup
		@user.save
		assert_not duplicate_user.valid?

		# case-sensitivity should not matter in uniqueness
		duplicate_user.email = @user.email.upcase
		assert_not duplicate_user.valid?

	end

	test "email should be saved as lowercase" do
		mixed_case_email = "kEviNSUH34@maIl.cOm"
		@user.email = mixed_case_email
		@user.save

		# it should lowercase it via before_save callback
		assert_equal mixed_case_email.downcase, @user.email

	end

	test "password should be valid" do
		@user.password = "notvalid"
		assert_not @user.valid?

		@user.password = @user.password_confirmation = "short" #minimum 6 chars
		assert_not @user.valid?

		@user.password = @user.password_confirmation = "validpassword"
		assert @user.valid?
	end

end
