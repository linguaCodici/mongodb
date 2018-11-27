class LegResult
  include Mongoid::Document
  field :secs, type: Float

  embedded_in :entrant
  embeds_one :event, as: :parent

  validates :event, presence: true

  def calc_ave
      #used by sub-classes to update their event-specific average(s)
      #based on the details of the event and the time to complete(secs)
  end

  after_initialize do |doc|
      doc.calc_ave
  end

  def secs= value
      self[:secs] = value
      self.calc_ave
  end
end
