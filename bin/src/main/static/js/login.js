let index = {
    init: function() {
        document.getElementById('username').addEventListener('input', index.validateInputs);
        document.getElementById('password').addEventListener('input', index.validateInputs);

        $("#btn-login").on("click", () => {
            this.login();
        });
    },

    // 챗GPT야 고마워
    validateInputs: function() {
        var usrValue = document.getElementById('username').value;
        var passwordValue = document.getElementById('password').value;
        var loginButton = document.getElementById('btn-login');
        var loginText = document.getElementById('loginText');

        // 길이가 6글자 이상인 경우에만 버튼 활성화
        loginButton.disabled = usrValue.length < 1 || passwordValue.length < 6;

        // 버튼이 활성화되었을 때 텍스트 색상 변경
        if (!loginButton.disabled) {
            loginText.style.color = '#ffffff'; // 원하는 활성화 텍스트 색상으로 변경
        } else {
            loginText.style.color = ''; // 기본 텍스트 색상으로 변경 (스타일 시트에서 정의한 값)
        }
    },

    facebookClick: function() {
        var imageElement = document.getElementById("facebookButton");
        imageElement.src = "/image/login/log_fc2.png";
    },

    login: function() {
        // 기존 메시지 삭제
        var existingMessage = document.getElementById('ErrorMessage');
        if (existingMessage) {
            existingMessage.remove();
        }

        let data = {
            username: $("#username").val(),
            password: $("#password").val()
        };

        $.ajax({
            type: "POST",
            url: "/auth/loginProc",
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8"
        }).done(function(resp, status, xhr) {
            accesstoken = xhr.getResponseHeader('Authorization')
            refreshtoken = xhr.getResponseHeader('Refresh-Token')

            if (accesstoken != null && refreshtoken != null) { // 로그인에 성공한 경우
                localStorage.setItem('Authorization', accesstoken)
                localStorage.setItem('Refresh-Token', refreshtoken)
                location.href = "/index";
            } else { // 로그인에 실패한 경우
                var ErrorMessageSpan = document.createElement('span');
                ErrorMessageSpan.id = 'ErrorMessage';
                ErrorMessageSpan.textContent = '잘못된 비밀번호입니다. 다시 확인하세요.';
                ErrorMessageSpan.style.color = '#ff4857';
                ErrorMessageSpan.style.fontSize = '14px';
                document.getElementById('ErrorMessageBox').appendChild(ErrorMessageSpan);
            }
        }).fail(function(error) { // 로그인에 실패한 경우
            var ErrorMessageSpan = document.createElement('span');
            ErrorMessageSpan.id = 'ErrorMessage';
            ErrorMessageSpan.textContent = '잘못된 비밀번호입니다. 다시 확인하세요.';
            ErrorMessageSpan.style.color = '#ff4857';
            ErrorMessageSpan.style.fontSize = '14px';
            document.getElementById('ErrorMessageBox').appendChild(ErrorMessageSpan);
            console.log(JSON.stringify(error));
        });
    }
}

function keyHandler(event) {
    var usrValue = document.getElementById('username').value;
    var passwordValue = document.getElementById('password').value;
    if (usrValue.length >= 1 && passwordValue.length >= 6 && event.key == 'Enter') { // Enter 키를 누르는 경우
        event.preventDefault(); // 기본 Enter 키 동작을 막는다.
        index.login();
    }
}

index.init();