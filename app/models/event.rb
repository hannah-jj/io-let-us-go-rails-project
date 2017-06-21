class Event < ApplicationRecord
  belongs_to :organizer, :class_name => "User"
  
  has_many :participants
  has_many :users, through: :participants

  has_many :comments
  has_many :expenses
end
