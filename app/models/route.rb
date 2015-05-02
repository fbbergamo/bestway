class Route
  include ActiveModel::Model
  attr_accessor :location_to, :location_from, :distance, :path, :map, :to, :from
  delegate :relationships, to: :path, prefix: true, allow_nil: true
  validates :location_to, :location_from, :map, :distance, :to, :from, :path, :presence => true

  validates :distance, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :validate_all

  def build_to
    self.location_to = build_location({name: to, map: map})
  end

  def build_from
    self.location_from = build_location({name: from, map: map})
  end

  def build_path
    self.path = LocationPath.new(location_to, location_from, distance)
  end

  def validate_all
    if location_to and location_from
      location_to.valid?
      location_from.valid?
      copy_error_to_model(:location_to, location_to)
      copy_error_to_model(:location_from, location_from)
    end
  end

  def save
    build_to
    build_from
    build_path
    if valid?
      Neo4j::Transaction.run do |tx|
        location_to.save
        location_from.save
        path.create_relationship_path
      end
    end
  end


  private

  def build_location(hash)
    obj = Location.where(hash).first
    return obj if obj.present?
    return Location.new(hash)
  end

  def copy_error_to_model(field, obj)
    obj.errors.full_messages.each do |e|
      self.errors.add(field, e)
    end
  end

end
