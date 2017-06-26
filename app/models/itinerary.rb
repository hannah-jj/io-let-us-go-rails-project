class Itinerary < ApplicationRecord
  belongs_to :event

  validates :meet_time, presence: true
  
end