require 'rails_helper'

RSpec.describe Location, type: :model do
  it { should validate_presence_of(:map) }
  it { should validate_presence_of(:name) }

  it "should create node location" do
    location = Location.create(name: "A", map: "SP")
    expect(location.name).to be_eql("A")
    expect(location.errors.present?).to be_falsey
  end

end
