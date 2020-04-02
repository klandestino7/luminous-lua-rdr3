var primaryItemList = [];
var secondaryItemList = [];
var indexSelected = null;
var shortcutPressed = null;

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// Rever as classes [documentos, kits], talvez mudar para [armas, munições]
// verify condition

// Criar uma descrição para os items em _core/config/Items.lua

window.addEventListener("message", function(event) {
    if (event.data.action == 'hide') {
        $(".container").hide();
    } else {
        $('.container:hidden').css('display', 'flex');
        $(".helper").html("");
        // $(".container").fadeIn();

        if (event.data.type == 'clearPrimary') {
            primaryItemList = [];
        }

        if (event.data.primarySlots) {
            $.each(event.data.primarySlots, function(slot, ItemSlot) {
                primaryItemList[slot] = ItemSlot;
            });
            drawPrimary();
        }

        if (!$('#secondary').is(":hidden")) {
            $(".helper").html("Basta arrastar o item ao proximo inventário para despejar.");
        } else {
            $(".helper").html("Siga as legendas apresentadas no canto inferior direito.");
        }
    }
});

var primaryCategoriesIndex = 1;
var secondaryCategoriesIndex = 1;

function previousCategory() {

    let isPrimary = false;
    if ($('.focus').attr('id') === 'primary') {
        isPrimary = true;
    }

    let parentInventoryId = 'primary-inventory';
    let categoryElement;

    if (!(isPrimary)) {
        parentInventoryId = 'secondary-inventory';

        if (secondaryCategoriesIndex != 1) {
            secondaryCategoriesIndex--;
        } else {
            secondaryCategoriesIndex = 8;
        }
        categoryElement = $(`#${parentInventoryId} .item-categories-container .icon:nth-child(${secondaryCategoriesIndex}`);
        $(`#${parentInventoryId} .slot-container`).html('');
        // secondarySetup(secondaryItemList, false);
    } else {
        if (primaryCategoriesIndex != 1) {
            primaryCategoriesIndex--;
        } else {
            primaryCategoriesIndex = 8;
        }
        categoryElement = $(`#${parentInventoryId} .item-categories-container .icon:nth-child(${primaryCategoriesIndex}`);
        $(`#${parentInventoryId} .slot-container`).html('');
        // primarySetup(primaryItemList, false);
        drawPrimary();
    }

    $(`#${parentInventoryId} .enabled`).removeClass('enabled');
    $(categoryElement).addClass('enabled');
    $(`#${parentInventoryId} .control-info-container #selected-category`).text($(categoryElement).attr('data-name'));
    // select($(`#${parentInventoryId} .slot-container .slot:nth-child(1)`));
}

function nextCategory() {

    let isPrimary = false;
    if ($('.focus').attr('id') === 'primary') {
        isPrimary = true;
    }

    let parentInventoryId = 'primary-inventory';
    let categoryElement;

    if (!(isPrimary)) {
        parentInventoryId = 'secondary-inventory';
        if (secondaryCategoriesIndex != 8) {
            secondaryCategoriesIndex++;
        } else {
            secondaryCategoriesIndex = 1;
        }
        categoryElement = $(`#${parentInventoryId} .item-categories-container .icon:nth-child(${secondaryCategoriesIndex}`);
        $(`#${parentInventoryId} .slot-container`).html('');
        secondarySetup(secondaryItemList, false);
    } else {
        if (primaryCategoriesIndex != 8) {
            primaryCategoriesIndex++;
        } else {
            primaryCategoriesIndex = 1;
        }
        categoryElement = $(`#${parentInventoryId} .item-categories-container .icon:nth-child(${primaryCategoriesIndex}`);
        $(`#${parentInventoryId} .slot-container`).html('');
        drawPrimary();
    }

    $(`#${parentInventoryId} .enabled`).removeClass('enabled');
    $(categoryElement).addClass('enabled');
    $(`#${parentInventoryId} .control-info-container #selected-category`).text($(categoryElement).attr('data-name'));
    // select($(`#${parentInventoryId} .slot-container .slot:nth-child(1)`));
}

// function dev() {
//     nextCategory();
//     $('.container:hidden').css('display', 'flex');

//     $("#primary-inventory .slot-container").append(`
//         <div class="slot" id="consumable_apple" onclick="select(this)">
//             <img src="images/items/consumable_apple.png">
//             <div class="counter">1</div>
//         </div>
//     `);

//     fitsSelectedCategory('consumable_apple', true)

//     $("#primary-inventory .slot-container").append(`
//         <div class="slot" id="consumable_carrot" onclick="select(this)">
//             <img src="images/items/consumable_carrot.png">
//             <div class="counter">1</div>
//         </div>
//     `);
//     fitsSelectedCategory('consumable_carrot', true)
//     select(document.getElementById('consumable_apple'))
// }

$(document).ready(function() {

    $(document).keyup(function(event) {
        if (event.which == shortcutPressed) {
            shortcutPressed = null;
        }

    });

    $(document).keydown(function(event) {
        if (event.which == 16) {
            shortcutPressed = 16;
        }

        if (event.which == 17) {
            shortcutPressed = 17;
        }

        if (event.which == 81) { // Q
            previousCategory();
        }

        if (event.which == 69) { // E
            nextCategory();
        }

        if (event.which == 27) { // ESC
            closeInventory();
        }

        if (event.which == 37) { // LEFT ARROW
            if ($('#primary').hasClass('focus')) {
                if (primaryCategoriesIndex != 1) {
                    var selected = $('#primary-inventory .slot-container .slot')
                    $.each(selected, function(index, item) {
                        if (!$(this).hasClass('empty')) {
                            if ($(this).hasClass('selected')) {
                                setTimeout(() => { select($(this).prev()) }, 0)
                            }
                        }
                    });
                }
            } else if ($('#secondary').hasClass('focus')) {
                if (secondaryCategoriesIndex != 1) {
                    var selected = $('#secondary-inventory .slot-container .slot')
                    $.each(selected, function(index, item) {
                        if (!$(this).hasClass('empty')) {
                            if ($(this).hasClass('selected')) {
                                setTimeout(() => { select($(this).prev()) }, 0)
                            }
                        }
                    });
                }
            }
        }

        if (event.which == 39) { // RIGHT ARROW
            if ($('#primary').hasClass('focus')) {
                if (primaryCategoriesIndex != 1) {
                    var selected = $('#primary-inventory .slot-container .slot')
                    $.each(selected, function(index, item) {
                        if (!$(this).hasClass('empty')) {
                            if ($(this).hasClass('selected')) {
                                if (!$(this).next().hasClass('empty')) {
                                    setTimeout(() => { select($(this).next()) }, 0)
                                }
                            }
                        }
                    });
                }
            } else if ($('#secondary').hasClass('focus')) {
                var selected = $('#secondary-inventory .slot-container .slot')
                $.each(selected, function(index, item) {
                    if (!$(this).hasClass('empty')) {
                        if ($(this).hasClass('selected')) {
                            if (!$(this).next().hasClass('empty')) {
                                setTimeout(() => { select($(this).next()) }, 0)
                            }
                        }
                    }
                });
            }
        }

        if (event.which == 65) {
            if (primaryCategoriesIndex != 1) {
                let amount = 1;
                $.post('http://frp_inventory/useItem', JSON.stringify({
                    slot: $('.focus .selected').attr('id'),
                    itemAmount: amount,
                }));
            }
        }

        if (event.which == 68) {
            if (primaryCategoriesIndex != 1) {
                let amount = 1;
                $.post('http://frp_inventory/dropItem', JSON.stringify({
                    slot: $('.focus .selected').attr('id'),
                    itemAmount: 1,
                }));
            }
        }

    });

    $('.hotbat').droppable({
        tolerance: 'pointer',
        accept: function(e) {
            if (e.parent().parent().attr('id') === 'primary-inventory') {
                return true;
            }
        },
        drop: function(event, ui) {
            let slot = $(ui.draggable).attr('id');
            $(ui.helper).remove();
            // let valueCount = $('.count').value;
            let valueCount = 1;
            $.post('http://frp_inventory/sendItemSlotToHotbar', JSON.stringify({
                slot: slot,
            }));
        },
    });

    $('body').droppable({
        tolerance: 'pointer',
        accept: function(e) {
            if (e.parent().parent().attr('id') === 'primary-inventory') {
                return true;
            }
        },
        drop: function(event, ui) {
            let slot = $(ui.draggable).attr('id');
            console.log('droppin');
            $(ui.helper).remove();
            let valueCount = 1;
            // $.post('http://frp_inventory/dropItem', JSON.stringify({
            //     slot: slot,
            // }));
        },
    });

    $('#primary').on('mouseover', function() {
        $('.focus').removeClass('focus');
        $('#primary').addClass('focus');
    })

    $('#secondary').on('mouseover', function() {
        $('.focus').removeClass('focus');
        $('#secondary').addClass('focus');
    })
});

function drawPrimary() {

    $(`#primary-inventory .slot-container`).html('');
    for (var slot = (primaryCategoriesIndex * 16) - 15; slot < (primaryCategoriesIndex * 16) + 1; slot++) {
        if (primaryItemList[slot] !== undefined && primaryItemList[slot] !== null && primaryItemList[slot][1] > 0) {
            var ItemSlot = primaryItemList[slot];
            $(`#primary-inventory .slot-container`).append(`
                <div class="slot" id="${slot}" onclick="select(this)">
                    <img src="images/items/${ItemSlot[0]}.png">
                    <div class="counter">${ItemSlot[1]}/${ItemSlot[2]}</div>
                </div>
            `)

            if (primaryCategoriesIndex != 1) {
                var element = $(`#primary-inventory .slot-container #${slot}`);

                element.attr('itemId', ItemSlot[0]);
                element.attr('title', ItemSlot[3]);
                element.attr('description', ItemSlot[4]);
                element.draggable({
                    appendTo: 'body',
                    scroll: false,
                    revert: true,
                    revertDuration: 200,
                    helper: 'clone',
                    zIndex: 99999,
                    start: function(event, ui) {
                        $(this).draggable('instance').offset.click = {
                            left: Math.floor(ui.helper.width() / 2),
                            top: Math.floor(ui.helper.height() / 2)
                        };
                        ui.helper.css('position', 'absolute');
                        select($(this));
                    },
                    stop: function(event, ui) {
                        unSelect($(this));
                    },
                });
            }
        } else {

            if (primaryItemList[slot] !== undefined) {
                delete primaryItemList[slot];
            }

            $("#primary-inventory .slot-container").append(`
                <div class="slot empty" id="${slot}">
                </div>
            `);
        }
    }

    if (primaryCategoriesIndex != 1) {
        $(`#primary-inventory .slot-container`).children().droppable({
            tolerance: 'pointer',
            drop: function(event, ui) {
                $(ui.helper).remove();
                // let valueCount = $('.count').value;
                let selfSlot = $(this).attr('id');
                let draggableSlot = $(ui.draggable).attr('id');

                if (shortcutPressed == null) {
                    itemAmount = -2; // quantidade = TODOS
                }

                if (shortcutPressed == 16) { // SHIFT
                    itemAmount = -1
                }

                if (shortcutPressed == 17) { // CTRL
                    itemAmount = 1
                }

                if ($(ui.draggable).parent().parent().attr('id') === 'primary-inventory') {
                    $.post('http://frp_inventory/primarySwitchItemSlot', JSON.stringify({
                        slotFrom: draggableSlot,
                        slotTo: selfSlot,
                        itemAmount: itemAmount,
                    }));
                } else {
                    let amount = 1;
                    $.post('http://frp_inventory/sendItemSlotToPrimary', JSON.stringify({
                        slotFrom: draggableSlot,
                        slotTo: selfSlot,
                        itemAmount: itemAmount,
                    }));
                }
            }
        });
    }
}


function select(element) {
    // let count = $('.count')[0].innerText;
    // $('.count').attr("disabled", false);
    let elementParentParentId = $(element).parent().parent().attr('id');
    $(`#${elementParentParentId} .description-title`).text('');
    $(`#${elementParentParentId} .description-description`).text('');
    $(`#${elementParentParentId} .selected`).removeClass('selected');
    $(element).addClass('selected');
    $(`#${elementParentParentId} .description-title`).text($(element).attr('title'));
    $(`#${elementParentParentId} .description-description`).text($(element).attr('description'));
    indexSelected = $(element).attr('id');
}

function unSelect(element) {
    if ($(element).hasClass('selected')) {
        $(element).removeClass('selected');
        let elementParentParentId = $(element).parent().parent().attr('id');
        $(`${elementParentParentId} .description-title`).text('');
        $(`${elementParentParentId} .description-description`).text('');
    }
}

function closeInventory() {
    primaryItemList = [];
    secondaryItemList = [];
    $("#secondary").hide();
    $.post("http://frp_inventory/NUIFocusOff", JSON.stringify({}));
}