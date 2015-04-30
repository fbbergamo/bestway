class RouteSearch
  def initialize(map, from, to, autonomy, gas_price)
    @from = from
    @to = to
    @map = map
    @autonomy = autonomy.to_i
    @gas_price = gas_price.to_f
  end

  def price_per_km
    @price_per_km
  end

  def total_distance
    @total_distance
  end

  def order
    @order
  end

  def price_per_km
    @gas_price/@autonomy if @autonomy.present? and @autonomy > 0
  end

  def route_price
    price_per_km * total_distance if price_per_km.present? and total_distance.present?
  end

  def search
    result = Neo4j::Session.query("MATCH (from:Location { name: {from}, map: {map} }),
                          (to:Location { name: {to}, map: {map}}) ,
                          path =   (from)-[:PATH*]-(to)
                          RETURN path AS shortestPath,
                          reduce(weight = 0, r in relationships(path) | weight+r.weight) AS total_distance,
                          extract(p in NODES(path)| p.name) as order
                          ORDER BY total_distance ASC
                          LIMIT 1", to: @to, from: @from, map: @map ).first
    if result.present?
      @total_distance = result.total_distance
      @order = result.order
      return true
    else
      return false
    end
  end
end
