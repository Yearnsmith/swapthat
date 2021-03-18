require 'rails_helper'

RSpec.describe "trades/new", type: :view do
  before(:each) do
    assign(:trade, Trade.new(
      listing: nil,
      offering: nil
    ))
  end

  it "renders new trade form" do
    render

    assert_select "form[action=?][method=?]", trades_path, "post" do

      assert_select "input[name=?]", "trade[listing_id]"

      assert_select "input[name=?]", "trade[offering_id]"
    end
  end
end
