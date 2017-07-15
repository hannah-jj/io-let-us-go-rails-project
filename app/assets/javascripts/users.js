function usersListeners(){

	var user_id = parseInt($(".main-user").attr("user-id"));

	//get user info in json format
	//display meetings and events
	if (user_id) {//check to see if on user page
		$.get("/users/" + user_id +".json", function(data){ 
			meetingData = data["data"]["attributes"]["meetings"];
			eventData = data["data"]["attributes"]["events"];
			loadMeetings(meetingData);
	  		loadEvents(eventData);
		});	
	}
}

function loadMeetings(data){
	var meetingsHTML = HandlebarsTemplates['events']({events : data});
	$(".organized-meetings").html(meetingsHTML);
}

function loadEvents(data){
	var eventsHTML = HandlebarsTemplates['events']({events : data});
	$(".participating-events").html(eventsHTML);

}