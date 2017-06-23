class Event < ApplicationRecord
  belongs_to :organizer, :class_name => "User"
  
  has_many :event_users
  has_many :participants, through: :event_users, :class_name => "User"
  
  has_many :comments

  has_many :itineraries
  accepts_nested_attributes_for :itineraries

  validates_presence_of :title, :location, :event_day

  # returns an array of hash containing event id and their stats example below
  # [{event_id: 1, stats: [{:status => "yes", :value => 0} ,{:status => "maybe", :value => 0},{:status => "no", :value => 0}]},
  # .... ]
  def self.popularity
  	all.collect { |event|
  		{event_id: event.id, stats: Event_User.event_stats(event)}
  	}
  end

  def self.top_popular
    all_result = Event.popularity
  	all_result.sort_by { |hsh| hsh[:stats][0][:value]}.reverse
  end
end
