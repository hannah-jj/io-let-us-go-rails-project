class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :meetings, :events

  #user organized meeting
  def meetings
  	object.meetings.map do |meeting|
  		{id: meeting.id, attributes: {title: meeting.title}}
  	end
  end

  #user particiating event
  def events
  	object.events.map do |event|
  		{id: event.id, attributes: {title: event.title}}
  	end
  end


end
