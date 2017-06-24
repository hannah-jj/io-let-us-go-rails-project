class Event < ApplicationRecord
  belongs_to :organizer, :class_name => "User"
  
  has_many :event_users, class_name: "Event_User"
  has_many :participants, through: :event_users
  
  has_many :comments

  has_many :itineraries
  accepts_nested_attributes_for :itineraries

  validates_presence_of :title

  # returns an array of hash containing event id and their stats example below
  # [{event_id: 1, stats: [{:status => "yes", :value => 0} ,{:status => "maybe", :value => 0},{:status => "no", :value => 0}]},
  # .... ]
  def self.popularity
  	all.collect { |event|
  		{event_id: event.id, stats: event.event_stats}
  	}
  end

  def self.top_popular
    all_result = Event.popularity
  	all_result.sort_by { |hsh| hsh[:stats][0][:value]}.reverse
  end

  def event_stats
    stats = [{:status => "yes", :value => 0} ,{:status => "maybe", :value => 0},{:status => "no", :value => 0}]
    self.event_users.each do |i|  
      stats[0][:value] += 1 if i.going == "yes" 
      stats[1][:value] += 1 if i.going == "maybe"
      stats[2][:value] += 1 if i.going == "no"
    end
    stats
  end


end
