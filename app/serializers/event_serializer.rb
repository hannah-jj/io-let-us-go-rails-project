class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :note, :stats
  belongs_to :organizer, :class_name => "User"
  has_many :participants

  def participants
  	object.event_users.map do |eu|
  		{email: eu.participant.email, going: eu.going }
  	end
  end

  def stats
  	object.event_stats
  end

end
