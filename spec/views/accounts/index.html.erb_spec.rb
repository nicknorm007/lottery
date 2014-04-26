require 'spec_helper'

describe "accounts/index" do
  before(:each) do
    assign(:accounts, [
      stub_model(Account,
        :username => "Username",
        :firstname => "Firstname",
        :lastname => "Lastname",
        :email => "Email",
        :comments => "MyText"
      ),
      stub_model(Account,
        :username => "Username",
        :firstname => "Firstname",
        :lastname => "Lastname",
        :email => "Email",
        :comments => "MyText"
      )
    ])
  end

  it "renders a list of accounts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Username".to_s, :count => 2
    assert_select "tr>td", :text => "Firstname".to_s, :count => 2
    assert_select "tr>td", :text => "Lastname".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
