class ItinerariesController < ApplicationController
	
	def new
		@itinerary = Itinerary.new
	end
end
