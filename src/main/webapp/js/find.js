

function keyHandler(event) {
	if (event.key === 'Enter') {
		event.preventDefault();
		findUsers();
	}
}

function findUsers() {
	var usernameInput = document.getElementById('findInput').value;
	if (usernameInput === "") {
		alert("유저네임을 입력해주세요.");
	} else {
		req = new XMLHttpRequest();
		req.onreadystatechange = textChange;
		req.open('post', 'searchuser');
		req.send(usernameInput);
	}
}
function textChange() {
	if (req.readyState == 4 && req.status == 200) {
		try {
			var jsonDatas = JSON.parse(req.responseText);
			alert("dwdw");
			for (var i = 0; i < jsonDatas.cd.length; i++) {
				const userDiv = document.createElement("div");
				userDiv.className = "user";

				const userContent = document.createElement("div");
				userContent.id = "user_content"; // HTML 요소의 ID는 고유해야 합니다.
				userContent.style.display = "flex";
				userContent.style.flexDirection = "row";

				const userProfileImg = document.createElement("img");
				userProfileImg.className = "user_profile_img";
				if (jsonDatas.cd[i].use_profile_img === "") {
					userProfileImg.src = "/image/profile/default.jpg";
				} else {
					userProfileImg.src = "/image/profile/default.jpg";
				}
				userContent.appendChild(userProfileImg);

				const userInfo = document.createElement("div");
				userInfo.className = "user_info";
				userInfo.style.display = "flex";
				userInfo.style.flexDirection = "column";

				const userUsername = document.createElement("span");
				userUsername.className = "user_username";
				userUsername.style.fontSize = "14px";
				userUsername.style.fontWeight = "bold";
				userUsername.style.marginBottom = "-2px";
				userUsername.innerText = jsonDatas.cd[i].username; // 'username'을 'user_name'으로 수정
				userInfo.appendChild(userUsername);

				const userName = document.createElement("span");
				userName.className = "user_name";
				userName.style.fontSize = "14px";
				userName.style.color = "#737373";
				userName.innerText = jsonDatas.cd[i].name;
				userInfo.appendChild(userName);

				userContent.appendChild(userInfo);



				userDiv.appendChild(userContent);
				usersDiv.appendChild(userDiv);
				usersDiv.addEventListener('click', function(event) {
					const userDiv = event.target.closest('.user');
					if (userDiv) {
						const email = jsonDatas.cd[Array.from(usersDiv.children).indexOf(userDiv)].email; // 이메일 가져오기
						const url = `/profile/${email}`; // URL 생성
						window.location.href = url; // URL로 이동
					}
				});
			}
		} catch (e) {
			console.error("JSON 파싱 오류:", e);
			alert("서버에서 받은 데이터가 올바르지 않습니다.");
			return;
		}

	}
}