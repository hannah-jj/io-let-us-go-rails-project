class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates_presence_of :note, :user_id, :event_id
end
