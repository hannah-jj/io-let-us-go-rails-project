$(document).ready(function(){
  	$('.js-next').on("click", () => nextEvent());
	$('.load-comments').on("click", () => loadComments());
	// $('.add-comment').on("click", () => addComment());

});

function nextEvent(){
	var nextId = parseInt($(".js-next").attr("data-id")) + 1;

	$.get("/events/" + nextId +".json", function(data){
		displayEvent(data, nextId);
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
	let url = `/events/${event_id}/comments`
	$.ajax({
		method: 'POST',
		url: url,
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
				loadComments()
			}
			else {
				$(".comments-table").append(newRow);
			}
		}	
	});

}