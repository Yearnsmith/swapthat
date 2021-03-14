require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "creates a User class" do
    user = User.new
    expect(user).to be_kind_of(User)
  end


end
