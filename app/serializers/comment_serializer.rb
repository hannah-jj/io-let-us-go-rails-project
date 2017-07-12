class CommentSerializer < ActiveModel::Serializer
  attributes :id, :note, :email
  def email
  	object.user.email
  end
end
