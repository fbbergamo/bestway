class LocationPath
  def initialize(to, from, distance)
    @node = to
    @node2 = from
    @distance = distance
  end

  def relationship_exist?
    relationships.count > 0
  end

  def relationships
    @node.rels(type: "PATH", between: @node2)
  end

  def create_relationship_path
    if relationship_exist?
      relationships.each(&:del)
    end
    @node.create_rel("PATH", @node2, :weight=> @distance)
  end
end
