class Location
  include Neo4j::ActiveNode
  property :map, index: :exact
  property :name, index: :exact
  validates :map, :name, :presence => true
end
