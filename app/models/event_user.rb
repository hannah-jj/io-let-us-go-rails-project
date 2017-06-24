class Event_User < ApplicationRecord
  belongs_to :event
  belongs_to :participant, class_name: 'User'

  #helper_method for eventscontroller that needs statistics of an event
  #returns an array of hash, stats for yes, maybe, no participant counts & the user's status
  def self.stats (event, user)

    user_status = {:status => nil}
    
    stats_array = event.event_stats

    status = Event_User.find_by(event_id: event.id, participant_id: user.id) if user
    user_status[:status] = status.going if status

  	stats_array << user_status

  end



end
