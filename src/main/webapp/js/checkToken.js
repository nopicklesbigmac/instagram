let checkToken = {
    check: function() {
        $.ajax({
            type: "GET",
            url: "/checkToken",
            headers: {'Authorization':localStorage.getItem('Authorization'),
                'Refresh-Token':localStorage.getItem('Refresh-Token')},
            contentType: "application/json; charset=utf-8",
            dataType: "html"
        }).done(function(resp, status, xhr) {
            reissuedtoken = xhr.getResponseHeader('ReissuedToken')
            if (reissuedtoken != null) {
                localStorage.removeItem('Authorization');
                localStorage.setItem('Authorization', reissuedtoken);
            }
        }).fail(function (resp) { // 토큰이 만료된 경우
            alert("세션이 만료되어 로그인 페이지로 이동합니다.");
            localStorage.removeItem('Authorization');
            localStorage.removeItem('Refresh-Token');
            location.href = "/";
        });
    }
}

checkToken.check();