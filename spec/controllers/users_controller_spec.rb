require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'show'" do

    before (:each) do
      @user = Factory(:user)
   end

    it "should be successful", :chapter7 => true do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user", :chapter7 => true do
      get :show, :id => @user
      assigns(:user).should == @user
    end
  end

  describe "GET 'new'" do
    it "should be successful", :chapter5 => "true" do
      get :new
      response.should be_success
    end

    it "should have the right title", :chapter5 => "true" do
      get :new
      response.should have_selector('title', :content => "Sign up")
    end
  end
end
