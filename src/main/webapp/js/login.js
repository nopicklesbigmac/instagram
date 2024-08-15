let index = {
    init: function() {
        // username 및 password 입력 필드에 input 이벤트 리스너 추가
        document.getElementById('email').addEventListener('input', index.validateInputs);
        document.getElementById('password').addEventListener('input', index.validateInputs);

        // 로그인 버튼 클릭 시 login 함수 호출
        $("#btn-login").on("click", () => {
            this.login();
        });
    },

    validateInputs: function() {
        // 입력된 username과 password 값을 가져옴
        var usrValue = document.getElementById('email').value;
        var passwordValue = document.getElementById('password').value;
        var loginButton = document.getElementById('btn-login');
        var loginText = document.getElementById('loginText');

        // username이 1자 이상이고 password가 6자 이상일 때만 로그인 버튼 활성화
        loginButton.disabled = usrValue.length < 1 || passwordValue.length < 6;

        // 버튼이 활성화되면 텍스트 색상을 변경
        if (!loginButton.disabled) {
            loginText.style.color = '#ffffff'; // 활성화된 텍스트 색상
        } else {
            loginText.style.color = ''; // 기본 텍스트 색상 (CSS에서 정의된 색상)
        }
    },

    facebookClick: function() {
        // 페이스북 버튼 클릭 시 이미지를 변경
        var imageElement = document.getElementById("facebookButton");
        imageElement.src = "/image/login/log_fc2.png";
    },

    login: function() {
        // 기존에 표시된 에러 메시지가 있으면 삭제
        var existingMessage = document.getElementById('ErrorMessage');
        if (existingMessage) {
            existingMessage.remove();
        }

        // 입력된 username과 password 값을 가져와서 data 객체로 생성
        let data = {
            email: $("#email").val(),
            password: $("#password").val()
        };
        
        let params = {
		    email: $("#email").val(),
            password: $("#password").val()
			}

        // 서버에 로그인 요청을 보내기 위해 AJAX 호출
        $.ajax({
            type: "POST", // POST 요청
            url: "/loginProc", // 로그인 처리 URL
            data: params,  // 데이터를 JSON 형식으로 변환하여 전송
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function(response) { // 서버 응답이 성공일 경우
                if(response.status === "success") {
                    window.location.href = "/home/index"; // 로그인 성공 시 홈 화면으로 이동
                } else if(response.status === "fail") {
                    alert("로그인 실패: " + response.message); // 실패 메시지 표시
                }
            },
            error: function(error) { // 서버 응답이 실패일 경우
                console.log(JSON.stringify(error)); // 에러 로그 출력
                alert("로그인 실패. 다시 시도해주세요."); // 에러 메시지 표시
            }
        });
    }
}

function keyHandler(event) {
    var usrValue = document.getElementById('email').value;
    var passwordValue = document.getElementById('password').value;
    if (usrValue.length >= 1 && passwordValue.length >= 6 && event.key === 'Enter') {
        event.preventDefault(); // 기본 Enter 키 동작 방지
        index.login(); // 로그인 함수 호출
    }
}

// 초기화 함수 호출
index.init();
