$(document).ready(function(){
	window.addEventListener("message",function(event){
		var html = "<div id='"+event.data.css+"'><div class='content'><div class='head'><span class='title'>"+event.data.title+"</span><b>"+event.data.mensagem+"</b></div><div class='text'>"+event.data.position+"</div></div></div>"
		$(html).appendTo("#notifications").hide().fadeIn(1000).delay(8000).fadeOut(1000);
	})
});


