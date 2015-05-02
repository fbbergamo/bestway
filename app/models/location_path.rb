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
    keep_one_path
    @node.create_rel("PATH", @node2, :weight=> @distance)
  end

  private
  def keep_one_path
    relationships.each(&:del) if relationship_exist?
  end
end
