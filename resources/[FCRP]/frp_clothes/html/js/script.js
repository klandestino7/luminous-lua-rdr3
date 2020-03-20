let selected = 1;
let selectedMenu = 0;
var selects = null;
let maxOptions = 7;
let optionInMenu = 0;
let oldMenu = null;
let oldSelectedMenu = 0;
let selectedMenuOption = 0;
let pulante = 0;
let gender = "male";

$(document).ready(function() {
    getOptionsCount();
    for (let i = 0; i < document.getElementsByClassName("arrowvetement-right").length; i++) {
        document.getElementsByClassName("arrowvetement-right")[i].classList.add("inactive");
    }
    for (let i = 0; i < document.getElementsByClassName("arrowvetement-left").length; i++) {
        document.getElementsByClassName("arrowvetement-left")[i].classList.add("inactive");
    }
});

function getOptionsCount() {
    selects = document.getElementsByClassName("block active");
    for (var i = 0; i < selects[0].children[1].children.length; i++) {
        if (selects[0].children[1].children[i].className.includes("group")) {
            optionInMenu = i;
        }
    }
}





$(document).keydown(function(e) {
    switch (e.which) {
        case 35:
            closeCreator();
            break;
        case 38: //up arrow key
            if (!selects[0].children[1].children[selected - 1].className.includes("disabled")) {
                document.getElementsByClassName("arrowvetement-right")[selected - 1].classList.add("inactive");
                document.getElementsByClassName("arrowvetement-left")[selected - 1].classList.add("inactive");
                document.getElementsByClassName("arrowvetement-right")[selectedMenuOption].classList.add("inactive");
                document.getElementsByClassName("arrowvetement-left")[selectedMenuOption].classList.add("inactive");
                for (let i = 0; i < document.getElementsByClassName('contain').length; i++) {
                    if (i == selectedMenu) {
                        document.getElementsByClassName('contain')[i].scrollTop -= 55;
                    }
                }
                if (selects[0].children[1].children[selected]) {
                    if (selectedMenu >= 2) {
                        return;
                    }
                    selects[0].children[1].children[selected].classList.remove("active")
                    if (selected >= 2 && selected <= optionInMenu) {
                        selected -= 1;
                    }
                    if (selects[0].children[1].children[selected].className.includes("group") && !selects[0].children[1].children[selected].className.includes("disabled")) {
                        selects[0].children[1].children[selected].classList.add("active");
                        if (selectedMenu >= 2) {
                            document.getElementsByClassName("arrowvetement-right")[selectedMenuOption].classList.remove("inactive");
                            document.getElementsByClassName("arrowvetement-left")[selectedMenuOption].classList.remove("inactive");
                        } else if (selectedMenu == 1) {
                            if (selected == 8) {
                                allManagement($("h2")[selected + 2].innerHTML);
                            } else {
                                allManagement($("h2")[selected + 1].innerHTML);
                            }
                            document.getElementsByClassName("arrowvetement-right")[selected - 1].classList.remove("inactive");
                            document.getElementsByClassName("arrowvetement-left")[selected - 1].classList.remove("inactive");
                        }
                    }
                }
            }
            break;
        case 8:
            if (selects[0].children[1].children[selected] && selectedMenu >= 1) {
                if (oldMenu == 'visage' && selectedMenu == 1) {
                    selected = 1;
                    $('.block.active').fadeOut(200, function() {
                        $('.block').removeClass('active');
                        $('.block.identity').fadeIn(200, function() {
                            $('.block.identity').addClass('active');
                            getOptionsCount();
                            selectedMenu -= 1;
                            document.getElementById("confirm").classList.remove("disabled");
                        });
                    });
                } else {
                    selected = 1;
                    if (oldMenu == "identity") {
                        document.getElementById("confirm").classList.remove("disabled");
                    }
                    $('.block.active').fadeOut(200, function() {
                        $('.block').removeClass('active');
                        $('.block.' + oldMenu).fadeIn(200, function() {
                            $('.block.' + oldMenu).addClass('active');
                            getOptionsCount();
                            selectedMenu -= 1;
                            selects[0].children[1].children[oldSelectedMenu].classList.remove("active");
                            document.getElementsByClassName('contain')[1].scrollTop -= 240;
                        });
                    });
                }
            }
            break;
        case 37:
            if (selectedMenu >= 2) {
                document.getElementsByClassName("arrowvetement-left")[selectedMenuOption].click();
            } else {
                document.getElementsByClassName("arrowvetement-left")[selected - 1].click();
            }
            break;
        case 13:
        case 39: //right arrow key
            if (selects[0].children[1].children[selected]) {
                if (!selects[0].children[1].children[selected].className.includes("disabled")) {
                    if (!selects[0].children[1].children[selected].getAttribute("arrows") == true) {
                        selects[0].children[1].children[selected].classList.remove("active");
                        oldMenu = selects[0].className.split(' ')[1];
                        var link = selects[0].children[1].children[selected].getAttribute("data-link");
                        if (link == "createName") {
                            console.log('Post NameClicked');
                            $.post("http://frp_clothes/nm", JSON.stringify({}));
                            console.log('Post NameClicked2');
                        } else if (link == "confirm") {
                            $.post("http://frp_clothes/Confirm", JSON.stringify({}));
                            closeCreator();
                        } else {
                            $('.block.active').fadeOut(200, function() {
                                $('.block').removeClass('active');
                                $('.block.' + link).fadeIn(200, function() {
                                    $('.block.' + link).addClass('active');
                                    if (selected == 7) {
                                        oldSelectedMenu = selected - 1;
                                        selectedMenuOption = selected - 1;
                                    } else if (selected == 8) {
                                        oldSelectedMenu = selected - 1;
                                        selectedMenuOption = selected - 1;
                                    }
                                    selectedMenu += 1;
                                    selected = 1;
                                    getOptionsCount();
                                });
                            });
                        }
                    } else {
                        if (selectedMenu >= 2) {
                            document.getElementsByClassName("arrowvetement-right")[selectedMenuOption].click();
                        } else {
                            document.getElementsByClassName("arrowvetement-right")[selected - 1].click();
                        }
                    }
                }
            }
            break;
        case 40: //bottom arrow key
            if (!selects[0].children[1].children[selected - 1].className.includes("disabled")) {
                document.getElementsByClassName("arrowvetement-right")[selected - 1].classList.add("inactive");
                document.getElementsByClassName("arrowvetement-left")[selected - 1].classList.add("inactive");
                document.getElementsByClassName("arrowvetement-right")[selectedMenuOption].classList.add("inactive");
                document.getElementsByClassName("arrowvetement-left")[selectedMenuOption].classList.add("inactive");
                for (let i = 0; i < document.getElementsByClassName('contain').length; i++) {
                    if (i == selectedMenu && selected >= maxOptions) {
                        document.getElementsByClassName('contain')[i].scrollTop += 55;
                    }
                }
                if (selects[0].children[1].children[selected]) {
                    if (selectedMenu >= 2) {
                        return;
                    }
                    selects[0].children[1].children[selected].classList.remove("active")
                    if (selected != optionInMenu) {
                        selected += 1;
                    }
                    if (selects[0].children[1].children[selected].className.includes("group") && !selects[0].children[1].children[selected].className.includes("disabled")) {
                        selects[0].children[1].children[selected].classList.add("active")
                        if (selectedMenu >= 2) {
                            document.getElementsByClassName("arrowvetement-right")[selectedMenuOption].classList.remove("inactive");
                            document.getElementsByClassName("arrowvetement-left")[selectedMenuOption].classList.remove("inactive");
                        } else if (selectedMenu == 1) {
                            if (selected == 8) {
                                allManagement($("h2")[selected + 2].innerHTML);
                            } else {
                                allManagement($("h2")[selected + 1].innerHTML);
                            }
                            document.getElementsByClassName("arrowvetement-right")[selected - 1].classList.remove("inactive");
                            document.getElementsByClassName("arrowvetement-left")[selected - 1].classList.remove("inactive");
                        }
                    }
                }
            }
            break;

           
            

    }   
    
});

$('.arrowvetement-right').on('click', function(e) {
    var li = $(this).parent().find('li.selected'),
        active = li.next(),
        id = active.attr('data'),
        max = $(this).parent().find('li:last-of-type').attr('data');
    if (li != null) {
        if (id <= parseInt(max)) {
            var link = selects[0].children[1].children[selected].getAttribute("data-link");
            if (link != null) {
                $.post("http://frp_clothes/" + link, JSON.stringify({
                    id
                }));
            }

            if ($(this).prev().hasClass('selected')) {
                li.removeClass('selected');
                $(this).parent().find('li:first-of-type').addClass('selected');
            } else {
                li.removeClass('selected');
                active.addClass('selected');
            }
            if ($(this).attr("id") == "itsRadio") {
                if (id <= 17) {
                    document.getElementById('bc' + id).checked = true;
                }
            } else if ($(this).attr("id") == "itsRadio2") {
                if (id <= 17) {
                    document.getElementById('hc' + id).checked = true;
                }
            }
        }
    }
});

$('.arrowvetement-left').on('click', function(e) {
    if (selectedMenu >= 1) {
        var li = $(this).parent().find('li.selected'),
            active = li.prev(),
            id = active.attr('data'),
            max = $(this).parent().find('li:last-of-type').attr('data');
        if (id >= 0) {
            var link = selects[0].children[1].children[selected].getAttribute("data-link");
            if (link != null) {
                $.post("http://frp_clothes/" + link, JSON.stringify({
                    id
                }));
            }
            if ($(this).next().hasClass('selected')) {
                li.removeClass('selected');
                $(this).parent().find('li:last-of-type').addClass('selected');
            } else {
                li.removeClass('selected');
                active.addClass('selected');
            }
            if ($(this).attr("id") == "itsRadio") {
                if (id >= 1) {
                    document.getElementById('bc' + id).checked = true;
                }
            } else if ($(this).attr("id") == "itsRadio2") {
                if (id >= 1) {
                    document.getElementById('hc' + id).checked = true;
                }
            }
        }
    }
});
// NOW I NEED MAKE ALL GAME STRUCT :D



// NUI CALLBACK

window.addEventListener('message', function(event) {
    if (event.data.action == "showCreate") {
        gender = event.data.gender;
        if (gender == "mp_female") {
            //document.getElementBydI("Barba").classList.add("disabled");
            document.getElementById("Saia").classList.remove("disabled");
        } else {
           // document.getElementById("Barba").classList.remove("disabled");
            document.getElementById("Saia").classList.add("disabled");
        }
        $(".skinCreator").fadeIn(500);
    } else if (event.data.action == "hideCreate") {
        closeCreator();
    } else if (event.data.action == "hideOnly") {
        $(".skinCreator").fadeOut(500);
    } else if (event.data.action == "name") {
        let name = event.data.name;
        $(".skinCreator").fadeIn(500);
        document.getElementById("changedName").innerHTML = name;
        if (name) {
            document.getElementById("appr").classList.remove("disabled");
        }
    }
});

const throttle = (func, limit) => {
    let inThrottle
    return (...args) => {
        if (!inThrottle) {
            func(...args)
            inThrottle = setTimeout(() => inThrottle = false, limit)
        }
    }
}


window.addEventListener("keydown", throttle(function (ev) {
    var input = $(ev.target);
    var num = input.hasClass('input-number');
    var _key = false;
    if (ev.which == 68) {
        if (num === false) {
            _key = "left"
        }
        else if (num) {
            input.val(parseInt(input.val()) + 1)
            inputChange(input,true)
        }
    }
    if (ev.which == 65) {
        if (num === false) {
            _key = "right"
        }
        else if (num) {
            input.val(parseInt(input.val()) - 1)
            inputChange(input,false)
        }
    }

    if (_key) {
        $.post('http://frp_clothes/rotate', JSON.stringify({key: _key}))
    }
}, 50))

function closeCreator() {
    $(".skinCreator").fadeOut(500);
    $.post("http://frp_clothes/CloseCreator", JSON.stringify({}));
}



function allManagement(type) {
    $.post('http://frp_charcreation/CameraManagement', JSON.stringify({
        type: type,
    }));
    console.log(type);
}