class EventUserSerializer < ActiveModel::Serializer
  attributes :id, :event_id, :participant_id, :going
  belongs_to :event  
  belongs_to :participant, class_name: 'User'
end
