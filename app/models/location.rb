class Location
  include Neo4j::ActiveNode
  property :map, index: :exact
  property :name, index: :exact
  has_many :both, :path, model_class: Location
  validates :map, :name, :presence => true

  def self.create_route(params)
    to = Location.find_or_create_by(name: params["to"], map: params["map"])
    from = Location.find_or_create_by(name: params["from"], map: params["map"])
    return false if !to.valid? or !from.valid?
    path = LocationPath.new(to, from, params["distance"])
    path.create_relationship_path
    true
  end
end
