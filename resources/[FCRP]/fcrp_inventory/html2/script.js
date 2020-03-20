var primaryItemList = [];
var secondaryItemList = [];
var indexSelected = null;

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

        if (event.data.action == 'clearPrimary') {
            primaryItemList = [];
            $("#primary-inventory .slot-container").html("");
        }

        if (event.data.action == 'clearSecondary') {
            secondaryItemList = [];
            $("#secondary-inventory .slot-container").html("");
        }

        if (event.data.primaryItems) {
            primarySetup(event.data.primaryItems, true);
            //$(".helper").html("Siga a legenda ao lado do seu visor.");
        }

        if (event.data.secondaryItems) {
            $("#secondary").show();
            secondarySetup(event.data.secondaryItems, true);
            //
        }
        // helper message
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
        secondarySetup(secondaryItemList, false);
    } else {
        if (primaryCategoriesIndex != 1) {
            primaryCategoriesIndex--;
        } else {
            primaryCategoriesIndex = 8;
        }
        categoryElement = $(`#${parentInventoryId} .item-categories-container .icon:nth-child(${primaryCategoriesIndex}`);
        $(`#${parentInventoryId} .slot-container`).html('');
        primarySetup(primaryItemList, false);
    }

    $(`#${parentInventoryId} .enabled`).removeClass('enabled');
    $(categoryElement).addClass('enabled');
    $(`#${parentInventoryId} .control-info-container #selected-category`).text($(categoryElement).attr('data-name'));
    select($(`#${parentInventoryId} .slot-container .slot:nth-child(1)`));
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
        primarySetup(primaryItemList, false);
    }

    $(`#${parentInventoryId} .enabled`).removeClass('enabled');
    $(categoryElement).addClass('enabled');
    $(`#${parentInventoryId} .control-info-container #selected-category`).text($(categoryElement).attr('data-name'));
    select($(`#${parentInventoryId} .slot-container .slot:nth-child(1)`));
}

function dev() {
    nextCategory();
    $('.container:hidden').css('display', 'flex');

    $("#primary-inventory .slot-container").append(`
        <div class="slot" id="consumable_apple" onclick="select(this)">
            <img src="images/items/consumable_apple.png">
            <div class="counter">1</div>
        </div>
    `);

    fitsSelectedCategory('consumable_apple', true)

    $("#primary-inventory .slot-container").append(`
        <div class="slot" id="consumable_carrot" onclick="select(this)">
            <img src="images/items/consumable_carrot.png">
            <div class="counter">1</div>
        </div>
    `);
    fitsSelectedCategory('consumable_carrot', true)
    select(document.getElementById('consumable_apple'))
}

$(document).ready(function() {
    $(document).keydown(function(event) {
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
                var selected = $('#primary-inventory .slot-container .slot')
                $.each(selected, function(index, item) {
                    if (!$(this).hasClass('empty')) {
                        if ($(this).hasClass('selected')) {
                            setTimeout(() => { select($(this).prev()) }, 0)
                        }
                    }
                });
            } else if ($('#secondary').hasClass('focus')) {
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

        if (event.which == 39) { // RIGHT ARROW
            if ($('#primary').hasClass('focus')) {
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
            let item_id = $('.focus .selected').attr('id');
            if (item_id != undefined) {
                $.post('http://fcrp_inventory/useItem', JSON.stringify({
                    id: item_id,
                }));
            }
        }

        if (event.which == 68) {
            let item_id = $('.focus .selected').attr('id');
            if (item_id != undefined) {
                $.post('http://fcrp_inventory/dropItem', JSON.stringify({
                    id: item_id,
                    amount: 1,
                }));
            }
        }

    });

    $('#primary').droppable({
        tolerance: 'pointer',
        accept: function(e) {
            if (e.parent().parent().attr('id') === 'secondary-inventory') {
                return true;
            }
        },
        drop: function(event, ui) {
            let itemSelected = $(ui.draggable).attr('id');
            $(ui.helper).remove();
            // let valueCount = $('.count').value;
            let valueCount = 1;
            $.post('http://fcrp_inventory/sendItemToPrimary', JSON.stringify({
                id: itemSelected,
                amount: valueCount,
            }));
        },
    });

    $('#secondary').droppable({
        tolerance: 'pointer',
        accept: function(e) {
            if (e.parent().parent().attr('id') === 'primary-inventory') {
                return true;
            }
        },
        drop: function(event, ui) {
            let itemSelected = $(ui.draggable).attr('id');
            $(ui.helper).remove();
            // let valueCount = $('.count').value;
            let valueCount = 1;
            $.post('http://fcrp_inventory/sendItemToSecondary', JSON.stringify({
                id: itemSelected,
                amount: valueCount,
            }));
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

function primarySetup(items, saveOnArray) {
    $.each(items, function(index, item) {
        if (saveOnArray == true) {
            primaryItemList.push(item);
        }
        if (item.id == "generic_money" || item.id == "generic_gold" ) {    
            if (item.id == "generic_money") {                
                $(".headmoney").html(`<img src="images/money.png">${(item.amount / 100).toFixed(2)}`);               
            } else {
                $(".headgold").html(`<img src="images/gold.png">${(item.amount / 100).toFixed(2)}`);
            }
        
        } else {
            if (fitsSelectedCategory(item.id, true)) {

                if ($(`#primary-inventory .slot-container #${item.id}`).length > 0) {
                    let counter = $(`#primary-inventory .slot-container #${item.id} .counter`);
                    if (item.amount > 0) {
                        counter.text(item.amount);
                    } else {

                        if ($(`#primary-inventory .description-title`).text() == `${item.id}`) {
                            $(`#primary-inventory .description-title`).text('');
                            $(`#primary-inventory .description-subtitle`).text('');
                        }

                        $(`#primary-inventory .slot-container #${item.id}`).remove();
                    }
                } else {
                    if (item.amount > 0) {
                        if ($('#primary-inventory .slot-container .empty').length > 0) {
                            $('#primary-inventory .slot-container .empty').first().replaceWith(`
                                <div class="slot" id="${item.id}" onclick="select(this)">
                                    <img src="images/items/${item.id}.png">
                                    <div class="counter">${item.amount}</div>
                                </div>
                            `)

                            $(`#primary-inventory .slot-container #${item.id}`).attr('title', item.name);
                            $(`#primary-inventory .slot-container #${item.id}`).attr('subTitle', item.subtitle);
                            if (index == 0) {
                                select(document.getElementById(item.id));
                            }
                        } else {
                            $("#primary-inventory .slot-container").append(`
                                <div class="slot" id="${item.id}" onclick="select(this)">
                                    <img src="images/items/${item.id}.png">
                                    <div class="counter">${item.amount}</div>
                                </div>
                            `);                          

                            $(`#primary-inventory .slot-container #${item.id}`).attr('title', item.name);
                            $(`#primary-inventory .slot-container #${item.id}`).attr('subTitle', item.subtitle);
                            if (index == 0) {
                                select(document.getElementById(item.id));
                            }
                        }

                        $(`#primary-inventory .slot-container #${item.id}`).draggable({
                            appendTo: 'body',
                            scroll: false,
                            revert: true,
                            helper: 'clone',
                            zIndex: 99999,
                            start: function(event, ui) {
                                $(this).draggable('instance').offset.click = {
                                    left: Math.floor(ui.helper.width() / 2),
                                    top: Math.floor(ui.helper.height() / 2)
                                };
                                ui.helper.css('position', 'absolute');
                                select($(`#primary-inventory .slot-container #${item.id}`));
                            },
                            stop: function(event, ui) {
                                unSelect($(`#primary-inventory .slot-container #${item.id}`));
                            },
                        });
                    }
                }
            }
        }
    });

    let childrenAmount = $('#primary-inventory .slot-container > *').length;

    while (childrenAmount < 16 || childrenAmount % 4 !== 0) {

        $("#primary-inventory .slot-container").append(`
            <div class="slot empty">
            </div>
        `);

        childrenAmount = $('#primary-inventory .slot-container .slot').length;
    }
}

function secondarySetup(items, saveOnArray) {
    $.each(items, function(index, item) {


        if (saveOnArray == true) {
            secondaryItemList.push(item);
        }

        if (fitsSelectedCategory(item.id, false)) {

            if ($(`#secondary-inventory .slot-container #${item.id}`).length > 0) {
                let counter = $(`#secondary-inventory .slot-container #${item.id} .counter`);
                if (item.amount > 0) {
                    counter.text(item.amount);
                } else {

                    if ($(`#secondary-inventory .description-title`).text() == `${item.id}`) {
                        $(`#secondary-inventory .description-title`).text('');
                        $(`#secondary-inventory .description-subtitle`).text('');
                    }

                    $(`#secondary-inventory .slot-container #${item.id}`).remove();
                }
            } else {
                if (item.amount > 0) {
                    if ($('#secondary-inventory .slot-container .empty').length > 0) {
                        $('#secondary-inventory .slot-container .empty').first().replaceWith(`
                        <div class="slot" id="${item.id}" onclick="select(this)">
                            <img src="images/items/${item.id}.png">
                            <div class="counter">${item.amount}</div>
                        </div>
                        `)
                        $(`#secondary-inventory .slot-container #${item.id}`).attr('title', item.name);
                        $(`#secondary-inventory .slot-container #${item.id}`).attr('subTitle', item.subtitle);
                        if (index == 0) {
                            select(document.getElementById(item.id));
                        }
                    } else {
                        $("#secondary-inventory .slot-container").append(`
                            <div class="slot" id="${item.id}" onclick="select(this)">
                                <img src="images/items/${item.id}.png">
                                <div class="counter">${item.amount}</div>
                            </div>
                        `);
                        $(`#secondary-inventory .slot-container #${item.id}`).attr('title', item.name);
                        $(`#secondary-inventory .slot-container #${item.id}`).attr('subTitle', item.subtitle);
                        if (index == 0) {
                            select(document.getElementById(item.id));
                        }
                    }

                    $(`#secondary-inventory .slot-container #${item.id}`).draggable({
                        appendTo: 'body',
                        scroll: false,
                        revert: true,
                        helper: 'clone',
                        zIndex: 99999,
                        start: function(event, ui) {
                            $(this).draggable('instance').offset.click = {
                                left: Math.floor(ui.helper.width() / 2),
                                top: Math.floor(ui.helper.height() / 2)
                            };
                            ui.helper.css('position', 'absolute');
                            select($(`#secondary-inventory .slot-container #${item.id}`));
                        },
                        stop: function(event, ui) {
                            unSelect($(`#secondary-inventory .slot-container #${item.id}`));
                        },
                    });
                }
            }
        }
    });

    let childrenAmount = $('#secondary-inventory .slot-container > *').length;

    while (childrenAmount < 16 || childrenAmount % 4 !== 0) {

        $("#secondary-inventory .slot-container").append(`
            <div class="slot empty">
            </div>
        `);

        childrenAmount = $('#secondary-inventory .slot-container .slot').length;
    }
}

function select(element) {
    // let count = $('.count')[0].innerText;
    // $('.count').attr("disabled", false);
    let elementParentParentId = $(element).parent().parent().attr('id');
    $(`#${elementParentParentId} .description-title`).text('');
    $(`#${elementParentParentId} .description-subtitle`).text('');
    $(`#${elementParentParentId} .selected`).removeClass('selected');
    if ($(element).attr('id') != undefined) {
        $(element).addClass('selected');
        $(`#${elementParentParentId} .description-title`).text($(element).attr('title'));
        $(`#${elementParentParentId} .description-subtitle`).text($(element).attr('subTitle'));
        indexSelected = $(element).attr('id');
    }
    // $(`#${$(element).parent().parent().attr('id')} .description-title`).text('' + name);
    // $(`#${$(element).parent().parent().attr('id')} .description-subtitle`).text('' + subtitle);
}

function unSelect(element) {
    if ($(element).hasClass('selected')) {
        $(element).removeClass('selected');
        let elementParentParentId = $(element).parent().parent().attr('id');
        $(`${elementParentParentId} .description-title`).text('');
        $(`${elementParentParentId} .description-subtitle`).text('');
    }
}

function closeInventory() {
    primaryItemList = [];
    secondaryItemList = [];
    $("#secondary").hide();
    $.post("http://fcrp_inventory/NUIFocusOff", JSON.stringify({}));
}

function fitsSelectedCategory(id, isPrimary) {
    let selectedCategoryIndex = primaryCategoriesIndex;

    if (!(isPrimary)) {
        selectedCategoryIndex = secondaryCategoriesIndex;
    }

    switch (selectedCategoryIndex) {
        case 1:
            return true;
            break;
        case 2:
            return (id.includes('consumable_'))
            break;
        case 3:
            return (id.includes('tonic_'))
            break;
        case 4:
            return (id.includes('ingredient_'))
            break;
        case 5:
            return (id.includes('material_'))
            break;
        case 6:
            return (id.includes('kit_'))
            break;
        case 7:
            return (id.includes('valuable_'))
            break;
        case 8:
            return (id.includes('document_') || id.includes('folder_'))
            break;
        default:
            return false
    }
}