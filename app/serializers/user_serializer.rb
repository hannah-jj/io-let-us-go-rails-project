class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  has_many :meetings, class_name: 'Event', foreign_key: :organizer_id
end
