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

        let params = {
            email: $("#username").val(),
            password: $("#password").val()
        };

		 $.ajax({
		    type: "POST",
		    url: "/loginProc",
		    data: JSON.stringify(params),
		    contentType: "application/json", // contentType 추가
		    success: function(resp) {
		        if (resp.status === "success") {
		            //location.href = "/view/home/index.jsp";
		            //window.location.href = resp.redirectUrl || "/views/home/index";
		            window.location.href = resp.redirectUrl; // 서버에서 제공한 URL로 리다이렉트
		        } else if (resp.status === "fail") {
		            var ErrorMessageSpan = document.createElement('span');
		            ErrorMessageSpan.id = 'ErrorMessage';
		            ErrorMessageSpan.textContent = '잘못된 비밀번호입니다. 다시 확인하세요.';
		            ErrorMessageSpan.style.color = '#ff4857';
		            ErrorMessageSpan.style.fontSize = '14px';
		            document.getElementById('ErrorMessageBox').appendChild(ErrorMessageSpan);
		        }
		    },
		    error: function(XMLHttpRequest, textStatus, errorThrown) {
		        var ErrorMessageSpan = document.createElement('span');
		        ErrorMessageSpan.id = 'ErrorMessage';
		        ErrorMessageSpan.textContent = '서버 오류가 발생했습니다. 나중에 다시 시도해 주세요.';
		        ErrorMessageSpan.style.color = '#ff4857';
		        ErrorMessageSpan.style.fontSize = '14px';
		        document.getElementById('ErrorMessageBox').appendChild(ErrorMessageSpan);
		        console.error("Error details:", textStatus, errorThrown);
		    }
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

$("#btn-pass").on("click", () => {
    swal.fire({
        title: "비밀번호 찾기!",
        icon: "question",
        showCancelButton: true,
        confirmButtonColor: '#3085d6', // confirm 버튼 색깔 지정
        cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
        confirmButtonText: '승인', // confirm 버튼 텍스트 지정
        cancelButtonText: '취소',
        reverseButtons: false,
    }).then(result => {
        if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
            (async () => {
                const { value: getName } = await Swal.fire({
                    title: '비밀번호 찾기',
                    text: '이메일을 입력해주세요.',
                    input: 'text',
                    inputPlaceholder: 'Email',
                    confirmButtonColor: '#3085d6',
                });

                // 이후 처리되는 내용.
                if(getName==""||getName==null){
					Swal.fire({
                    	title: "이메일을 입력해주세요.",
                        icon: 'warning',
                        confirmButtonColor: '#d33',
                    });
				}
                else {
                    let params2 = {
                        email: getName
                    };
                    $.ajax({
                        type: "POST", // HTTP method type(GET, POST) 형식이다.
                        url: "/passProc", // 컨트롤러에서 대기중인 URL 주소이다.
                        data: JSON.stringify(params2), // Json 형식의 데이터이다.
                        contentType: "application/json; charset=utf-8", // Content-Type 설정
                        success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다.
                            if (res.code == true) {
                                swal.fire({
                                    title: "비밀번호 찾기",
                                    text: "비밀번호는 [ " + res.pass + " ]입니다.",
                                    icon: "success",
                                    confirmButtonColor: '#3085d6',
                                });
                            } else {
								Swal.fire({
	                               title: "없는 이메일입니다.",
	                               icon: 'warning',
	                               confirmButtonColor: '#d33',
	                            });

                            }
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                            alert("통신 실패.");
                        }
                    });
                }
            })();
        }
    });
});





index.init();