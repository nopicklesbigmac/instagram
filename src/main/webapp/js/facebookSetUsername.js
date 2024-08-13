function setUsername(oriusername) {
    let data = {
        oriusername: oriusername,
        newusername: document.getElementById('input').value
    };

    $.ajax({
        type: "GET",
        url: "/setUsername",
        data: data,
        contentType: "application/json; charset=utf-8"
    }).done(function(resp) {
        if (resp === 0) { // 이미 해당 유저네임이 존재
            document.getElementById('input').value = "";
            document.getElementById('using').style.display = "block";
        } else {
            alert("아이디 설정이 완료되었습니다.\r\n로그인을 다시 진행해 주세요.");
            location.href = "/";
        }
    });
}