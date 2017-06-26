class Itinerary < ApplicationRecord
  belongs_to :event

  validates :note, presence: true
end