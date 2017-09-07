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
      {
        id: c.id,
        email: c.user.email, 
        note: c.note,
        created_at: c.created_at.strftime('%m/%d/%Y, %I:%M%p')
      }
    end
  end

  def itineraries
      object.compileTimeLine(object.itineraries)
  end


end
