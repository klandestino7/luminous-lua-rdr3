var ownedParts;
var craftingItems;
var parsedItemNames;

window.addEventListener("message", function(event) {
    if (event.data.action == 'open') {
        $('.container').fadeIn();
        // $('.craftable-info-container .itemselected').html("<div class='imageitem'></div><p class='invtitle'>Selecione um item <br/></p> <p class='invdesc'>Selecione um item da esquerda que deseje craftar e verá abaixo os itens necessários para craftar. </p> ");


        ownedParts = event.data.ownedParts;
        craftingItems = event.data.craftingItems;
        parsedItemNames = event.data.parsedItemNames;

        $('.container .mid-container').html('');
        $.each(craftingItems, function(itemId, data) {

            // $('.craftable-container .slot-container').append(`
            //     <div class="slot" id="craftable_${i}" onclick="select(this)">
            //         <div class="item" style="background-image: url('nui://fcrp_inventory/html/img/items/${i}.png')">
            //             <div class="item-name">
            //                 ${parsedItemNames[i]}
            //             </div>
            //         </div>
            //         <div class="item-name-bg"></div>
            //     </div>
            // `);

            $('.container .mid-container').append(`
            <div class="item" id="${itemId}" onclick="select(this)">
                <div class="img-square">
                    <img src='nui://fcrp_inventory/html/img/items/${itemId}.png'>
                </div>
                <div class="text-column">
                    <span>${parsedItemNames[itemId]}</span>
                </div>
            </div>
            `);

            var bottomText = '<span>';

            for (const [cPartId, amountNedeed] of Object.entries(data.craftingParts)) {
                if (ownedParts[cPartId] >= amountNedeed) {
                    bottomText = bottomText + ownedParts[cPartId] + '/' + amountNedeed + ' ' + parsedItemNames[cPartId] + ', ';
                } else {
                    if (ownedParts[cPartId] != undefined) {
                        bottomText = bottomText + '<n>' + ownedParts[cPartId] + '/' + amountNedeed + ' ' + parsedItemNames[cPartId] + '</n>, ';
                    } else {
                        bottomText = bottomText + '<n>0/' + amountNedeed + ' ' + parsedItemNames[cPartId] + '</n>, ';
                    }
                }
            }

            bottomText = bottomText + "</span>";

            $(`.container .mid-container #${itemId} .text-column`).append(bottomText);

            if (data.canCraft == false) {
                $(`#${itemId}`).addClass('disabled');
            }
        });
    }

    if (event.data.action == 'close') {
        $('.container').hide();
        // $('.craftable-info-container .itemselected').html("<div class='imageitem'></div><p class='invtitle'>Selecione um item <br/></p> <p class='invdesc'>Selecione um item da esquerda que deseje craftar e verá abaixo os itens necessários para craftar. </p> ");
        $('.container .mid-container').html('');
    }

    if (event.data.action == 'update') {
        var newOwnedParts = event.data.updatedOwnedItems;

        $.each(newOwnedParts, function(ownedPartId, amount) {
            ownedParts[ownedPartId] = amount;

            for (const [itemId, data] of Object.entries(craftingItems)) {
                var bottomText = '<span>';
                var update = false;
                for (const [cPartId, amountNedeed] of Object.entries(data.craftingParts)) {
                    if (update == true || newOwnedParts[cPartId]) {
                        update = true
                        if (ownedParts[cPartId] >= amountNedeed) {
                            bottomText = bottomText + ownedParts[cPartId] + '/' + amountNedeed + ' ' + parsedItemNames[cPartId] + ', ';
                        } else {
                            if (ownedParts[cPartId] != undefined) {
                                bottomText = bottomText + '<n>' + ownedParts[cPartId] + '/' + amountNedeed + ' ' + parsedItemNames[cPartId] + '</n>, ';
                            } else {
                                bottomText = bottomText + '<n>0/' + amountNedeed + ' ' + parsedItemNames[cPartId] + '</n>, ';
                            }
                            if ($(`.container .mid-container #${itemId}`).hasClass('selected')) {
                                $(`.container .mid-container #${itemId}`).removeClass('selected');
                            }
                        }
                    }
                }

                if (update == true) {
                    $(`.container .mid-container #${itemId} .text-column span:nth-child(2)`).remove();
                    bottomText = bottomText + "</span>";
                    $(`.container .mid-container #${itemId} .text-column`).append(bottomText);
                }
            }
        });

        var newUpdatedCraftingStatus = event.data.updatedCraftingStatus;
        $.each(newUpdatedCraftingStatus, function(id, canCraft) {
            if (canCraft != undefined && canCraft == true) {
                $(`#${id}`).removeClass('disabled');
            } else {
                $(`#${id}`).addClass('disabled');
            }
        });
    }
});

function select(element) {
    if (!($(element).hasClass('disabled'))) {
        $('.selected').removeClass('selected');
        $(element).addClass('selected');
        $.post("http://vp_crafting/selectSound", JSON.stringify({}));
    } else {
        $.post("http://vp_crafting/selectErrorSound", JSON.stringify({}));
    }
}

function craft() {
    if ($('.selected').length > 0) {
        var id = $('.selected').attr('id');
        $.post("http://vp_crafting/craft", JSON.stringify({
            id: id
        }));
    } else {
        $.post("http://vp_crafting/selectErrorSound", JSON.stringify({}));
    }
}

$(document).ready(function() {
    $(document).keyup(function(e) {
        if (e.which == 27) {
            $('.container').hide();
            $('.container .mid-container').html('');
            $.post("http://vp_crafting/close", JSON.stringify({}));
        }
    });
});