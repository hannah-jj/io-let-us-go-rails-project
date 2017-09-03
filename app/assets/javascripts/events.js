function eventsListeners(){
	var currentID = parseInt($(".js-next").attr("data-id"));

	//load events or event
	showEvents(currentID);

	//below functions for various functions on event/show page
  	$('.js-next').on("click", () => nextEvent());
	$('.add-itinerary').on("click", () => addItinerary());
	$('.add-comment').on("click", () => addComment());

	//event form page
	$('.event-images').click(function(e){
		changeSelect(e);
	}); 
}

//show all events on idex page or one event on show page
function showEvents(id){
	if ($(".main-title").attr("event-id") == "all") {
		$.get("/events.json", function(data){ 
			var eventsHTML = HandlebarsTemplates['events']({events : data["data"]});
			$(".events-table").html(eventsHTML);
		});	
	}
	else if ($(".main-page").attr("event") == "main") {

	} 
	else {
		$.get("/events/"+id+".json", function(data){ 
			displayEvent(data, id);
			loadItineraries();
			loadComments();
		});	
	}
}

//when nextEvent button is clicked
function nextEvent(){
	var maxID = parseInt($(".event-title").attr("max-id"));
	let currentID = parseInt($(".js-next").attr("data-id"));

	if (currentID >= maxID) {//at last event 
		currentID = 0; //reset to first event
		$(".alert-success").html("reached last event, reverting to first event")
	}
	
	let nextId = currentID + 1;

	$.get("/events/" + nextId +".json", function(data){
		displayEvent(data, nextId);
		//clear itineraries and comments from previous event
		$(".itineraries").html("");
		$(".comments").html("");

	}).fail(function(){
		$(".js-next").attr("data-id", nextId); //advance button's id# by 1
		nextEvent();
	});
	
}

//display event's basic info
function displayEvent(data, event_id){
	event = data["data"]["attributes"]
	let user_id = parseInt($(".event-title").attr("user-id"));

	//update event info
	$(".event-title").text(event["title"]);
	$(".js-next").attr("data-id", event_id);
	$(".edit-event").attr("href", event_id +"/edit");
	$(".organizer").html("<strong>Organized by: </strong>" + event["organizer"]["email"]);
	$(".details").html("<strong>Details: </strong>" + event["note"]);

	//update stats 
	let stats = event["stats"];
	let statsHTML = "";
	
	//get current user's participation if any
	let users_stat = event["participants"];
	let current_user_stat = null;

	if (Object.keys(users_stat).length != 0) {
	current_user_stat =  users_stat[user_id] ? users_stat[user_id][1] : null
	}

	//display stats button
	for(var i = 0; i < 3; i++){
		if (stats[i]["status"]==current_user_stat) {
		//if matching value for stat, make the button normal
		statsHTML += `<li class="btn btn-lg"><button class="btn participate">${stats[i]["status"]}</button><span class="badge">${stats[i]["value"]}</span></li>`;
		}
		else {// fade it out
		statsHTML += `<li class="btn btn-lg fade"><button class="btn participate">${stats[i]["status"]}</button><span class="badge">${stats[i]["value"]}</span></li>`;
		}
	}
	$(".stats").html(statsHTML);

	//handles clicks for participation
	$('.participate').click(function(e){
		statUpdate(e, event_id);
	}); 
}
//update the statistics buttons for event
function statUpdate(e, event_id){

	let going = $(e.target).text();
	let statData = {event_users: {event_id: event_id, going: going}};
	$.post("/event_users", statData, function(result){
		displayEvent(result, event_id);
	});
}

//itineraries section for Event show page
//load Itineraries
function loadItineraries(){
	var event_id = parseInt($(".js-next").attr("data-id"));
	$.get("/events/" + event_id +"/itineraries.json", function(data){ 
		var itinerariesHTML = HandlebarsTemplates['itineraries']({itineraries : data["data"]});
		$(".itineraries").html(itinerariesHTML);
		
	});	
}
//redirect to the add itinerary page
function addItinerary(){
	let event_id = parseInt($(".js-next").attr("data-id"));
	window.location.href = `/events/${event_id}/itineraries/new`;
}
// comments section for Event show page

//declare Comment object
function Comment(id, event_id, email, comment){
	this.id = id;
	this.event = event_id;
	this.comment = comment;
	this.email = email;
}
// prototype function for Comment Object
Comment.prototype.newComment = function() {
	return (`<tr class="info">
			<td>${this.comment}</td>
			<td>${this.email}</td>
			<td align="right"><a class="btn-info" href="/events/${this.event_id}/comments/${this.id}">view</td></tr>
		`);
}
//add comment on event show page
function addComment(){
	let comment_input = $("#new-comment")[0]
	let comment = comment_input.value;
	let event_id = parseInt($(".js-next").attr("data-id"));
	let user_id = parseInt($(".event-title").attr("user-id"));
	let commentData = {comment: { event_id: event_id, note: comment, user_id: user_id }};

	$.post(`/events/${event_id}/comments`, commentData, function(result) {
		comment_input.value = "";

		commentData = result["data"]["attributes"];
		let id = result["data"]["id"];
		var comment = new Comment(id, event_id, commentData["email"], commentData["note"]);
		
		if ($(".no-comment").length){
			$(".comments-table").html(comment.newComment());
		}
		else {
			$(".comments-table").append(comment.newComment());
		}
	});
}

//load comments on event show page
function loadComments(){
	var event_id = parseInt($(".js-next").attr("data-id"));
	$.get("/events/" + event_id +"/comments.json", function(data){ 
		var commentsHTML = HandlebarsTemplates['comments']({comments : data["data"]})
		$(".comments").html(commentsHTML);
	});	
}

//updated select option in event form accordingly to the image selected
function changeSelect(e){
	var t = e.target;
	// debugger
	var image_id = parseInt(t.getAttribute("data-id"));
	$(".image-select").val(image_id);
	updateClass(t, "highlight");
	// t.className += "highlight";
	// debugger
}

function updateClass(t, className) {
	$(t).removeClass();
	var siblings = $(t).siblings();
	for (i = 0; i < siblings.length; i++) {
    	$(siblings[i]).removeClass();
 	}
 	t.className += className;
}