$(".container").fadeOut(500);

window.addEventListener('message', function(event) {
    if (event.data.action == "show") { 
        $(".container").fadeIn(500);

        let Dados = event.data.infos;

        let id = Dados.charid;

        let idLength = id.toString().length;

        let maxLength = 8;

        let digitToAdds = maxLength - idLength;

        let formatedId = "";

        for (i = 0; i < maxLength-2; i ++){
            formatedId = formatedId + "0"
            if (i == 2 || i == 4){
                formatedId = formatedId + "-"
            }
        }

        formatedId = formatedId + id.toString();

        $('.body-document').html('');

        $('.body-document').append(`
            <div class="content-header">
                <span id="charid">${formatedId}</span>
            </div>
            <div class="content-center">
                <span id="name" class="name">${Dados.name}</span>
            </div>
            <div class="content-footer">
                <span id="age">${Dados.age}</span>
                <span id="name" class="signature">${Dados.name}</span>
            </div>
        `);

        setTimeout(function(){  
            $(".container").fadeOut(500);
            $('.body-document').html('');
        }, 30000);

    }

    if (event.data.action == "hide") { 
        $(".container").fadeOut(500);
        $('.body-document').html('');
    }
});