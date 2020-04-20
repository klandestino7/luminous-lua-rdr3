var primaryItemList = [];
var secondaryItemList = [];
var indexSelected = null;
var shortcutPressed = null;

var hotbarSlotSelected = 5;

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// Rever as classes [documentos, kits], talvez mudar para [armas, munições]
// verify condition

// Criar uma descrição para os items em _core/config/Items.lua



window.addEventListener("message", function(event) {
    if (event.data.action == 'hide') {
        $("#primary-inventory").css('opacity', '0');
        $("#primary #background-image").css('opacity', '0');
        $("#secondary").hide();
    } else {

        // $(".container").fadeIn();

        if (event.data.type == 'clearPrimary') {
            primaryItemList = [];
            $("#primary-inventory").css('opacity', '1');
            $("#primary #background-image").css('opacity', '0.98');
        }

        if (event.data.type == 'clearSecondary') {
            secondaryItemList = [];
            $("#secondary").show();
            $("#secondary #background-image").css('opacity', '0.98');
        }

        if (event.data.type == 'nextHotbarSlot') {

            if (hotbarSlotSelected != undefined) {
                hotbarSlotSelected = hotbarSlotSelected + 1;
                if (hotbarSlotSelected == 6) {
                    hotbarSlotSelected = 1;
                }
            } else {
                hotbarSlotSelected = 1;
            }

            $('.hotbar-slot-selected').removeClass("hotbar-slot-selected");

            let element = $(`.hotbar .slot:nth-child(${hotbarSlotSelected}`);
            element.addClass("hotbar-slot-selected");

            let itemId = $(element).attr('itemId');

            $.post('http://vp_inventory/interactWithHotbarSlot', JSON.stringify({
                itemId: itemId,
            }));
        } else {
            // $('.container:hidden').css('display', 'flex');

            $(".helper").html("");
        }

        if (event.data.ToggleHotbar) {
            if (event.data.val == true) {
                $('.hotbar').css('opacity', '1');

            } else {
                $('.hotbar').css('opacity', '0');
            }
        }

        if (event.data.primarySlots) {
            // var clearedRecent = false;
            $.each(event.data.primarySlots, function(slotId, Slot) {

                // if (clearedRecent == false && (slotId >= 1 && slotId <= 16)) {
                //     clearedRecent = true;
                //     for (var i = 1; i < 16; i++) {
                //         delete primaryItemList[1];
                //     }
                // }

                if (Slot[2] > 0) {
                    primaryItemList[slotId] = Slot;
                } else {
                    delete primaryItemList[slotId];
                }

            });


            if (event.data.primaryWeight != undefined) {
                var weight = event.data.primaryWeight
                var maxWeight = event.data.primaryMaxWeight
                if (maxWeight != undefined) {
                    $('#primary #weight').text(`${weight}/${maxWeight}kg`);
                    var percentage = 100 * (weight / maxWeight);
                    $('#primary #weight-divider').css('background-image', `linear-gradient(to right, red ${percentage}%, transparent ${percentage}%), url(images/divider.png)`);
                } else {
                    var oldText = $('#primary #weight').text();
                    var maxWeight = oldText.split('/')[1];
                    maxWeight = maxWeight.replace('kg', '');
                    $('#primary #weight').text(`${weight}/${maxWeight}kg`);
                    var percentage = 100 * (weight / maxWeight);
                    $('#primary #weight-divider').css('background-image', `linear-gradient(to right, red ${percentage}%, transparent ${percentage}%), url(images/divider.png)`);
                }
            }

            drawPrimary();
            drawHotbar();
        }

        if (event.data.secondarySlots) {
            // var clearedRecent = false;
            $.each(event.data.secondarySlots, function(slotId, Slot) {

                // if (clearedRecent == false && (slotId >= 1 && slotId <= 16)) {
                //     clearedRecent = true;
                //     for (var i = 1; i < 16; i++) {
                //         delete secondaryItemList[1];
                //     }
                // }

                if (Slot[2] > 0) {
                    secondaryItemList[slotId] = Slot;
                } else {
                    delete secondaryItemList[slotId];
                }

            });


            if (event.data.secondaryWeight != undefined) {
                var weight = event.data.secondaryWeight;
                var maxWeight = event.data.secondaryMaxWeight;
                if (maxWeight != undefined) {
                    $('#secondary #weight').text(`${weight}/${maxWeight}kg`);
                    var percentage = 100 * (weight / maxWeight);
                    $('#secondary #weight-divider').css('background-image', `linear-gradient(to right, red ${percentage}%, transparent ${percentage}%), url(images/divider.png)`);
                } else {
                    var oldText = $('#primary #weight').text();
                    maxWeight = oldText.split('/')[1];
                    maxWeight = maxWeight.replace('kg', '');
                    $('#secondary #weight').text(`${weight}/${maxWeight}kg`);
                    var percentage = 100 * (weight / maxWeight);
                    $('#secondary #weight-divider').css('background-image', `linear-gradient(to right, red ${percentage}%, transparent ${percentage}%), url(images/divider.png)`);
                }
            }

            drawSecondary();
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
        drawSecondary();
    } else {
        if (primaryCategoriesIndex != 1) {
            primaryCategoriesIndex--;
        } else {
            primaryCategoriesIndex = 8;
        }
        categoryElement = $(`#${parentInventoryId} .item-categories-container .icon:nth-child(${primaryCategoriesIndex}`);
        $(`#${parentInventoryId} .slot-container`).html('');
        drawPrimary();
    }

    $(`#${parentInventoryId} .enabled`).removeClass('enabled');
    $(categoryElement).addClass('enabled');
    $(`#${parentInventoryId} .control-info-container #selected-category`).text($(categoryElement).attr('data-name'));
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
        drawSecondary();
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
                $.post('http://vp_inventory/useItem', JSON.stringify({
                    slot: $('.focus .selected').attr('id'),
                    itemAmount: amount,
                }));
            }
        }

        if (event.which == 68) {
            if (primaryCategoriesIndex != 1) {
                let amount = 1;
                $.post('http://vp_inventory/dropItem', JSON.stringify({
                    slot: $('.focus .selected').attr('id'),
                    itemAmount: 1,
                }));
            }
        }

    });

    $('.hotbar .slot').not('#unarmed').droppable({
        tolerance: 'pointer',
        hoverClass: 'ab',
        accept: function(e) {
            if (e.parent().parent().attr('id') === 'primary-inventory') {
                return true;
            }
        },
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

            if ($(ui.helper).parent().parent().attr('id') == 'secondary') {
                $.post('http://vp_inventory/moveSlotToPrimary', JSON.stringify({
                    slotFrom: draggableSlot,
                    slotTo: selfSlot,
                    itemAmount: itemAmount,
                }));
            } else {
                $.post('http://vp_inventory/primarySwitchSlot', JSON.stringify({
                    slotFrom: draggableSlot,
                    slotTo: selfSlot,
                    itemAmount: itemAmount,
                }));
            }
        },
    });

    $('#primary').on('mouseover', function() {
        $('.focus').removeClass('focus');
        $('#primary').addClass('focus');
    });

    $('.hotbar').on('mouseover', function() {
        $('.focus').removeClass('focus');
        $('#primary').addClass('focus');
    });

    $('#secondary').on('mouseover', function() {
        $('.focus').removeClass('focus');
        $('#secondary').addClass('focus');
    });
});


function elementAsDraggable(element, a, b, c) {
    element.attr('itemId', a);
    element.attr('title', b);
    element.attr('description', c);
    element.draggable({
        appendTo: 'body',
        scroll: false,
        revert: true,
        revertDuration: 200,
        helper: 'clone',
        zIndex: 99999,
        start: function(event, ui) {

            ui.helper.css('position', 'absolute');
            ui.helper.css('font-size', '8px');

            $(ui.helper).find('.number').remove();
            $(ui.helper).find('.counter').css('font-size', '8px');
            $(ui.helper).find('.counter').css('color', 'white');

            var imgElement = $(ui.helper).find('img')
            imgElement.css('width', '70px');

            $(this).draggable('instance').offset.click = {
                left: Math.floor(70 / 2),
                top: Math.floor(70 / 2)
            };

            select($(this));
        },
        stop: function(event, ui) {
            unSelect($(this));
        },
    });
}

function slotsAsFakeDroppable() {
    $(`#primary-inventory .slot-container .slot`).droppable({
        tolerance: 'pointer',
        activeClass: 'blocked',
    });
}

function drawHotbar() {
    $(".hotbar").css('opacity', '1');

    for (var slotId = 129; slotId <= 132; slotId++) {
        var Slot = primaryItemList[slotId];

        $(`#primary .hotbar #${slotId}`).children().filter(":not(.number)").remove();

        if (Slot != undefined) {
            var itemId = Slot[1];
            // var itemAmount = Slot[2];
            var ammoInClip = Slot[3];
            var ammoInWeapon = Slot[4];

            // var itemStackSize = Slot.itemStackSize;
            var itemName = Slot.itemName;
            var itemDescription = Slot.itemDescription;

            // $(`#primary .hotbar #${slotId}`).html('');

            $(`#primary .hotbar #${slotId}`).removeClass('empty');

            if (itemId != 'lasso') {
                $(`#primary .hotbar #${slotId}`).append(`
                    <img src="images/items/${itemId}.png">
                    <div class="counter">${ammoInClip}/${ammoInWeapon}</div>
                `);
            } else {
                $(`#primary .hotbar #${slotId}`).append(`
                    <img src="images/items/${itemId}.png">
                `);
            }

            var element = $(`#primary .hotbar #${slotId}`);
            elementAsDraggable(element, itemId, itemName, itemDescription);
        } else {
            $(`#primary .hotbar #${slotId}`).addClass("empty");
            $(`#primary .hotbar #${slotId}`).removeAttr('itemId');
        }
    }

    if ($('.hotbar-slot-selected').length > 0) {
        let element = $(`.hotbar-slot-selected`);
        // let selectedSlotId = $(element).attr('id');

        let itemId = $(element).attr('itemId');

        $.post('http://vp_inventory/interactWithHotbarSlot', JSON.stringify({
            itemId: itemId,
        }));
    }
}

function drawPrimary() {
    $(`#primary-inventory .description-title`).text('');
    $(`#primary-inventory .description-description`).text('');

    $(`#primary-inventory .slot-container`).html('');
    var money = 0;

    for (var slotId = (primaryCategoriesIndex * 16) - 15; slotId < (primaryCategoriesIndex * 16) + 1; slotId++) {
        var Slot = primaryItemList[slotId];

        if (Slot !== undefined && Slot !== null) {
            var itemId = Slot[1];
            var itemAmount = Slot[2];

            var ammoInClip = Slot[3];
            var ammoInWeapon = Slot[4];

            if (itemId == 'money' || itemId == 'gold' || itemId == 'blackmoney') {
                itemAmount = itemAmount / 100;
                itemAmount = itemAmount.toFixed(2);
            }

            var itemStackSize = Slot.itemStackSize;
            var itemName = Slot.itemName;
            var itemDescription = Slot.itemDescription;

            if (ammoInClip == undefined && ammoInWeapon == undefined) {
                if (itemStackSize != -1) {
                    if (itemId != "lasso") {
                        $(`#primary-inventory .slot-container`).append(`
                    <div class="slot" id="${slotId}" onclick="select(this)">
                        <img src="images/items/${itemId}.png">
                        <div class="counter">${itemAmount}/${itemStackSize}</div>
                    </div>
                `);
                    } else {
                        $(`#primary-inventory .slot-container`).append(`
                        <div class="slot" id="${slotId}" onclick="select(this)">
                            <img src="images/items/${itemId}.png">
                        </div>
                    `);
                    }
                } else {
                    $(`#primary-inventory .slot-container`).append(`
                            <div class="slot" id="${slotId}" onclick="select(this)">
                                <img src="images/items/${itemId}.png">
                                <div class="counter">${itemAmount}</div>
                            </div>
                        `);
                }
            } else {
                $(`#primary-inventory .slot-container`).append(`
                    <div class="slot" id="${slotId}" onclick="select(this)">
                        <img src="images/items/${itemId}.png">
                        <div class="counter">${ammoInClip}/${ammoInWeapon}</div>
                    </div>
                `);
            }

            var element = $(`#primary-inventory .slot-container #${slotId}`);

            if (primaryCategoriesIndex != 1) {
                elementAsDraggable(element, itemId, itemName, itemDescription);

                $(`#primary-inventory .slot-container #${slotId}`).dblclick(function() {
                    let selfSlot = $(this).attr('id');
                    $.post('http://vp_inventory/use', JSON.stringify({
                        slotId: selfSlot,
                    }));
                })
            }
        } else {
            $("#primary-inventory .slot-container").append(`
                <div class="slot empty" id="${slotId}">
                </div>
            `);
        }

        if (primaryCategoriesIndex == 1) {
            slotsAsFakeDroppable();
        }
    }

    var currency1 = 0;
    var currency2 = 0;

    $.each(primaryItemList, function(slot, Slot) {
        if (Slot != undefined) {
            var itemName = Slot[1];
            var itemAmount = Slot[2];
            if (itemName == 'gold') {
                currency1 = currency1 + itemAmount;
            } else if (itemName == 'money') {
                currency2 = currency2 + itemAmount;
            }
        }
    });

    currency1 = currency1 / 100;
    currency2 = currency2 / 100;

    $('#primary #currency1').text(currency1.toFixed(2));
    $('#primary #currency2').text(currency2.toFixed(2));

    if (primaryCategoriesIndex != 1) {
        $(`#primary-inventory .slot-container`).children().droppable({
            tolerance: 'pointer',
            hoverClass: 'ab',
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

                if ($(ui.draggable).parent().parent().attr('id') == 'secondary-inventory') {
                    $.post('http://vp_inventory/moveSlotToPrimary', JSON.stringify({
                        slotId: draggableSlot,
                        itemAmount: itemAmount,
                    }));
                } else {
                    $.post('http://vp_inventory/primarySwitchSlot', JSON.stringify({
                        slotFrom: draggableSlot,
                        slotTo: selfSlot,
                        itemAmount: itemAmount,
                    }));
                }
            }
        });
    }
}

function drawSecondary() {
    $(`#secondary-inventory .description-title`).text('');
    $(`#secondary-inventory .description-description`).text('');

    $(`#secondary-inventory .slot-container`).html('');
    var money = 0;

    for (var slotId = (secondaryCategoriesIndex * 16) - 15; slotId < (secondaryCategoriesIndex * 16) + 1; slotId++) {
        var Slot = secondaryItemList[slotId];
        if (Slot !== undefined && Slot !== null) {
            var itemId = Slot[1];
            var itemAmount = Slot[2];
            var ammoInClip = Slot[3];
            var ammoInWeapon = Slot[4];

            if (itemId == 'money' || itemId == 'gold' || itemId == 'blackmoney') {
                itemAmount = itemAmount / 100;
                itemAmount = itemAmount.toFixed(2);
            }

            var itemStackSize = Slot.itemStackSize;
            var itemName = Slot.itemName;
            var itemDescription = Slot.itemDescription;

            if (ammoInClip == undefined && ammoInWeapon == undefined) {
                if (itemStackSize != -1) {
                    if (itemId != "lasso") {
                        $(`#secondary-inventory .slot-container`).append(`
                    <div class="slot" id="${slotId}" onclick="select(this)">
                        <img src="images/items/${itemId}.png">
                        <div class="counter">${itemAmount}/${itemStackSize}</div>
                    </div>
                `);
                    } else {
                        $(`#secondary-inventory .slot-container`).append(`
                        <div class="slot" id="${slotId}" onclick="select(this)">
                            <img src="images/items/${itemId}.png">
                        </div>
                    `);
                    }
                } else {
                    $(`#secondary-inventory .slot-container`).append(`
                        <div class="slot" id="${slotId}" onclick="select(this)">
                            <img src="images/items/${itemId}.png">
                            <div class="counter">${itemAmount}</div>
                        </div>
                    `);
                }
            } else {
                $(`#secondary-inventory .slot-container`).append(`
                    <div class="slot" id="${slotId}" onclick="select(this)">
                        <img src="images/items/${itemId}.png">
                        <div class="counter">${ammoInClip}/${ammoInWeapon}</div>
                    </div>
                `);
            }

            var element = $(`#secondary-inventory .slot-container #${slotId}`);

            if (secondaryCategoriesIndex != 1) {
                elementAsDraggable(element, itemId, itemName, itemDescription);
            }
        } else {
            $("#secondary-inventory .slot-container").append(`
                <div class="slot empty" id="${slotId}">
                </div>
            `);
        }

        if (secondaryCategoriesIndex == 1) {
            slotsAsFakeDroppable();
        }
    }

    var currency1 = 0;
    var currency2 = 0;

    $.each(secondaryItemList, function(slot, Slot) {
        if (Slot != undefined) {
            var itemName = Slot[1];
            var itemAmount = Slot[2];
            if (itemName == 'gold') {
                currency1 = currency1 + itemAmount;
            } else if (itemName == 'money') {
                currency2 = currency2 + itemAmount;
            }
        }
    });

    currency1 = currency1 / 100;
    currency2 = currency2 / 100;

    $('#secondary #currency1').text(currency1.toFixed(2));
    $('#secondary #currency2').text(currency2.toFixed(2));

    if (secondaryCategoriesIndex != 1) {
        $(`#secondary-inventory .slot-container`).children().droppable({
            tolerance: 'pointer',
            hoverClass: 'ab',
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


                if ($(ui.draggable).parent().parent().attr('id') == 'primary-inventory') {
                    $.post('http://vp_inventory/moveSlotToSecondary', JSON.stringify({
                        slotId: draggableSlot,
                        itemAmount: itemAmount,
                    }));
                } else {
                    $.post('http://vp_inventory/secondarySwitchSlot', JSON.stringify({
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

    if (($(element).attr('itemId') != undefined)) {
        let elementParentParentId = $(element).parent().parent().attr('id');
        $(`#${elementParentParentId} .description-title`).text('');
        $(`#${elementParentParentId} .description-description`).text('');
        $(`#${elementParentParentId} .selected`).removeClass('selected');
        $(element).addClass('selected');
        $(`#${elementParentParentId} .description-title`).text($(element).attr('title'));
        $(`#${elementParentParentId} .description-description`).text($(element).attr('description'));
        indexSelected = $(element).attr('id');
    }
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
    $('.selected').removeClass('selected');
    $("#secondary").hide();
    $.post("http://vp_inventory/NUIFocusOff", JSON.stringify({}));
}