class ItinerarySerializer < ActiveModel::Serializer
  attributes :id, :note, :location, :meet_time
end
