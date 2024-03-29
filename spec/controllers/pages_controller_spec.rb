require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET 'home'" do
    it "should be successful", :chapter3 => "true" do
      get 'home'
      response.should be_success
    end

    it "should have the right title", :chapter3 => "true" do
      get 'home'
      response.should have_selector("title",
                                    :content => "#{@base_title} | Home")
    end

    it "should have a non-blank body", :chapter3 => "true" do
      get 'home'
      response.body.should_not =~ /<body>\s*<\/body>/
    end
  end

  describe "GET 'contact'" do
    it "should be successful", :chapter3 => "true" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title", :chapter3 => "true" do
      get 'contact'
      response.should have_selector("title",
                                    :content => "#{@base_title} | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful", :chapter3 => "true" do
      get 'about'
      response.should be_success
    end

    it "should have the right title", :chapter3 => "true" do
      get 'about'
      response.should have_selector("title",
                                    :content => "#{@base_title} | About")
    end
  end

  describe "GET 'help'" do
    it "should be successful", :chapter3 => "true" do
      get 'help'
      response.should be_success
    end

    it "should have the right title", :chapter3 => "true" do
      get 'help'
      response.should have_selector("title",
                                    :content => "#{@base_title} | Help")
    end
  end
end
