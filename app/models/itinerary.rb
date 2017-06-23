class Itinerary < ApplicationRecord
  belongs_to :event

  validates_presence_of :note
end