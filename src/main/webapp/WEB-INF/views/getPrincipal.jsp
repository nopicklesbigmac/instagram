<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
    var principal;

    $.ajax({
        type: "GET",
        url: "/getPrincipal",
        headers: {'Authorization':localStorage.getItem('Authorization'),
            'Refresh-Token':localStorage.getItem('Refresh-Token')},
        contentType: "application/json; charset=utf-8",
    }).done(function(resp) {
        principal = resp;
        if(principal.use_profile_img == 1) {
            $('#profilebutton').attr('src', "/dynamicImage/profile/" + principal.username + "/profile.jpg");
        } else {
            $('#profilebutton').attr('src', "/dynamicImage/profile/default.jpg");
        }
    }).fail(function (resp) {
    });

</script>