class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def sortItineraries (itinArray)
  	itinArray.sort_by {|i| [i.meet_day, i.meet_time.strftime('%H:%M')]}
  end

  # method to compile given array of itineraries into timeline format
  # [{date: 1/1/2017, data: [itinerary, itinerary]}, xx, xx]
  def compileTimeLine (itinArray)
  	sortedArray = sortItineraries (itinArray)
  	result = []
  	dateHash = {date: "", data: []}
  	for i in 0...sortedArray.length do
  		if i == 0 || result[-1][:date] != sortedArray[i].meet_day
  			dateHash = {:date => sortedArray[i].meet_day, :data => [sortedArray[i]]}
  			result.push(dateHash)
  		else
  			result[-1][:data].push(sortedArray[i])
  		end
  	end
  	return result
  end
end
