$(document).on('turbolinks:load', function(){
  	$('.js-next').on("click", () => nextEvent());
	$('.load-comments').on("click", () => loadComments());
	$('.load-itineraries').on("click", () => loadItineraries());
	$('.add-itinerary').on("click", () => addItinerary());
});

//event section
function nextEvent(){
	var nextId = parseInt($(".js-next").attr("data-id")) + 1;

	$.get("/events/" + nextId +".json", function(data){
		displayEvent(data, nextId);
		//clear itineraries and comments from previous event
		$(".itineraries").html("");
		$(".comments").html("");

	}).fail(function(){
		console.log("click again")
		$(".js-next").attr("data-id", nextId); //advance button's id# by 1
		nextEvent();
	});
}

function displayEvent(data, nextId){
	event = data["data"]["attributes"]
	$(".eventTitle").text(event["title"]);
	$(".js-next").attr("data-id", nextId);
	$(".organizer").html("<strong>Organized by: </strong>" + event["organizer"]["email"]);
	$(".details").html("<strong>Details:</strong>" + event["note"]);
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
	let user_id = parseInt($(".eventTitle").attr("user-id"));
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
			<td><a class="btn btn-info" href="/events/${comment['event-id']}/comments/${id}">view</td></tr>`
			if ($(".no-comment").length){
				$(".comments-table").html(newRow);
			}
			else {
				$(".comments-table").append(newRow);
			}
		}	
	});

}