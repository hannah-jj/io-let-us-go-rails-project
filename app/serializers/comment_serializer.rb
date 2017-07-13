class CommentSerializer < ActiveModel::Serializer
  attributes :id, :note, :email, :event_id
  def email
  	object.user.email
  end

  def event_id
  	object.event.id
  end
end
