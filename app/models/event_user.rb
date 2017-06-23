class Event_User < ApplicationRecord
  belongs_to :event
  belongs_to :participant, :class_name => 'User'

  #helper_method for eventscontroller that needs statistics of an event
  #returns an array of hash, stats for yes, maybe, no participant counts & the user's status
  def self.stats (event, user)

    user_status = {:status => nil}
    
    stats_array = Event_User.event_stats(event)

    status = Event_User.find_by(event_id: event.id, participant_id: user.id) if user
    user_status[:status] = status.going if status

  	stats_array << user_status

  end

  #find out stats of an event, return an array of hashes
  #also used in Events model to find out popularities of each event
  def self.event_stats(event)
    stats = [{:status => "yes", :value => 0} ,{:status => "maybe", :value => 0},{:status => "no", :value => 0}]
    (0..2).each do |i|  
      stats[i][:value] = where(:going => stats[i][:status], :event_id => event.id).size
    end
    stats
  end

end
