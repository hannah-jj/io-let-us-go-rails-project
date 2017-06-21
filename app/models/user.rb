class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :events

  has_many :participants
  has_many :events, through: :participants

  has_many :itinearies
  has_many :comments

  has_many :expenses
  
end
