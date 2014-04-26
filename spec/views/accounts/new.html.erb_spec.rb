require 'spec_helper'

describe "accounts/new" do
  before(:each) do
    assign(:account, stub_model(Account,
      :username => "MyString",
      :firstname => "MyString",
      :lastname => "MyString",
      :email => "MyString",
      :comments => "MyText"
    ).as_new_record)
  end

  it "renders new account form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", accounts_path, "post" do
      assert_select "input#account_username[name=?]", "account[username]"
      assert_select "input#account_firstname[name=?]", "account[firstname]"
      assert_select "input#account_lastname[name=?]", "account[lastname]"
      assert_select "input#account_email[name=?]", "account[email]"
      assert_select "textarea#account_comments[name=?]", "account[comments]"
    end
  end
end
