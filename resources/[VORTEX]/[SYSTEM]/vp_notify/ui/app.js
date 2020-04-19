$(document).ready(function(){
	window.addEventListener("message",function(event){
		var html = "<div id="+event.data.css+"><div class='content'><div class='text'>"+event.data.mensagem+"</div><span class='timer'></span></div></div>"
		$(html).appendTo("#notifications").hide().fadeIn(1000).delay(8000).fadeOut(1000);
		
	})
});


