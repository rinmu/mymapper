require 'spec_helper'

describe "places/show.html.haml" do
  before(:each) do
    @place = assign(:place, stub_model(Place,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
