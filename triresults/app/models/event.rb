class Event
  include Mongoid::Document

  field :o, as: :order, type: Integer
  field :n, as: :name, type: String
  field :d, as: :distance, type: Float
  field :u, as: :units, type: String

  # relationships
  # use touch to force update timestamp when children changes
  embedded_in :parent, polymorphic: true, touch: true
  # embedded_in :leg_result, class_name: 'LegResult', polymorphic: true

  # validation
  validates :order, :name, presence: true

  def meters
      Rails.logger.debug {
          "converting #{distance} #{units} to meters"
      }

      case units
      when 'meter', 'meters'
          return distance
      when 'kilometer', 'kilometers'
          return distance * 1000
      when 'yard', 'yards'
          return distance * 0.9144
      when 'mile', 'miles'
          return distance * 1609.344
      else
          return nil #unknown unit
      end
  end

  def miles
      Rails.logger.debug {
          "converting #{distance} #{units} to miles"
      }
      case units
      when 'meter', 'meters'
          then distance / 1609.344
      when 'kilometer', 'kilometers'
          then distance / 1.609344
      when 'yard', 'yards'
          then distance * 0.000568182
      when 'mile', 'miles'
          then distance
      else
          nil #unknown unit
      end
  end
end
