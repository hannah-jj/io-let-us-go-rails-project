$(document).on('turbolinks:load', function(){
	var currentID = parseInt($(".js-next").attr("data-id"));

	//load events on events index page
	showEvents();

	//load an event on show page
	showEvent(currentID)

	//below functions for various functions on event/show page
  	$('.js-next').on("click", () => nextEvent());
	$('.load-comments').on("click", () => loadComments());
	$('.load-itineraries').on("click", () => loadItineraries());
	$('.add-itinerary').on("click", () => addItinerary());
	
});
//show all events on idex page
function showEvents(){
	if ($(".main-title").attr("event-id") == "all") {
		$.get("/events.json", function(data){ 
			var eventsHTML = HandlebarsTemplates['events']({events : data["data"]});
			$(".events-table").html(eventsHTML);
		});	
	}
}

//show an event on show page
function showEvent(id){
	if ($(".event-title").attr("event") == "single") {
		$.get("/events/"+id+".json", function(data){ 
			displayEvent(data, id);
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
	$(".organizer").html("<strong>Organized by: </strong>" + event["organizer"]["email"]);
	$(".details").html("<strong>Details:</strong>" + event["note"]);

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
		statsHTML += `<li class="btn btn-warning btn-xs"><button class="btn-warning participate">${stats[i]["status"]}</button><span class="badge">${stats[i]["value"]}</span></li>`;
		}
		else {// fade it out
		statsHTML += `<li class="btn btn-warning btn-xs faded"><button class="btn-warning participate">${stats[i]["status"]}</button><span class="badge">${stats[i]["value"]}</span></li>`;
		
		}
	}
	$(".stats").html(statsHTML);

	//handles clicks for participation
	$('.participate').click(function(e){
		statUpdate(e, event_id);
	}); 
}

function statUpdate(e, event_id){

	let going = $(e.target).text();
	let statData = {event_users: {event_id: event_id, going: going}};
	
	$.ajax({
		method: 'POST',
		url: `/event_users`,
		data: statData,
		success: function(result){
			//reload event info
			displayEvent(result, event_id);

		}	
	});
}

//itineraries section for Event show page
function loadItineraries(){
	var event_id = parseInt($(".js-next").attr("data-id"));
	$.get("/events/" + event_id +"/itineraries.json", function(data){ 
		var itinerariesHTML = HandlebarsTemplates['itineraries']({itineraries : data["data"]});
		$(".itineraries").html(itinerariesHTML);
	});	
}

function addItinerary(){
	let event_id = parseInt($(".js-next").attr("data-id"));
	window.location.href = `/events/${event_id}/itineraries/new`;
}


// comments section for Event show page
function loadComments(){
	var event_id = parseInt($(".js-next").attr("data-id"));
	$.get("/events/" + event_id +"/comments.json", function(data){ 
		var commentsHTML = HandlebarsTemplates['comments']({comments : data["data"]})
		$(".comments").html(commentsHTML);

		$('.add-comment').on("click", () => addComment());
	});	
}

function addComment(){
	let comment = $("#new-comment")[0].value;
	let event_id = parseInt($(".js-next").attr("data-id"));
	let user_id = parseInt($(".event-title").attr("user-id"));
	let commentData = {comment: { event_id: event_id, note: comment, user_id: user_id }};

	$.ajax({
		method: 'POST',
		url: `/events/${event_id}/comments`,
		data: commentData,
		success: function(result){
			//no comments yet
			comment = result["data"]["attributes"];
			let id = result["data"]["id"];
			newRow = `<tr class="info">
			<td>${comment["note"]}</td>
			<td>${comment["email"]}</td>
			<td align="right"><a class="btn-info" href="/events/${comment['event-id']}/comments/${id}">view</td></tr>`
			if ($(".no-comment").length){
				$(".comments-table").html(newRow);
			}
			else {
				$(".comments-table").append(newRow);
			}
		}	
	});

}