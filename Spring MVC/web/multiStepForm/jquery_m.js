//jQuery time
var current_fs, next_fs, previous_fs; //fieldsets
var left, opacity, scale; //fieldset properties which we will animate
var animating; //flag to prevent quick multi-click glitches


$('[name="next"]').click(function () {

    if (animating) return false;

    var user = getObj();
    var fail = false;

    element = '#result'+ user.step;

    $.ajax({
        url: '/cotransport/ajaxinscription',
        type: 'POST',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        data: JSON.stringify(user),
        async: false,
        success: function (response) {
            $(element).empty();
            if (response.status == 'Fail') {
                fail = true;

                $(element).append("<ul>");

                $.each(response.errors, function (index, errorString) {
                    var array = errorString.split("#");
                    $(element).append("<li>" + array[1] + "</li>");
                });
                $(element).append("</ul><br/>");
            }

        }
    });


    if (fail) return false;

    $('[name="step"]').val(parseInt(user.step)+1);

    animating = true;

    animateNxt(this);
});







$(".previous").click(function () {
    if (animating) return false;
    animating = true;

    step = $('[name="step"]').val();

    $('[name="step"]').val(step-1);


    current_fs = $(this).parent();
    previous_fs = $(this).parent().prev();

    //de-activate current step on progressbar
    $("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");

    //show the previous fieldset
    previous_fs.show();
    //hide the current fieldset with style
    current_fs.animate({opacity: 0}, {
        step: function (now, mx) {
            //as the opacity of current_fs reduces to 0 - stored in "now"
            //1. scale previous_fs from 80% to 100%
            scale = 0.8 + (1 - now) * 0.2;
            //2. take current_fs to the right(50%) - from 0%
            left = ((1 - now) * 50) + "%";
            //3. increase opacity of previous_fs to 1 as it moves in
            opacity = 1 - now;
            current_fs.css({'left': left});
            previous_fs.css({'transform': 'scale(' + scale + ')', 'opacity': opacity});
        },
        duration: 800,
        complete: function () {
            current_fs.hide();
            animating = false;
        },
        //this comes from the custom easing plugin
        easing: 'easeInOutBack'
    });
});
//
//$(".submit").click(function () {
//    $("#msform").submit();
//})




function getObj(){
    var user = new Object();
    user.email = $('[name="email"]').val();
    user.pass = $('[name="pass"]').val();
    user.passc = $('[name="passc"]').val();
    user.step = $('[name="step"]').val();
    user.fname = $('[name="fname"]').val();
    user.lname = $('[name="lname"]').val();
    user.sex = $('[name="phone"]').val();
    user.bdate = $('[name="bdate"]').val();
    user.address = $('[name="address"]').val();
    user.description = $('[name="description"]').val();
    return user;
}


function animateNxt(obj){
    current_fs = $(obj).parent();
    next_fs = $(obj).parent().next();

    //activate next step on progressbar using the index of next_fs
    $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");

    //show the next fieldset
    next_fs.show();
    //hide the current fieldset with style
    current_fs.animate({opacity: 0}, {
        step: function (now, mx) {
            //as the opacity of current_fs reduces to 0 - stored in "now"
            //1. scale current_fs down to 80%
            scale = 1 - (1 - now) * 0.2;
            //2. bring next_fs from the right(50%)
            left = (now * 50) + "%";
            //3. increase opacity of next_fs to 1 as it moves in
            opacity = 1 - now;
            current_fs.css({'transform': 'scale(' + scale + ')'});
            next_fs.css({'left': left, 'opacity': opacity});
        },
        duration: 800,
        complete: function () {
            current_fs.hide();
            animating = false;
        },
        //this comes from the custom easing plugin
        easing: 'easeInOutBack'
    });
}