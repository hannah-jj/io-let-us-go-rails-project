$(document).ready(function(){
  	attachListeners();
});

function attachListeners(){
	$('.js-next').on("click", () => nextEvent());
	$('.load-comments').on("click", () => loadComments());
	$('.load-comments').on("click", () => loadComments());


}

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
	var currentID = parseInt($(".js-next").attr("data-id"));
	$.get("/events/" + currentID +"/comments.json", function(data){
		var commentsHTML = HandlebarsTemplates['comments']({comments : data["data"]})
		$(".comments-link").html(commentsHTML);
	});
	
}