class RacerInfo
  include Mongoid::Document
  field :fn, as: :first_name, type: String
  field :ln, as: :last_name, type: String
  field :g, as: :gender, type: String
  field :yr, as: :birth_year, type: Integer
  field :res, as: :residence, type: Address

  # _id field mapped to document key racer_id
  # have the id field stored in the document as racer_id
  # ref: For cases when you do not want to have BSON::ObjectId ids, you can override Mongoid's _id field and set them to whatever you like.
  field :racer_id, as: :_id
  field :_id, default:->{ racer_id }

  #relationships
  embedded_in :parent, polymorphic: true

  # validation
  validates :first_name, :last_name, presence: true
  validates :gender, presence: true, inclusion: { in: ['M', 'F'] }
  validates :birth_year, presence: true, numericality: { less_than: Time.now.year}

  # custom setters and getters
  ["city", "state"].each do |action|
      define_method("#{action}") do
          self.residence ? self.residence.send("#{action}") : nil
      end
      define_method("#{action}=") do |name|
          object = self.residence ||= Address.new
          object.send("#{action}=", name)
          self.residence = object
      end
  end


end
