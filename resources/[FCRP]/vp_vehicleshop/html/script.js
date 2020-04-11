window.addEventListener('message', function(event) {
    var data = event.data;

    if (event.data.type == "display") {
        $("body").fadeIn();
    }

    if (event.data.type == "hide") {
        $("body").fadeOut();
    }
});

$(document).ready(function() {
    $('.upper-bottom-container').slick({
        centerMode: true,
        centerPadding: '60px',
        slidesToShow: 5,
        responsive: [{
                breakpoint: 768,
                settings: {
                    arrows: false,
                    centerMode: true,
                    centerPadding: '40px',
                    slidesToShow: 5
                }
            },
            {
                breakpoint: 480,
                settings: {
                    arrows: false,
                    centerMode: true,
                    centerPadding: '40px',
                    slidesToShow: 1
                }
            }
        ]
    });

    $('.upper-bottom-container').on('afterChange', function(event, slick, currentSlide) {
        console.log(currentSlide);
        $('.button-container').appendTo(currentSlide);
    });
});

function buyItem(shopId, itemId) {
    $.post('http://vp_shop/buyItem', JSON.stringify({ shopId: shopId, itemId: itemId }));
}

$(document).keyup(function(e) {
    if (e.key === "Escape") {
        $(".container").fadeOut(100);
        $.post('http://vp_shop/focusOff');
    }
});