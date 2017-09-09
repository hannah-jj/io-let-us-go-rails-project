class ItinerarySerializer < ActiveModel::Serializer
  attributes :id, :note, :location, :time, :event_id, :meet_day, :meet_time, :end_time

  def event_id
  	object.event.id
  end

  def time
  	object.meet_day.strftime("%A, %d %b %Y") + object.meet_time.strftime(" at %l:%M %p")
  end

  def meet_day
  	object.meet_day.strftime("%D")
  end

  def meet_time
  	object.meet_time.strftime("%l:%M %p")
  end

  def end_time
    object.end_time.strftime("%l:%M %p")
  end
end
