require 'spec_helper'

describe "players/index" do
  before(:each) do
    assign(:players, [
      stub_model(Player,
        :name => "Name",
        :position => "Position",
        :price => 1,
        :team => "Team"
      ),
      stub_model(Player,
        :name => "Name",
        :position => "Position",
        :price => 1,
        :team => "Team"
      )
    ])
  end

  it "renders a list of players" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Position".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Team".to_s, :count => 2
  end
end
