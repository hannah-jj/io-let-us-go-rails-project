class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :note
  belongs_to :organizer, :class_name => "User"
end
