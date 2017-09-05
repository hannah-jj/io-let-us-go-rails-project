class ItinerarySerializer < ActiveModel::Serializer
  attributes :id, :note, :location, :time, :event_id

  def event_id
  	object.event.id
  end

  def time
  	object.meet_day.strftime("%A, %d %b %Y") + object.meet_time.strftime(" at %l:%M %p")
  end
end
