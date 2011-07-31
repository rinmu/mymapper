require 'spec_helper'

describe "places/index.html.haml" do
  before(:each) do
    assign(:places, [
      stub_model(Place,
        :name => "Name"
      ),
      stub_model(Place,
        :name => "Name"
      )
    ])
  end

  it "renders a list of places" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
