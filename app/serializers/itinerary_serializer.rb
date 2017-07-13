class ItinerarySerializer < ActiveModel::Serializer
  attributes :id, :note, :location, :meet_time, :event_id

  def event_id
  	object.event.id
  end
end
