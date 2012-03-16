require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

  it "should create a new instance given a valid attribute", :chapter6 => "true" do
    User.create!(@attr)
  end

  it "should require a name", :chapter6 => "true" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should require an email address", :chapter6 => "true" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject names that are too long", :chapter6 => "true" do
    long_name = "a" * 51
    long_name_user =  User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  it "should accept valid email addresses", :chapter6 => "true" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses", :chapter6 => "true" do
    addresses = %w[user@foo,com user_at)foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses", :chapter6 => "true" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case", :chapter6 => "true" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "passwords" do

    before(:each) do
      @user = User.new(@attr)
    end

    it "should have a password attribute", :chapter7 => true do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute", :chapter7 => true do
      @user.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do
    it "should require a password", :chapter7 => true do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation", :chapter7 => true do
      User.new(@attr.merge(:password_confirmation => "invalid")).
          should_not be_valid
    end

    it "should reject short passwords", :chapter7 => true do
      short = "a"  *5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject long passwords", :chapter7 => true do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute", :chapter7 => true do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute", :chapter7 => true do
      @user.encrypted_password.should_not be_blank
    end

    it "should have a salt", :chapter7 =>true do
      @user.should respond_to(:salt)
    end

    describe "has_password? method" do
      it "should exist", :chapter7 => true do
        @user.should respond_to(:has_password?)
      end

      it "should return true if the passwords match", :chapter7 => true do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "should return false if the passwords don't match", :chapter7 => true do
        @user.has_password?("invalid").should be_false
      end

      describe "authenticate method" do
        it "should exist", :chapter7 => true do
          User.should respond_to(:authenticate)
        end

        it "should return nil on email/password mismatch", :chapter7 => true do
          User.authenticate(@attr[:email], "wrongpass").should be_nil
        end

        it "should return nil for an email address with no user", :chapter7 => true do
          User.authenticate("bar@foo.com", @attr[:password]).should be_nil
        end

        it "should return the user on email/password match", :chapter7 => true do
          User.authenticate(@attr[:email], @attr[:password]).should == @user
        end
      end
    end
  end
end



# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

