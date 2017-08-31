class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :note, :image, :organizer, :participants, :comments, :itineraries, :stats

  def participants
    user_hash = {}
  	object.event_users.each do |eu|
  		user_hash[eu.participant.id] = [eu.participant.email, eu.going]
  	end
    user_hash
  end

  def stats
  	object.event_stats
  end

  def organizer
    {email: object.organizer.email}
  end

  def comments
    object.comments.map do |c|
      {email: c.user.email, 
        note: c.note
      }
    end
  end

  def itineraries
        object.itineraries.map do |i|
      {note: i.note, 
        location: i.location,
        meet_time: i.meet_time
      }
    end
  end


end
