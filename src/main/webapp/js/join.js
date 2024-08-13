let index = {
    init: function() {
        document.getElementById('email').addEventListener('input', index.validateInputs);
        document.getElementById('name').addEventListener('input', index.validateInputs);
        document.getElementById('username').addEventListener('input', index.validateInputs);
        document.getElementById('password').addEventListener('input', index.validateInputs);

        $("#btn-join").on("click", () => {
            this.join();
        });
    },

    // 챗GPT야 고마워
    validateInputs: function() {
        var emValue = document.getElementById('email').value;
        var nameValue = document.getElementById('name').value;
        var usrValue = document.getElementById('username').value;
        var passwordValue = document.getElementById('password').value;
        var joinButton = document.getElementById('btn-join');
        var joinText = document.getElementById('joinText');

        // 길이가 6글자 이상인 경우에만 버튼 활성화
        joinButton.disabled = emValue.length < 1 || usrValue.length < 1 || passwordValue.length < 6;

        // 버튼이 활성화되었을 때 텍스트 색상 변경
        if (!joinButton.disabled) {
            joinText.style.color = '#ffffff'; // 원하는 활성화 텍스트 색상으로 변경
        } else {
            joinText.style.color = ''; // 기본 텍스트 색상으로 변경 (스타일 시트에서 정의한 값)
        }
    },

    facebookJoinClick: function() {
        var imageElement = document.getElementById("facebookJoin");
        imageElement.src = "/image/join/facebook2.png";
    },
    facebookJoinMouseUp: function () {
        var imageElement = document.getElementById("facebookJoin");
        imageElement.src = "/image/join/facebook.png";
    },

    join: function() {
        // 기존 메시지 삭제
        var params = {
            email: $("#email").val(),
            name: $("#name").val(),
            username: $("#username").val(),
            password: $("#password").val()
        }
    
        var existingMessage = document.getElementById('ErrorMessage');
        if (existingMessage) {
            existingMessage.remove();
        }

        
		    alert($("#email").val());
		    $.ajax({
	                type : "POST",            // HTTP method type(GET, POST) 형식이다.
	                url : "/joinProc",      // 컨트롤러에서 대기중인 URL 주소이다.
	                data : params,            // Json 형식의 데이터이다.
	                success : function(res){ // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
	                    // 응답코드 > 0000
	                    alert(res.code);
	                },
	                error : function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
	                    alert("통신 실패.")
	                }
	            });
        // 메시지 추가
        

        // 메시지를 표시할 요소 찾기
        var firstBigBox = document.getElementById('OneBorder');

        // 메시지 추가
        firstBigBox.appendChild(ErrorMessageSpan);
    }
}

index.init();