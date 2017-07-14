class EventUserSerializer < ActiveModel::Serializer
  attributes :id, :event_id, :participant_id, :going
end
