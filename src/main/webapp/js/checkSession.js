window.onload = checkSession;
function checkSession() {
	 var userSession = "${sessionScope.username}";
	if (!userSession) {
		window.location.href = "/"; // 로그인 페이지 URL로 변경
	}
}

