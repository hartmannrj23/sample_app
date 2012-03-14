require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'", :chapter5 => "true" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "should have a Contact page at '/contact'", :chapter5 => "true" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "should have an About page at '/about'", :chapter5 => "true" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end

  it "should have a Help page at '/help'", :chapter5 => "true" do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end

  it "should have a sign-up page at '/signup'", :chapter5 => "true" do
    get '/signup'
    response.should have_selector('title', :content => "Sign up")
  end

  it "should have the right links on the layout", :chapter5 => "true" do
    visit root_path
    response.should have_selector('title', :content => "Home")
    click_link "About"
    response.should have_selector('title', :content => "About")
    click_link "Contact"
    response.should have_selector('title', :content => "Contact")
    click_link "Home"
    response.should have_selector('title', :content => "Home")
    click_link "Sign up now!"
    response.should have_selector('title', :content => "Sign up")
    response.should have_selector('a[href="/"]>img')
  end
end
