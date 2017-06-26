class Itinerary < ApplicationRecord
  belongs_to :event

  validates :note, :meet_time, presence: true
end