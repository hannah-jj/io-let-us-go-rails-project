class Event < ApplicationRecord
  belongs_to :organizer, :class_name => "User"
  
  has_many :event_users
  has_many :participants, through: :event_users, :class_name => "User"
  
  has_many :comments

  has_many :itineraries
  accepts_nested_attributes_for :itineraries

  validates_presence_of :title, :location, :event_day
end
