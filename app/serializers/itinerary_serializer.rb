class ItinerarySerializer < ActiveModel::Serializer
  attributes :id, :note, :location, :day, :time, :event_id

  def event_id
  	object.event.id
  end

  def day
  	object.meet_day.strftime("%A, %d %b %Y")
  end

  def time
  	object.meet_time.strftime("%l:%M %p")
  end
end
