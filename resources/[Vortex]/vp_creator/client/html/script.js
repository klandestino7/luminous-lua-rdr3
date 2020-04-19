var open = false;
$('#clothesmenu').fadeOut(0);
$('#barbermenu').fadeOut(0);
$('#creatormenu').fadeOut(0);
var currentMenu = null;
var hairColors = null;
var makeupColors = null;
let headBlend = {};


const throttle = (func, limit) => {
    let inThrottle
    return (...args) => {
        if (!inThrottle) {
            func(...args)
            inThrottle = setTimeout(() => inThrottle = false, limit)
        }
    }
}


window.addEventListener('message', function(event) {
    if (event.data.action == "showCreate") {
        gender = event.data.gender;
        if (gender == "mp_female") {
            document.getElementById("barba").classList.add("disabled");
        } else {
            document.getElementById("barba").classList.remove("disabled");
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

$(function () {
    $('.modal').modal();

    document.onkeyup = function (data) {
        if (open) {
            // data.getModifierState("Shift") &&
            if (data.which == 27) {
                if ($('#closemenu').hasClass('open')) {
                    $('#closemenu').modal('close');
                }
                else {
                    $('#closemenu').modal('open');
                }
            }
        }
    };

    $('#save').on('click', function() {
        CloseMenu(true)
    })
    $('#discard').on('click', function() {
        CloseMenu(false)
    })

    function CloseMenu(save) {
        $.post('http://nc_clothes/escape', JSON.stringify({save:save}));
    }

    $(document).on('contextmenu', function() {
        $.post('http://nc_clothes/togglecursor', JSON.stringify({}));
    })


    $('.menu-selectb').on('click', function () {
        $('.menu-selectb').removeClass('active')
        $('.menu-selectb').each(function() {
            $("#" + $(this).attr('data-target')).fadeOut(100);
        })

        let t = $("#" + $(this).attr('data-target'))
        $(this).addClass('active');
        t.fadeIn(100);
    })
    
    $('.button-left').on('click', function () {
        var input = $(this).parent().find('.input-number')
        input.val(parseInt(input.val()) - 1)
        inputChange(input,false)
    })
    $('.button-right').on('click', function () {
        var input = $(this).parent().find('.input-number')
        input.val(parseInt(input.val()) + 1)
        inputChange(input,true)
    })

    $('.button-leftstep').on('click', function () {
        var input = $(this).parent().find('.input-number')
        if (input.val() <= -1) {
            return    
        }
        input.val(parseFloat(input.val()).toFixed(1) - 0.1)    
        inputChange(input,false)
    })

    $('.button-rightstep').on('click', function () {
        var input = $(this).parent().find('.input-number')
        if (input.val() >= 1) {
            return    
        }
        input.val(parseFloat(input.val()) + 0.1)
        inputChange(input,true)
    })

    $('.button-leftalt').on('click', function () {
        var input = $(this).parent().find('.input-number')
        if (input.val() <= 1.50) {
            return    
        }
        input.val(parseFloat(input.val()).toFixed(2) - 0.01)    
        inputChange(input,false)
    })

    $('.button-rightalt').on('click', function () {
        var input = $(this).parent().find('.input-number')
        if (input.val() >= 2.00) {
            return    
        }
        input.val(parseFloat(input.val()) + 0.01)
        inputChange(input,true)
    })

    $('.button-leftpeso').on('click', function () {
        var input = $(this).parent().find('.input-number')
        if (input.val() <= 50) {
            return    
        }
        input.val(parseFloat(input.val()) - 1)    
        inputChange(input,false)
    })

    $('.button-rightpeso').on('click', function () {
        var input = $(this).parent().find('.input-number')
        if (input.val() >= 130) {
            return    
        }
        input.val(parseFloat(input.val()) + 1)
        inputChange(input,true)
    })

    $('.input-number').on('input', function () {
        inputChange($(this),true)
    })

    $('.input-number').on('mousewheel', function () {})

    $('#skin_string').find('input').keypress(function (e) {
        if (e.which == 13) {
            $.post('http://nc_clothes/customskin', JSON.stringify($(this).val()));
        }
    })

    // camera buttons
    function toggleCam(ele) {
        $('tog_head').removeClass('active');
        $('tog_torso').removeClass('active');
        $('tog_leg').removeClass('active');
        ele.addClass('active');
    }

    $('.tog_head').on('click', function() {
        toggleCam($(this));
        $.post('http://nc_clothes/switchcam', JSON.stringify({name: 'head'}))
    })
    $('.tog_torso').on('click', function() {
        toggleCam($(this));
        $.post('http://nc_clothes/switchcam', JSON.stringify({name: 'torso'}))
    })
    $('.tog_leg').on('click', function() {
        toggleCam($(this));
        $.post('http://nc_clothes/switchcam', JSON.stringify({name: 'leg'}))
    })
    $('.tog_cam').on('click', function() {
        toggleCam($(this));
        $.post('http://nc_clothes/switchcam', JSON.stringify({name: 'cam'}))
    })


    $('.tog_hat').on('click', function() {
        $.post('http://nc_clothes/toggleclothes', JSON.stringify({name: "hats"}))
    })
    $('.tog_glasses').on('click', function() {
        $.post('http://nc_clothes/toggleclothes', JSON.stringify({name: "glasses"}))
    })
    $('.tog_tops').on('click', function() {
        // dont look at this :)
        $.post('http://nc_clothes/toggleclothes', JSON.stringify({name: "jackets"}))
        $.post('http://nc_clothes/toggleclothes', JSON.stringify({name: "undershirts"}))
        $.post('http://nc_clothes/toggleclothes', JSON.stringify({name: "torsos"}))
        $.post('http://nc_clothes/toggleclothes', JSON.stringify({name: "vest"}))
        $.post('http://nc_clothes/toggleclothes', JSON.stringify({name: "bags"}))
        $.post('http://nc_clothes/toggleclothes', JSON.stringify({name: "neck"}))
        $.post('http://nc_clothes/toggleclothes', JSON.stringify({name: "decals"}))
    })
    $('.tog_legs').on('click', function() {
        $.post('http://nc_clothes/toggleclothes', JSON.stringify({name: "legs"}))
    })
    $('.tog_mask').on('click', function() {
        $.post('http://nc_clothes/toggleclothes', JSON.stringify({name: "masks"}))
    })

    $('#reset').on('click', function() {
        $.post('http://nc_clothes/resetped', JSON.stringify({}))
    })


    window.addEventListener("keydown", throttle(function (ev) {
        var input = $(ev.target);
        var num = input.hasClass('input-number');
        var _key = false;
        if (ev.which == 39 || ev.which == 68) {
            if (num === false) {
                _key = "left"
            }
            else if (num) {
                input.val(parseInt(input.val()) + 1)
                inputChange(input,true)
            }
        }
        if (ev.which == 37 || ev.which == 65) {
            if (num === false) {
                _key = "right"
            }
            else if (num) {
                input.val(parseInt(input.val()) - 1)
                inputChange(input,false)
            }
        }

        if (_key) {
            $.post('http://nc_clothes/rotate', JSON.stringify({key: _key}))
        }
    }, 50))

});
