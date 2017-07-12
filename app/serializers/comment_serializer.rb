class CommentSerializer < ActiveModel::Serializer
  attributes :id, :note, :user_id
end
