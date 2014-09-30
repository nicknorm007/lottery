require 'spec_helper'

describe "accounts/show" do
  before(:each) do
    @account = assign(:account, stub_model(Account,
      :username => "Username",
      :firstname => "Firstname",
      :lastname => "Lastname",
      :email => "Email",
      :comments => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Username/)
    rendered.should match(/Firstname/)
    rendered.should match(/Lastname/)
    rendered.should match(/Email/)
    rendered.should match(/MyText/)
  end
end
