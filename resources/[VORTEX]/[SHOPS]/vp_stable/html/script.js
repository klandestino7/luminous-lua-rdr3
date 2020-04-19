$('#creatormenu').fadeOut(0);

window.addEventListener('message', function(event) {
    if (event.data.action == "show") {
        $("#creatormenu").fadeIn(500);

        if (event.data.shopData) {
            for (const [index, table] of Object.entries(event.data.shopData)) {
                var horseCategory = table.name

                if ($(`#page_shop .scroll-container .collapsible #${index}`).length <= 0) {
                    $('#page_shop .scroll-container .collapsible').append(`
                         <li id="${index}">
                            <div class="collapsible-header col s12 panel ">
                                <div class="col s12 panel-title">
                                    <h6 class="grey-text">${horseCategory}</h6>
                                </div>
                            </div>
                            <div class="collapsible-body">
                            </div>
                        </li>
                    `);
                }

                for (const [_, horseData] of Object.entries(table)) {
                    if (_ != 'name') {
                        var HorseName = horseData[0];
                        var priceGold = horseData[1];
                        var priceDolar = horseData[2];

                        // priceGold = '';
                        // priceDolar = '';

                        $(`#page_shop .scroll-container .collapsible #${index} .collapsible-body`).append(`
                            <div id="${_}" onhover="loadHorse(this)" class="col s12 panel item">
                                <div class="col s6 panel-col item">
                                    <h6 class="grey-text title">${HorseName}</h6>
                                </div>
                                <div class="col s3 offset-s3 panel-col">
                                    ${priceGold}
                                    <button onclick="buy(this, true)" class="col s6 waves-effect waves-light btn-small">
                                        <img src="img/gold.png">
                                    </button>
                                    ${priceDolar}
                                    <button onclick="buy(this, false)" class="col s6 waves-effect waves-light btn-small">
                                            <img src="img/money.png">
                                    </button>
                                </div>
                            </div>
                        `);

                        $(`#page_shop .scroll-container .collapsible #${index} .collapsible-body #${_}`).hover(function() {
                            $.post('http://vp_stable/loadHorse', JSON.stringify({ horseModel: $(this).attr('id') }));
                        }, function() {});
                    }
                }

            }

            $('#page_myhorses .scroll-container .collapsible').html('');
            $('#page_myhorses .scroll-container .collapsible').append(`
                <li>
                    <div class="collapsible-header col s12 panel ">
                        <div class="col s12 panel-title">
                            <h6 class="grey-text">VOCÊ NÃO POSSUI CAVALOS</h6>
                        </div>
                    </div>
                </li>
            `);

            $('.collapsible').collapsible();
        }

        if (event.data.action == "hide") {
            $("#creatormenu").fadeOut(500);
        }

        if (event.data.myHorsesData) {
            $.event.data.shopData.forEach(element => {});
        }
    }
});


var currentPage = 'page_myhorses';

$('.menu-selectb').on('click', function() {
    $(`#${currentPage}`).hide();

    currentPage = $(this).data('target');
    $(`#${currentPage}`).show();

    $('.menu-selectb.active').removeClass('active');
    $(this).addClass('active');
});

$(".button-right").on('click', function() {
    var inputElement = $(this).parent().find('input');
    var component = $(inputElement).attr('id');

    var value = Number($(inputElement).attr('value'));
    // value = Number(String.split(value, '/')[0]);
    var nValue = value + 1;

    var min = $(inputElement).attr('min');
    var max = $(inputElement).attr('max');

    if (nValue > max) {
        nValue = min;
    }

    $(inputElement).attr('value', nValue);

    var titleElement = $(this).parent().parent().find('.grey-text');
    var text = titleElement.text();
    var component = text.split(' ')[0];
    titleElement.text(component + ' ' + nValue + '/' + max);

    $.post('http://vp_stable/changeComponent', JSON.stringify({ component: component, value: nValue }));
});

$(".button-left").on('click', function() {
    var inputElement = $(this).parent().find('input');
    var component = $(inputElement).attr('id');

    var value = Number($(inputElement).attr('value'));
    // value = Number(String.split(value, '/')[0]);

    var nValue = value - 1;

    var min = $(inputElement).attr('min');
    var max = $(inputElement).attr('max');

    if (nValue < min) {
        nValue = max;
    }

    $(inputElement).attr('value', nValue);

    var titleElement = $(this).parent().parent().find('.grey-text');
    var text = titleElement.text();
    var component = text.split(' ')[0];
    titleElement.text(component + ' ' + nValue + '/' + max);

    $.post('http://vp_stable/changeComponent', JSON.stringify({ component: component, value: nValue }));
});

$(".input-number").on("change paste keyup", function() {

    var min = Number($(this).attr('min'));
    var max = Number($(this).attr('max'));

    var value = $(this).val();

    if (value == '' || value < min) {
        value = min;
        $(this).val(value);
    }

    if (value > max) {
        value = max;
        $(this).val(value);
    }

    var titleElement = $(this).parent().parent().find('.grey-text');
    var text = titleElement.text();
    var component = text.split(' ')[0];
    titleElement.text(component + ' ' + value + '/' + max);
});

function buy(element, isGold) {
    if (isGold) {
        // console.log(`Buy Gold ${$(element).parent().parent().attr('id')}`);
    } else {
        // console.log(`Buy Dollar ${$(element).parent().parent().attr('id')}`);
    }
}