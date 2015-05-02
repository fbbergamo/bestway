require 'rails_helper'

RSpec.describe Route, type: :model do
  it { should validate_presence_of(:map) }
  it { should validate_presence_of(:location_to) }
  it { should validate_presence_of(:location_from) }
  it { should validate_presence_of(:distance) }
  it { should validate_presence_of(:to) }
  it { should validate_presence_of(:from) }
  it { should validate_presence_of(:path) }
  it { should validate_numericality_of(:distance).only_integer }
  it { should_not allow_value(-1).for(:distance) }

  it "should create a route object" do
    route = Route.new(to: "A", from: "B", map: "SP", distance: 2)
    route.save
    expect(route.path_relationships.count).to be_eql(1)
  end

  it "should not create a object if from object is not valid" do
    route = Route.new(to: "", from: "B", map: "SP", distance: -1)
    route.save
    expect(route.errors.full_messages.count).to be_eql(3)
    expect(route.errors[:to].present?).to be_truthy
    expect(route.errors[:location_to].present?).to be_truthy
    expect(route.errors[:distance].present?).to be_truthy
  end

end
