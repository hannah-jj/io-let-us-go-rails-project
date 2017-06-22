class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :meetings, :class_name => 'Event', :foreign_key => 'organizer_id'
  has_many :itineraries, through: :meetings

  has_many :event_users, :class_name => 'Event_User', :foreign_key => 'participant_id'

  has_many :comments

  
  
end
