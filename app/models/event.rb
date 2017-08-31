class Event < ApplicationRecord
  
  belongs_to :organizer, :class_name => "User"
  
  has_many :event_users, class_name: "Event_User"
  has_many :participants, through: :event_users
  
  has_many :comments

  has_many :itineraries
  accepts_nested_attributes_for :itineraries

  validates :title, presence: true

    def itineraries_attributes=(itineraries_attributes)
    itineraries_attributes.values.each do |attribute|
      if attribute != ""
        #only check the note & location
        if attribute[:id] #record exists, in edit route
          Itinerary.find(attribute[:id]).update(attribute)
        else #in new route
          if attribute[:note] != "" && attribute[:location] != ""
            #if adding new event, and nothing was updated on note and location
            #dont add any itinerary
            new_itinerary = Itinerary.new(attribute)
            self.itineraries << new_itinerary
            new_itinerary.save
          end
        end
      end
    end
  end

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

  def userGoing (user)
    self.event_users.find_by(participant: user).going
  end


end
