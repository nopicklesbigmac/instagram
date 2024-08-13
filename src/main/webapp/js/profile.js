function gotoPost(url) {
    location.href = url;
}

function editProfile() {
    location.href = "/accounts/edit"
}

function showOptionPopup() {
    document.getElementById("optionPopupBackground").style.display = 'block';
}

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