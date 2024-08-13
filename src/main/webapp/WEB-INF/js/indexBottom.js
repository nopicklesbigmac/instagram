var principal;

function init() {
    $.ajax({
        type: "GET",
        url: "/getPrincipal",
        headers: {'Authorization': localStorage.getItem('Authorization')},
        contentType: "application/json; charset=utf-8",
    }).done(function (resp) {
        principal = resp;
    });
}

function onclickProfile(username) {
    location.href = "/profile/" + username;
}

function onclickFollow(toaccountId, isPopup) {
    var likedUser;
    if(isPopup === 1) {
        likedUser = document.getElementById("likedUser" + toaccountId);
    }

    let data = {
        fromaccountId: principal.id,
        toaccountId: toaccountId
    }

    $.ajax({
        type: "POST",
        url: "/follow",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        dataType: "json"
    }).done(function (resp){

        if (isPopup === 0) { // 회원님을 위한 추천에서 팔로우
            var followOrUnfollowDiv = document.getElementById('followOrUnfollow' + toaccountId);
            followOrUnfollowDiv.removeChild(document.getElementById('index_account_followButton' + toaccountId));

            var divElement = document.createElement('div');
            divElement.id = 'index_account_unFollowButton' + toaccountId;
            divElement.textContent = '팔로잉';
            divElement.className = 'index_account_unFollowButton';
            divElement.onclick = function() {
                unfollowPopup(toaccountId, 0);
            };

            var followOrUnfollowDiv = document.getElementById('followOrUnfollow' + toaccountId);
            followOrUnfollowDiv.appendChild(divElement);
        } else if (isPopup === 1) { // 게시물의 좋아요 유저 목록에서 팔로우
            var buttonDiv = likedUser.querySelector("#likedUser_buttonDiv");
            buttonDiv.removeChild(buttonDiv.querySelector('#likedUser_followButton'));

            var likedUser_unFollowButton = document.createElement('div');
            likedUser_unFollowButton.id = 'likedUser_unFollowButton';
            likedUser_unFollowButton.textContent = '팔로잉';
            likedUser_unFollowButton.onclick = function() {
                unfollowPopup(toaccountId, 1);
            };
            buttonDiv.appendChild(likedUser_unFollowButton);
        }

    }).fail(function(error){
        alert(JSON.stringify(error));
    });
}

function onclickUnfollow(toaccountId, isPopup) {
    var likedUser;
    if(isPopup === 1) {
        likedUser = document.getElementById("likedUser" + toaccountId);
    }

    let data = {
        fromaccountId: principal.id,
        toaccountId: toaccountId
    }

    $.ajax({
        type: "DELETE",
        url: "/unfollow",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        dataType: "json"
    }).done(function (resp){

        if (isPopup === 0) { // 회원님을 위한 추천에서 언팔로우
            var followOrUnfollowDiv = document.getElementById('followOrUnfollow' + toaccountId);
            followOrUnfollowDiv.removeChild(document.getElementById('index_account_unFollowButton' + toaccountId));

            var divElement = document.createElement('div');
            divElement.id = 'index_account_followButton' + toaccountId;
            divElement.textContent = '팔로우';
            divElement.className = 'index_account_followButton';
            divElement.onclick = function() {
                onclickFollow(toaccountId, 0);
            };

            var followOrUnfollowDiv = document.getElementById('followOrUnfollow' + toaccountId);
            followOrUnfollowDiv.appendChild(divElement);

            document.getElementById('unfollowPopupBackground').style.display = 'none';
        } else { // 게시물의 좋아요 유저 목록에서 언팔로우
            var buttonDiv = likedUser.querySelector("#likedUser_buttonDiv");
            buttonDiv.removeChild(buttonDiv.querySelector('#likedUser_unFollowButton'));

            var likedUser_followButton = document.createElement('div');
            likedUser_followButton.id = 'likedUser_followButton';
            likedUser_followButton.textContent = '팔로우';
            likedUser_followButton.onclick = function() {
                onclickFollow(toaccountId, 1);
            };
            buttonDiv.appendChild(likedUser_followButton);
        }

    }).fail(function(error){
        alert(JSON.stringify(error));
    });
}

function unfollowPopup(toaccountId, isPopup) {
    var parentDiv = document.getElementById("index_account" + toaccountId);

    document.getElementById("unfollowPopupInfoImg").src = parentDiv.querySelector("#index_profileImg").src;
    document.getElementById("unfollowPopupSpan").innerText = "@" + parentDiv.querySelector('#index_account_username').innerText + " 님의 팔로우를 취소하시겠어요?";

    document.getElementById("optionUnfollow").onclick = function() {
        onclickUnfollow(toaccountId, isPopup);
    };

    document.getElementById("unfollowPopupBackground").style.display = "block";
}

function onclickPopupCancel() {
    document.getElementById("unfollowPopupBackground").style.display = "none";
}

function onclickLikeListPopupCancel() {
    document.getElementById("likedUserList").innerHTML = "";
    document.getElementById("likeListPopupBackground").style.display = "none";
}

function Like(postId) {
    let data = {
        principalId: principal.id,
        postId: postId
    };

    $.ajax({
        type: "POST",
        url: "/postLike",
        data: JSON.stringify(data),
        contentType: "application/json"
    }).done(function (resp) {
        var indexpost = document.getElementById('indexpost' + postId);
        indexpost.querySelector("#indexpost_likes").innerText = "좋아요 " + resp + "개";

        var likeButtonDiv = indexpost.querySelector("#likeButtonDiv");
        var likeButton = likeButtonDiv.querySelector("#likeButton")
        likeButtonDiv.removeChild(likeButton);

        var unLikeButton = document.createElement('div');
        unLikeButton.id = 'unLikeButton';
        unLikeButton.className = 'buttons';
        unLikeButton.innerHTML = '<span>❤️</span>';
        unLikeButton.onclick = function () {
            Unlike(postId);
        }
        likeButtonDiv.appendChild(unLikeButton);
    }).fail(function (error) {
        alert(JSON.stringify(error));
    });
}

function Unlike(postId) {
    let data = {
        principalId: principal.id,
        postId: postId
    };

    $.ajax({
        type: "DELETE",
        url: "/postUnlike",
        data: JSON.stringify(data),
        contentType: "application/json"
    }).done(function (resp) {
        var indexpost = document.getElementById('indexpost' + postId);
        indexpost.querySelector("#indexpost_likes").innerText = "좋아요 " + resp + "개";

        var likeButtonDiv = indexpost.querySelector("#likeButtonDiv");
        var unLikeButton = likeButtonDiv.querySelector("#unlikeButton")
        likeButtonDiv.removeChild(unLikeButton);

        var likeButton = document.createElement('div');
        likeButton.id = 'likeButton';
        likeButton.className = 'buttons';
        likeButton.innerHTML = '<span>🤍</span>';
        likeButton.onclick = function () {
            Like(postId);
        }
        likeButtonDiv.appendChild(likeButton);
    }).fail(function (error) {
        alert(JSON.stringify(error));
    });
}

function gotoProfile(username) {
    location.href = "/profile/" + username;
}

function makeReply(postId) {
    var indexpost = document.getElementById("indexpost" + postId);
    var indexpost_makeReplyInput = indexpost.querySelector("#indexpost_makeReplyInput");
    var comment = indexpost_makeReplyInput.value;

    if (!comment) {
        alert("댓글을 입력해 주세요.");
    } else {
        let data = {
            comment: comment,
            accountId: principal.id,
            postId: postId
        };

        $.ajax({
            type: "POST",
            url: "/postReply",
            data: JSON.stringify(data),
            contentType: "application/json"
        }).done(function (resp) {
            indexpost_makeReplyInput.value = "";

            const tempDiv = document.createElement("div");
            tempDiv.style.display = "flex";
            tempDiv.style.flexDirection = "row";
            tempDiv.style.width = "468px";
            tempDiv.style.marginBottom = "-6px";

            const tempReplyUsername = document.createElement("span");
            tempReplyUsername.id = "indexpost_comment";
            tempReplyUsername.innerText = principal.username;
            tempReplyUsername.onclick = function () {
                gotoProfile(principal.username);
            }

            const tempReplyComment = document.createElement("span");
            tempReplyComment.id = "indexpost_commentspan";
            tempReplyComment.innerText = comment;

            tempDiv.appendChild(tempReplyUsername);
            tempDiv.appendChild(tempReplyComment);
            indexpost.querySelector("#indexpost_tempReply").appendChild(tempDiv);
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
    }
}

function NextPrevImage(postId, maxIdx, norp) {
    const indexpost = document.getElementById('indexpost' + postId);
    var indexpost_postImageIdx = indexpost.querySelector('#indexpost_postImageIdx');
    var imgIdx = parseInt(indexpost_postImageIdx.innerText, 10);

    var indexpost_postImgBox = indexpost.querySelector('#indexpost_postImgBox');
    var imagePrevButton = indexpost_postImgBox.querySelector('#imagePrevButton');
    var imageNextButton = indexpost_postImgBox.querySelector('#imageNextButton');
    if (norp === 0) { // 이전
        imgIdx--;
        if (imgIdx === 0) {
            imagePrevButton.style.display = "none";
        }
        if (imgIdx === maxIdx-1) {
            imageNextButton.style.display = "block";
        }
    } else { // 다음
        imgIdx++;
        if (imgIdx === maxIdx-0) {
            imageNextButton.style.display = "none";
        }
        if (imgIdx === 1) {
            imagePrevButton.style.display = "block";
        }
    }
    indexpost_postImageIdx.innerText = imgIdx;

    var indexpost_postImage = indexpost_postImgBox.querySelector('#indexpost_postImage');
    indexpost_postImage.src = "/dynamicImage/posts/" + postId + "/" + imgIdx + ".jpg";
}