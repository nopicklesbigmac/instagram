
function gotoPost(url) {
    // JavaScript 함수 내에서 세션 값을 사용할 수 있습니다.
    console.log("User email: " + sessionEmail); // 예시로 콘솔에 출력
    location.href = url;
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



function onclickFollow(fromaccountId, toaccountId) {
    let data = {
        fromaccountId: fromaccountId,
        toaccountId: toaccountId
    }

    $.ajax({
        type: "POST",
        url: "/follow",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        dataType: "json"
    }).done(function (resp){

        var isMyProfile = document.getElementById('followOrUnfollow');
        isMyProfile.removeChild(document.getElementById('followButton' + toaccountId));

        var divElement = document.createElement('div');
        divElement.id = 'unfollowButton' + toaccountId;
        divElement.textContent = '팔로잉';
        divElement.className = 'profileButton';
        divElement.style.width = '82px';
        divElement.style.height = '32px';
        divElement.style.marginLeft = '20px';
        divElement.style.display = 'flex';
        divElement.style.justifyContent = 'center';
        divElement.style.alignItems = 'center';
        divElement.style.cursor = 'pointer';
        divElement.onclick = function() {
            onclickUnfollow(fromaccountId, toaccountId);
        };

        isMyProfile.appendChild(divElement);

    }).fail(function(error){
        alert(JSON.stringify(error));
    });
}

function onclickUnfollow(fromaccountId, toaccountId) {
    let data = {
        fromaccountId: fromaccountId,
        toaccountId: toaccountId
    }

    $.ajax({
        type: "DELETE",
        url: "/unfollow",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        dataType: "json"
    }).done(function (resp){

        var isMyProfile = document.getElementById('followOrUnfollow');
        isMyProfile.removeChild(document.getElementById('unfollowButton' + toaccountId));

        var divElement = document.createElement('div');
        divElement.id = 'followButton' + toaccountId;
        divElement.textContent = '팔로우';
        divElement.className = 'followButton';
        divElement.style.width = '82px';
        divElement.style.height = '32px';
        divElement.style.marginLeft = '20px';
        divElement.style.display = 'flex';
        divElement.style.justifyContent = 'center';
        divElement.style.alignItems = 'center';
        divElement.style.cursor = 'pointer';
        divElement.onclick = function() {
            onclickFollow(fromaccountId, toaccountId);
        };
        isMyProfile.appendChild(divElement);

        document.getElementById('unfollowPopupBackground').style.display = 'none';

    }).fail(function(error){
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