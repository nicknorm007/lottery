require 'spec_helper'

describe "accounts/edit" do
  before(:each) do
    @account = assign(:account, stub_model(Account,
      :username => "MyString",
      :firstname => "MyString",
      :lastname => "MyString",
      :email => "MyString",
      :comments => "MyText"
    ))
  end

  it "renders the edit account form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", account_path(@account), "post" do
      assert_select "input#account_username[name=?]", "account[username]"
      assert_select "input#account_firstname[name=?]", "account[firstname]"
      assert_select "input#account_lastname[name=?]", "account[lastname]"
      assert_select "input#account_email[name=?]", "account[email]"
      assert_select "textarea#account_comments[name=?]", "account[comments]"
    end
  end
end
