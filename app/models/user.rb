class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :events, :foreign_key => 'organizer_id'

  has_many :event_users, :foreign_key => 'participant_id'
  has_many :meetings, :class_name => 'Event', through: :event_users
  
  

  has_many :itinearies

  has_many :comments

  has_many :expenses
  
end
