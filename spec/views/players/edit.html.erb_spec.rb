require 'spec_helper'

describe "players/edit" do
  before(:each) do
    @player = assign(:player, stub_model(Player,
      :name => "MyString",
      :position => "MyString",
      :price => 1,
      :team => "MyString"
    ))
  end

  it "renders the edit player form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", player_path(@player), "post" do
      assert_select "input#player_name[name=?]", "player[name]"
      assert_select "input#player_position[name=?]", "player[position]"
      assert_select "input#player_price[name=?]", "player[price]"
      assert_select "input#player_team[name=?]", "player[team]"
    end
  end
end
