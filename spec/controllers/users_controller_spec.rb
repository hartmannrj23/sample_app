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

    it "should have the right title", :chapter7 => true do
      get :show, :id => @user
      response.should have_selector('title', :content => @user.name)
    end

    it "should have the user's name", :chapter7 => true do
      get :show, :id => @user
      response.should have_selector('h1', :content => @user.name)
    end

    it "should hve a profile image", :chapter7 => true do
      get :show, :id => @user
      response.should have_selector('h1>img', :class => "gravatar" )
    end
  end

  describe "GET 'new'" do
    it "should be successful", :chapter5 => true do
      get :new
      response.should be_success
    end

    it "should have the right title", :chapter5 => true do
      get :new
      response.should have_selector('title', :content => "Sign up")
    end
  end
end
