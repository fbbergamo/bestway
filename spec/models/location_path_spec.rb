require 'rails_helper'

RSpec.describe LocationPath, type: :model do

  it "should create path beteween two locations" do
    location = Location.create(name: "A", map: "SP")
    location2 = Location.create(name: "B", map: "SP")
    path = LocationPath.new(location, location2, 5)
    path.create_relationship_path
    expect(path.relationships.count).to be_eql(1)
  end

  it "should not create more than two relationships" do
    location = Location.create(name: "A", map: "SP")
    location2 = Location.create(name: "B", map: "SP")
    location2.create_rel("PATH", location)
    path = LocationPath.new(location, location2, 5)
    path.create_relationship_path
    expect(path.relationships.count).to be_eql(1)
  end

end
