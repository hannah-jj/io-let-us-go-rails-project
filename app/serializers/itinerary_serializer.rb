class ItinerarySerializer < ActiveModel::Serializer
  attributes :id, :note, :location, :time, :event_id

  def event_id
  	object.event.id
  end

  def time
  	object.meet_time.strftime("%A, %d %b %Y %l:%M %p")
  end
end
