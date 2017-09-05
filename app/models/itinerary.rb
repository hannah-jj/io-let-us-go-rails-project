class Itinerary < ApplicationRecord
  belongs_to :event

  validates :meet_day, presence: true
  
end