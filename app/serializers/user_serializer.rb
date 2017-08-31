class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :meetings, :events

  #user organized meeting
  def meetings
  	object.meetings.map do |meeting|
  		{id: meeting.id, attributes: {title: meeting.title, note: meeting.note, image: meeting.image, stats: meeting.event_stats, organizer: {email: meeting.organizer.email}}}
  	end
  end

  #user particiating event
  def events
  	object.events.map do |event|
  		{id: event.id, attributes: {title: event.title, note: event.note, image: event.image, organizer: {email: event.organizer.email}, going: event.userGoing(object)}}
  	end
  end


end
