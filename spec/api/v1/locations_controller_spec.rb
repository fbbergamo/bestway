require 'rails_helper'

RSpec.describe Api::V1::LocationsController, type: :api do

  it "should create route" do
    post "api/v1/locations", {locations: { to: "A", from: "B", distance: 10, map: "SP"} }.to_json, set_json
    expect(last_response.status).to be_eql(201)
  end

  it "should create route with error" do
    post "api/v1/locations", {locations: { to: "", from: "B", distance: -1, map: "SP"} }.to_json, set_json
    expect(last_response.status).to be_eql(422)
  end

  it "should search with invalid data" do
    get "api/v1/locations/route?to=&from=B&map=SP&autonomy=-1&gas_price=2.1"
    expect(last_response.status).to be_eql(422)
  end

  it "should search nothing" do
    get "api/v1/locations/route?to=A&from=B&map=SP&autonomy=10&gas_price=2.5"
    expect(last_response.status).to be_eql(404)
  end

  it "should search" do
    route = Route.new(to: "A", from: "B", map: "SP", distance: 25)
    route.save
    get "api/v1/locations/route?to=A&from=B&map=SP&autonomy=10&gas_price=2.5"
    expect(last_response.status).to be_eql(200)
  end


end
