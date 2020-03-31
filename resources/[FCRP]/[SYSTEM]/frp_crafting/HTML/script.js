var ownedParts;
var craftingItems;
var parsedItemNames;

window.addEventListener("message", function(event) {
    if (event.data.action == 'open') {
        $('.ui').fadeIn();
        $('#otherInventory .itemselected').html("<div class='imageitem'></div><p class='invtitle'>Selecione um item <br/></p> <p class='invdesc'>Selecione um item da esquerda que deseje craftar e verá abaixo os itens necessários para craftar. </p> ");
        

        ownedParts = event.data.ownedParts;
        craftingItems = event.data.craftingItems;
        parsedItemNames = event.data.parsedItemNames;

        $('#playerInventory .containinv').html('');
        $.each(craftingItems, function(i, data) {

            $('#playerInventory .containinv').append(`
                <div class="slot" id="craftable_${i}" onclick="select(this)">
                    <div class="item" style="background-image: url('./img/items/${i}.png')">
                        <div class="item-name">
                            ${parsedItemNames[i]}
                        </div>
                    </div>
                    <div class="item-name-bg"></div>
                </div>
            `);

            if (data.canCraft == false) {
                $(`#craftable_${i}`).addClass('disabled');
            }
        });
    }

    if (event.data.action == 'close') {
        $('.ui').hide();
        $('#otherInventory .itemselected').html("<div class='imageitem'></div><p class='invtitle'>Selecione um item <br/></p> <p class='invdesc'>Selecione um item da esquerda que deseje craftar e verá abaixo os itens necessários para craftar. </p> ");
        $('#otherInventory .containinv').html('');
        
    }

    if (event.data.action == 'update') {
        var newOwnedItems = event.data.updatedOwnedItems;

        $.each(newOwnedItems, function(id, amount) {
            ownedParts[id] = amount;
            if ($(`#part_${id}`).length > 0) {
                var element = $(`#part_${id}`);
                var amountTextElement = $(`#part_${id}`).find('.item-count-bg');
                var previousText = amountTextElement.text();
                var previusNeededAmount = previousText.substring(previousText.indexOf("/") + 1);
                amountTextElement.text(`${amount}/${previusNeededAmount}`);
            }
        });
        var newUpdatedCraftingStatus = event.data.updatedCraftingStatus;
        $.each(newUpdatedCraftingStatus, function(id, canCraft) {
            if (canCraft) {
                $(`#craftable_${id}`).removeClass('disabled');
            } else {
                $(`#craftable_${id}`).addClass('disabled');
            }
        });
    }
});

function select(element) {
    $('.selected').removeClass('selected');
    $(element).addClass('selected');
    showCraftingParts($(element).attr('id'));
}

function showCraftingParts(id) {

    $('#otherInventory .itemselected').html("<div class='imageitem'></div><p class='invtitle'>Selecione um item <br/></p> <p class='invdesc'>Selecione um item da esquerda que deseje craftar e verá abaixo os itens necessários para craftar. </p> ");
    $('#otherInventory .containinv').html('');

    id = id.replace('craftable_', '');

    var numberSlots = 6;
    $.each(craftingItems[id].craftingParts, function(i, amount) {
            $('#otherInventory .itemselected').html(`
                <div class="imageitem">
                    <img class="imgitem" src="img/items/${id}.png">                    
                </div>  
                <p class="invtitle">${parsedItemNames[id]}</p>
                <p class="invdesc">${craftingItems[id].craftingDesc}</p>
            `);

            $('#otherInventory .containinv').append(`
                <div class="slot" id="part_${i}">
                <div class="item" style="background-image: url('img/items/${i}.png')">
                <div class="item-count">
                    <div class="item-count-bg">
                        ${ownedParts[i] != null ? ownedParts[i] == 0 ? `<red>0</red>`: ownedParts[i] : `<red>0</red>`}/${amount}
                    </div>
                </div>
                <div class="item-name">
                    ${parsedItemNames[i]}
                </div>
                </div>
                    <div class="item-name-bg">
                </div>
             </div>
        `);
        numberSlots--;
    });

    while (numberSlots > 0) {
        numberSlots--;
        $('#otherInventory .itemselected').append(` `);
        
        $('#otherInventory .containinv').append(`
            <div class="slot disabler">
                <div">
                <div class="item-count">
                    <div class="item-count-bg">
                    </div>
                </div>
                <div class="item-name">
                </div>
                </div>
                    <div class="item-name-bg">
                </div>
             </div>
        `);
    }

    $('#otherInventory .containinv').append(`
        <div class="craftbutton" onclick="craft()">
            <button type="button">Criar</button>
        </div>
    `);
}

function craft() {
    if ($('.selected').length > 0 && (!$('.selected').hasClass('disabled'))) {
        var id = $('.selected').attr('id');
        id = id.replace('craftable_', '');
        $.post("http://frp_crafting/craft", JSON.stringify({
            id: id
        }));
    }
}

$(document).ready(function() {
    $(document).keyup(function(e) {
        if (e.which == 27) {
            $('.ui').hide();
            $('#otherInventory .containinv').html('');
            $.post("http://frp_crafting/close", JSON.stringify({}));
        }
    });
});