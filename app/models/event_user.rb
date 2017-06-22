class Event_User < ApplicationRecord
  belongs_to :event
  belongs_to :participant, :class_name => 'User'

  def self.stats (event, user)
  	stats = [{:status => "yes", :value => 0} ,{:status => "maybe", :value => 0},{:status => "no", :value => 0},{:status => nil}]
  	
  	(0..2).each do |i|	
  		stats[i][:value] = where(:going => stats[i][:status], :event_id => event.id).size
  	end

  	
    status = Event_User.find_by(event_id: event.id, participant_id: user.id) if user
    stats[3][:status] = status.going if status
  	stats
  end

end
