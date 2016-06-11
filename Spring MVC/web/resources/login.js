
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
});/**
 * Created by yassine on 6/6/16.
 */
