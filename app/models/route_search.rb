class RouteSearch
  include ActiveModel::Model
  attr_accessor :map, :from, :to, :autonomy, :gas_price, :total_distance, :order

  validates :map, :from, :to, :autonomy, :gas_price, :presence => true

  validates :autonomy, numericality: { only_integer: true, greater_than: 0 }
  validates :gas_price, numericality: { greater_than: 0 }

  def price_per_km
    gas_price.to_f/autonomy.to_i if autonomy.present? and gas_price.present? and autonomy > 0
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
                          LIMIT 1", to: to, from: from, map: map ).first
    if result.present?
      self.autonomy = autonomy.to_i if autonomy.present?
      self.gas_price = gas_price.to_f if gas_price.present?
      self.total_distance = result.total_distance
      self.order = result.order
      return true
    else
      return false
    end
  end
end
