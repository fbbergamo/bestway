require 'rails_helper'

RSpec.describe RouteSearch, type: :model do
  it { should validate_presence_of(:map) }
  it { should validate_presence_of(:autonomy) }
  it { should validate_presence_of(:to) }
  it { should validate_presence_of(:from) }
  it { should validate_presence_of(:gas_price) }
  it { should validate_numericality_of(:autonomy).only_integer }
  it { should validate_numericality_of(:gas_price) }
  it { should_not allow_value(-1, 0).for(:autonomy) }
  it { should_not allow_value(-1, 0).for(:gas_price ) }

  it "should search best route and total price, shoud garante a bi-direct graph" do
    route = Route.new(to: "A", from: "B", map: "SP", distance: 25)
    route.save
    route_search = RouteSearch.new(from: "A", to: "B", map: "SP", autonomy: 10, gas_price: 2.5)
    expect(route_search.search).to be_truthy
    expect(route_search.route_price).to be_eql(6.25)
    expect(route_search.order).to be_eql(["A", "B"])
  end

  it "should not find any search" do
    route_search = RouteSearch.new(from: "A", to: "B", map: "SP", autonomy: 10, gas_price: 2.5)
    expect(route_search.search).to be_falsey
  end

end
