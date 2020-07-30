function createOrg(){
    var x = document.getElementById("OrgNewName").value;
    $.post('http://vp_peagle/createOrg', JSON.stringify({ text: x}));
    $("#main").fadeOut();
    document.getElementById("OrgNewName").value = "";
    $("#main").css('display', 'none');
}

window.addEventListener('message', function(e) {
    switch(event.data.type) {
        case 'governo':
            // if (ownerdNotepad === undefined){
            //     document.getElementById("p1").value = "";
            //     $("#main").fadeIn();
            // }else {
            //     $("textarea").removeAttr('disabled','disabled');
            //     $("button").fadeIn();
            //     document.getElementById("p1").value = ownerdNotepad;
            //     $("#main").fadeIn();
            // }
            break;
        case 'ilegal':
            // notepadreader = true;
            // $("textarea").attr('disabled','disabled');
            // $("button").hide();
            // $("#main").fadeIn();
            // document.getElementById("p1").value = event.data.TextRead;
            break;
    }
});




