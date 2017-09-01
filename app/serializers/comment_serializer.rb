class CommentSerializer < ActiveModel::Serializer
  attributes :id, :note, :email, :event_id, :created_at
  def email
  	object.user.email
  end

  def event_id
  	object.event.id
  end

  def created_at
  	object.created_at.strftime("%A, %d %b %Y %l:%M %p")
  end
end
