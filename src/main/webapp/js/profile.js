function gotoPost(postId) {
    var url = '/post/' + encodeURIComponent(postId); // postId를 URL 인코딩
    console.log("Navigating to URL: " + url); // URL 출력
    window.location.href = url;
}

function editProfile() {
    console.log("Redirecting to profile edit page");
    location.href = "/editProfile"; // 컨트롤러에서 정의한 URL
}

//function editProfile() {
//    console.log("Username: " + sessionEmail);
//    location.href = "/editProfileProc";
//}

// 예를 들어, 사용자 프로필 이미지를 표시하는 경우
function showUserProfile() {
    document.getElementById("profileImg").src = sessionProfileImg;
}

//function gotoPost(url) {
//    location.href = url;
//}

//function editProfile() {
//    location.href = "/accounts/edit"
//}

//function showOptionPopup() {
//    document.getElementById("optionPopupBackground").style.display = 'block';
//}

function optionLogout() {
    location.href = "/logout";
}

function optionCancel() {
    document.getElementById("optionPopupBackground").style.display = 'none';
}



function onclickFollow(fromEmail, toEmail) {
    let data = {
        fromEmail: fromEmail,
        toEmail: toEmail
    };

    $.ajax({
        type: "POST",
        url: "/follow",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        dataType: "json"
    }).done(function (resp) {
        var isMyProfile = document.getElementById('followOrUnfollow');
        isMyProfile.removeChild(document.getElementById('followButton' + toEmail));

        var divElement = document.createElement('div');
        divElement.id = 'unfollowButton' + toEmail;
        divElement.textContent = '팔로잉';
        divElement.className = 'profileButton';
        divElement.style.width = '82px';
        divElement.style.height = '32px';
        divElement.style.marginLeft = '20px';
        divElement.style.cursor = 'pointer';
        divElement.onclick = function() {
            onclickUnfollow(fromEmail, toEmail);
        };

        isMyProfile.appendChild(divElement);

    }).fail(function (error) {
        alert(JSON.stringify(error));
    });
}

function onclickUnfollow(fromEmail, toEmail) {
    let data = {
        fromEmail: fromEmail,
        toEmail: toEmail
    };

    $.ajax({
        type: "DELETE",
        url: "/unfollow",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        dataType: "json"
    }).done(function (resp) {
        var isMyProfile = document.getElementById('followOrUnfollow');
        isMyProfile.removeChild(document.getElementById('unfollowButton' + toEmail));

        var divElement = document.createElement('div');
        divElement.id = 'followButton' + toEmail;
        divElement.textContent = '팔로우';
        divElement.className = 'followButton';
        divElement.style.width = '82px';
        divElement.style.height = '32px';
        divElement.style.cursor = 'pointer';
        divElement.onclick = function() {
            onclickFollow(fromEmail, toEmail);
        };
        isMyProfile.appendChild(divElement);

    }).fail(function (error) {
        alert(JSON.stringify(error));
    });
}


function unfollowPopup(toaccountId) {
    var parentDiv = document.getElementById("index_account" + toaccountId);

    document.getElementById("unfollowPopupInfoImg").src = parentDiv.querySelector("#index_profileImg").src;
    document.getElementById("unfollowPopupSpan").innerText = "@" + parentDiv.querySelector('#index_account_username').innerText + " 님의 팔로우를 취소하시겠어요?";

    document.getElementById("optionUnfollow").onclick = function() {
        onclickUnfollow(toaccountId);
    };

    document.getElementById("unfollowPopupBackground").style.display = "block";
}

function onclickPopupCancel() {
    document.getElementById("unfollowPopupBackground").style.display = "none";
}

function sendDm(userId) {
    location.href = "/dm?principalId=" + principal.id + "&userId=" + userId;
}
function toggleFollow() {
	const followButton = document.getElementById('followButton');
	const unfollowButton = document.getElementById('unfollowButton');
	const nameBox = document.getElementById('nameBox');
	var username = '<%= session.getAttribute("username") %>';
	var params = {
            FOLLOWIER_username: username,
            FOLLOWING_username: nameBox.getAttribute('data-username')
        }
   	const valueDisplay = document.getElementById('valueDisplay');
    let currentValue = parseInt(valueDisplay.innerText);
	if (followButton.style.display === 'none') {
		followButton.style.display = 'inline-block';
		unfollowButton.style.display = 'none';
		$.ajax({
			type: "POST",            // HTTP method type(GET, POST) 형식이다.
			url: "/unfollowProc",      // 컨트롤러에서 대기중인 URL 주소이다.
			data: JSON.stringify(params),            // Json 형식의 데이터이다.
			contentType: "application/json; charset=utf-8", // Content-Type 설정
			success: function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
			currentValue -= 1;
            valueDisplay.innerText = currentValue;
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
				alert("통신 실패.")
			}
		});
	} else {
		followButton.style.display = 'none';
		unfollowButton.style.display = 'inline-block';
		$.ajax({
			type: "POST",            // HTTP method type(GET, POST) 형식이다.
			url: "/followingProc",      // 컨트롤러에서 대기중인 URL 주소이다.
			data: JSON.stringify(params),            // Json 형식의 데이터이다.
			contentType: "application/json; charset=utf-8", // Content-Type 설정
			success: function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
             currentValue += 1;
            valueDisplay.innerText = currentValue;
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
				alert("통신 실패.")
			}
		});
	}
}