$(document).ready(function(){
  attachListeners();
});

function attachListeners(){
	$('.js-next').on("click", () => nextEvent());

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
	$(".eventTitle").text(data["title"]);
	$(".js-next").attr("data-id", nextId);
	$(".organizer").html("<strong>Organized by: </strong>" + data["organizer"]["email"]);
	$(".details").html("<strong>Details:</strong>" + data["note"]);
}