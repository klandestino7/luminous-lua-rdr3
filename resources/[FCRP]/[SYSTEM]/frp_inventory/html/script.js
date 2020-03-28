var disabled = false;
var disabledFunction = null;
var InventoryPlayer = document.querySelector("#playerInventory");
var OtherInventory = document.querySelector("#otherInventory");
var Controls = document.querySelector('.controls-div');
$("#otherInventory").hide();
// if have one inventory
// if have two inventorys$(".ui").fadeIn();
window.addEventListener("message", function(event) {

    if (event.data.action == 'hide') {
        $(".ui").hide();
        // $(".item").remove();
        // $("#otherInventory").hide();
    } else {
        $(".ui:hidden").fadeIn();

        if (event.data.action == 'clearPrimary') {
            $("#playerInventory").html("");
        }

        if (event.data.action == 'clearSecondary') {
            $("#otherInventory").html("");
        }

        if (event.data.primaryItems) {
            // $("#otherInventory").hide();
            primarySetup(event.data.primaryItems);
        }

        if (event.data.secondaryItems) {
            $("#otherInventory").show();
            secondarySetup(event.data.secondaryItems);
        }
    }
});

function closeInventory() {
    $("#otherInventory").hide();
    $.post("http://frp_inventory/NUIFocusOff", JSON.stringify({}));
}

$(document).ready(function() {
    $("#count").focus(function() {
        $(this).val("")
    }).blur(function() {
        if ($(this).val() == "") {
            $(this).val("1")
        }
    });
    $(document).keyup(function(e) {
        if (e.which == 27) {
            closeInventory();
        }
    });
    $('#count').attr("disabled", true);

    $('#playerInventory').droppable({
        tolerance: 'pointer',
        accept: function(d) {
            if (d.children().attr('id').search('item-')) {
                return true;
            }
        },
        drop: function(event, ui) {
            var itemSelected = ui.helper[0].children[0].id;
            $(ui.helper).remove();
            var valueCount = document.getElementById('count').value;
            $.post('http://frp_inventory/sendItemToPrimary', JSON.stringify({
                id: textReplace2(itemSelected),
                amount: valueCount,
            }));
        },
    });

    $('#otherInventory').droppable({
        tolerance: 'pointer',
        accept: function(d) {
            if (d.children().attr('id').search('chestitem-')) {
                return true;
            }
        },
        drop: function(event, ui) {
            var itemSelected = ui.helper[0].children[0].id;
            $(ui.helper).remove();
            var valueCount = document.getElementById('count').value;
            $.post('http://frp_inventory/sendItemToSecondary', JSON.stringify({
                id: textReplace(itemSelected),
                amount: valueCount,
            }));
        },
    });

    $('#playerInventory').click('on', function(t) {
        var selectedItem = t.target.id
        if (!selectedItem.indexOf("item-")) {
            select(t.target);
        }
    });

    $('#otherInventory').click('on', function(t) {
        var selectedItem = t.target.id
        if (!selectedItem.indexOf("itemchest-")) {
            select(t.target);
        }
    });

    $(function() {
        $("#count").keydown(function() {
            if (!$(this).val() || (parseInt($(this).val()) <= count && parseInt($(this).val()) >= 0))
                $(this).data("old", $(this).val());
        });
        $("#count").keyup(function() {
            if (!$(this).val() || (parseInt($(this).val()) <= count && parseInt($(this).val()) >= 0))
            ;
            else
                $(this).val($(this).data("old"));
        });
    });

    $("#use").droppable({
        hoverClass: 'buttonDropHover',
        drop: function(ev, ui) {
            var itemSelected = ui.helper[0].children[0].id;
            var valueCount = document.getElementById('count').value;
            $.post('http://frp_inventory/useItem', JSON.stringify({
                id: textReplace(itemSelected),
                amount: valueCount,
            }));
        }
    });

    document.getElementById('drop').addEventListener('click', function(event) {
        var itemSelected = document.getElementsByClassName('selected')[0].id;
        var valueCount = document.getElementById('count').value;
        var tooltiptext = document.getElementsByClassName("tooltiptext")[0];
        closeInventory();
        $.post('http://frp_inventory/dropItem', JSON.stringify({
            id: textReplace(itemSelected),
            amount: valueCount,
        }));
    });

    document.getElementById('use').addEventListener('click', function(event) {
        /*  var itemSelected = document.getElementsByClassName('selected')[0].id;
         var valueCount = document.getElementById('count').value;
         var tooltiptext = document.getElementsByClassName("tooltiptext")[0];
         if (valueCount >= 2 && itemType != "ammo") {
             tooltiptext.innerText = "Você não pode usar mais do que um item";
             return;
         } else {
             $.post('http://frp_inventory/useItem', JSON.stringify({
                 id: textReplace(itemSelected),
                 count: valueCount,
             }));
         } */
    });


    $("#count").on("keypress keyup blur", function(event) {
        $(this).val($(this).val().replace(/[^\d].+/, ""));
        if ((event.which < 48 || event.which > 57)) {
            event.preventDefault();
        }
    });
});

function select(element) {
    var count = document.getElementsByClassName('item-count')[0].innerText;
    $('#count').attr("disabled", false);
    $('.selected').css('background-color', 'rgba(17, 5, 17, 0.0)');
    $('.selected').removeClass('selected');
    $(element).addClass('selected');
    $(element).css('background-color', 'rgba(191, 25, 25, 0.3)');
}

function unSelect(element) {
    if ($(element).hasClass('selected')) {
        $(element).removeClass('selected');
    }
}

function primarySetup(items) {
    $.each(items, function(index, item) {
        if ($(`#item-${item.id}`).length > 0) {
            var countElement = $(`#item-${item.id}`).parent().find(`.item-count`);
            if (item.amount > 0) {
                countElement.text(item.amount);
            } else {
                $(`#item-${item.id}`).parent().remove();
            }
        } else {
            if (item.amount > 0) {
                $('#playerInventory').remove(`#item-${item.id}`);

                $("#playerInventory").append('<div class="slot"><div id="item-' + item.id + '" class="item" style = "background-image: url(\'img/items/' + item.id + '.png\')">' +
                    '<div class="item-count">' + item.amount + '</div> <div class="item-name">' + item.name + '</div> <div class="item-type" style="display: none">' + item.id + '</div></div ><div class="item-name-bg"></div></div>');

                $('#item-' + item.id).parent().draggable({
                    appendTo: '.ui',
                    scroll: false,
                    revert: true,
                    helper: 'clone',
                    zIndex: 99999,
                    start: function(event, ui) {
                        ui.helper.css('position', 'absolute');
                        select(ui.helper);
                    },
                    stop: function(event, ui) {
                        unSelect(ui.helper);
                    },
                });
            }
        }
    });
}

function secondarySetup(items) {

    $.each(items, function(index, item) {

        if ($(`#itemchest-${item.id}`).length > 0) {
            var countElement = $(`#itemchest-${item.id}`).parent().find(`.item-count`);
            if (item.amount > 0) {
                countElement.text(item.amount);
            } else {
                $(`#itemchest-${item.id}`).parent().remove();
            }
        } else {
            if (item.amount > 0) {
                $('#otherInventory').remove(`#itemchest-${item.id}`);

                $("#otherInventory").append('<div class="slot"><div id="itemchest-' + item.id + '" class="item" style = "background-image: url(\'img/items/' + item.id + '.png\')">' +
                    '<div class="item-count">' + item.amount + '</div> <div class="item-name">' + item.name + '</div> <div class="item-type" style="display: none">' + item.id + '</div></div ><div class="item-name-bg"></div></div>');

                $('#itemchest-' + item.id).parent().draggable({
                    appendTo: '.ui',
                    scroll: false,
                    revert: true,
                    helper: 'clone',
                    zIndex: 99999,
                    start: function(event, ui) {
                        ui.helper.css('position', 'absolute');
                        select(ui.helper);
                    },
                    stop: function(event, ui) {
                        unSelect(ui.helper);
                    },
                });
            }
        }
    });
}

function textReplace(text) {
    text = text.toLowerCase();
    text = text.replace('item-', '');
    return text;
}

function textReplace2(text) {
    text = text.toLowerCase();
    text = text.replace('itemchest-', '');
    return text;
}