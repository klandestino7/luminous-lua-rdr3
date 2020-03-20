window.addEventListener('message', function(event) {
    var data = event.data;

    var $element;

    // $('.container').children().addClass("slide-up");

    if (data.icon != undefined && data.header != undefined && data.text != undefined) {
        $element = $(`
        <div class="notification slide-left">
            <img src="${data.icon}">

            <div class="text-container">

                <div class="header">
                    ${data.header}
                </div>
                <div class="text">
                    ${data.text}
                </div>
            </div>
        </div>
    `);
    }

    if (data.icon != undefined && data.header == undefined && data.text != undefined) {
        $element = $(`
        <div class="notification slide-left">
            <img src="${data.icon}">
            <div class="text">
                ${data.text}
            </div>
        </div>
        `);
    }

    if (data.icon == undefined && data.header != undefined && data.text != undefined) {
        $element = $(`
        <div class="notification slide-left">
            <div class="text-container">
                <div class="header">
                    ${data.header}
                </div>
                <div class="text">
                    ${data.text}
                </div>
            </div>
        </div>
        `);
    }

    $element.appendTo($('.container'));
    $element.fadeIn(1000).delay(5000).fadeOut(1000);
    setTimeout(function() {
        $element.remove();
    }, 4500);
});