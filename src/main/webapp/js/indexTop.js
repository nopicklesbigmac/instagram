function getFollowings() {
    var principal;

    $.ajax({
        type: "GET",
        url: "/getPrincipal",
        headers: {'Authorization': localStorage.getItem('Authorization')},
        contentType: "application/json; charset=utf-8",
    }).done(function (resp) {
        principal = resp;

        let data = {
            principalId: principal.id
        }

        $.ajax({
            type: "GET",
            url: "getFollowings",
            data: data,
            contentType: "application/json; charset=utf-8"
        }).done(function(resp) {
            if (resp > 0) { // 팔로우 중인 유저가 있는 경우
                document.getElementById("NoFollowing").style.display = "none";
            } else {
                document.getElementById("NoFollowing").style.display = "block";
            }
        });
    });
}

function getFollowInfo(toaccountId, isPopup, likedUser) {
    var principal;

    $.ajax({
        type: "GET",
        url: "/getPrincipal",
        headers: {'Authorization': localStorage.getItem('Authorization')},
        contentType: "application/json; charset=utf-8",
    }).done(function (resp) {
        principal = resp;

        let data = {
            fromaccountId: principal.id,
            toaccountId: toaccountId
        }

        $.ajax({
            type: "GET",
            url: "/getFollowInfo",
            data: data, // GET 요청은 JSON으로 보내지 않고 그대로 보낸다.
            contentType: "application/json; charset=utf-8",
        }).done(function (resp) {
            if (isPopup === 0) {
                if (resp === 1) { // 팔로우 되어있는 경우
                    var divElement = document.createElement('div');
                    divElement.id = 'index_account_unFollowButton' + toaccountId;
                    divElement.textContent = '팔로잉';
                    divElement.className = 'index_account_unFollowButton';
                    divElement.onclick = function() {
                        unfollowPopup(toaccountId, 0);
                    };

                    var followOrUnfollowDiv = document.getElementById('followOrUnfollow' + toaccountId);
                    followOrUnfollowDiv.appendChild(divElement);
                } else if (resp === 0) { // 팔로우가 안 되어있는 경우
                    var divElement = document.createElement('div');
                    divElement.id = 'index_account_followButton' + toaccountId;
                    divElement.textContent = '팔로우';
                    divElement.className = 'index_account_followButton';
                    divElement.onclick = function() {
                        onclickFollow(toaccountId, 0);
                    };

                    var followOrUnfollowDiv = document.getElementById('followOrUnfollow' + toaccountId);
                    followOrUnfollowDiv.appendChild(divElement);
                } else if (resp === -1) { // 자기 자신일 경우
                    var div = document.getElementById("index_account" + toaccountId);
                    div.style.display = "none";
                }
            } else {
                if (resp === 1) { // 팔로우 되어있는 경우
                    const likedUser_buttonDiv = document.createElement("div");
                    likedUser_buttonDiv.id = "likedUser_buttonDiv";
                    const likedUser_unFollowButton = document.createElement("div");
                    likedUser_unFollowButton.id = "likedUser_unFollowButton";
                    likedUser_unFollowButton.innerText = "팔로잉";
                    likedUser_unFollowButton.onclick = function () {
                        unfollowPopup(toaccountId, 1);
                    };
                    likedUser_buttonDiv.appendChild(likedUser_unFollowButton);
                    likedUser.appendChild(likedUser_buttonDiv);
                } else if (resp === 0) { // 팔로우가 안 되어있는 경우
                    const likedUser_buttonDiv = document.createElement("div");
                    likedUser_buttonDiv.id = "likedUser_buttonDiv";
                    const likedUser_followButton = document.createElement("div");
                    likedUser_followButton.id = "likedUser_followButton";
                    likedUser_followButton.innerText = "팔로우";
                    likedUser_followButton.onclick = function () {
                        onclickFollow(toaccountId, 1);
                    };
                    likedUser_buttonDiv.appendChild(likedUser_followButton);
                    likedUser.appendChild(likedUser_buttonDiv);
                } else if (resp === -1) { // 자기 자신일 경우
                    // 아무 버튼 표시 x
                }
            }
        }).fail(function (resp) {
            console.log(resp);
        });
    });
}

function addDivs(id, username, name, use_profile_img) {

    var accountBox = document.getElementById("index_accountBox");

    var accountElement = document.createElement("div");
    accountElement.id = "index_account" + id;
    accountElement.className = "index_account"

    var profileImg = document.createElement("img");
    profileImg.id = "index_profileImg";
    profileImg.src = use_profile_img === '1'
        ? "/dynamicImage/profile/" + username + "/profile.jpg"
        : "/dynamicImage/profile/default.jpg";
    profileImg.addEventListener("click", function () {
        onclickProfile(username);
    });

    var accountNames = document.createElement("div");
    accountNames.id = "index_account_names";

    var usernameDiv = document.createElement("div");
    usernameDiv.id = "index_account_username"
    usernameDiv.style.fontSize = "14px";
    usernameDiv.style.fontWeight = "bold";
    usernameDiv.style.cursor = "pointer";
    usernameDiv.textContent = username;
    usernameDiv.addEventListener("click", function () {
        onclickProfile(username);
    });

    var nameDiv = document.createElement("div");
    nameDiv.style.fontSize = "14px";
    nameDiv.style.color = "#737373";
    nameDiv.textContent = name;

    var popularityDiv = document.createElement("div");
    popularityDiv.style.fontSize = "12px";
    popularityDiv.style.color = "#737373";
    popularityDiv.textContent = "인기";

    accountNames.appendChild(usernameDiv);
    accountNames.appendChild(nameDiv);
    accountNames.appendChild(popularityDiv);

    var followOrUnfollow = document.createElement("div");
    followOrUnfollow.id = "followOrUnfollow" + id;

    getFollowInfo(id, 0, null)

    accountElement.appendChild(profileImg);
    accountElement.appendChild(accountNames);
    accountElement.appendChild(followOrUnfollow);

    accountBox.appendChild(accountElement);
}

function addPosts() {
    $.ajax({
        type: "GET",
        url: "/getPrincipal",
        headers: {'Authorization': localStorage.getItem('Authorization')},
        contentType: "application/json; charset=utf-8",
    }).done(function (principal) {

        let data = {
            principalId: principal.id
        }

        $.ajax({
            type: "GET",
            url: "/getFollowPosts",
            data: data,
            contentType: "application/json; charset=utf-8"
        }).done(function (posts) {

            posts.forEach(function(post) {
                var username = post.account.username;
                var postId = post.id;

                // FollowingContents
                const FollowingContents = document.getElementById("FollowingContents");

                // indexpost
                const indexpost = document.createElement("div");
                indexpost.id = "indexpost" + post.id;
                indexpost.style.width = "468px";
                indexpost.style.display = "flex";
                indexpost.style.flexDirection = "column";
                indexpost.style.alignItems = "center";

                    // indexpost_userInfo
                    const indexpost_userInfo = document.createElement("indexpost_userInfo");
                    indexpost_userInfo.id = "indexpost_userInfo";
                    indexpost_userInfo.style.width = "468px";
                    indexpost_userInfo.style.display = "flex";
                    indexpost_userInfo.style.flexDirection = "row";
                    indexpost_userInfo.style.marginBottom = "10px";

                        // indexpost_imgDiv
                        const indexpost_imgDiv = document.createElement("div");
                        indexpost_imgDiv.id = "indexpost_imgDiv";
                        indexpost_imgDiv.style.width = "42px";
                        indexpost_imgDiv.style.height = "42px";
                        indexpost_imgDiv.style.display = "flex";
                        indexpost_imgDiv.style.justifyContent = "center";
                        indexpost_imgDiv.style.alignItems = "center";
                        indexpost_imgDiv.style.marginRight = "8px";

                            // indexpost_image
                            const indexpost_image = document.createElement("img");
                            if (post.account.use_profile_img === 1) {
                                indexpost_image.src = "/dynamicImage/profile/" + post.account.username + "/profile.jpg";
                            } else {
                                indexpost_image.src = "/dynamicImage/profile/default.jpg";
                            }
                            indexpost_image.style.width = "32px";
                            indexpost_image.style.height = "32px";
                            indexpost_image.style.borderRadius = "50%";
                            indexpost_image.style.cursor = "pointer";
                            indexpost_image.onclick = function () {
                                gotoProfile(username);
                            }
                            indexpost_imgDiv.appendChild(indexpost_image);

                        // indexpost_username
                        const indexpost_username = document.createElement("div");
                        indexpost_username.id = "indexpost_username";
                        indexpost_username.style.fontWeight = "bold";
                        indexpost_username.style.fontSize = "14px";
                        indexpost_username.style.display = "flex";
                        indexpost_username.style.justifyContent = "center";
                        indexpost_username.style.alignItems = "center";
                        indexpost_username.style.marginRight = "6px";
                        indexpost_username.innerText = post.account.username;
                        indexpost_username.onclick = function () {
                            gotoProfile(username);
                        }

                        // indexpost_time
                        const indexpost_time = document.createElement("div");
                        indexpost_time.id = "indexpost_time";
                        indexpost_time.style.fontSize = "14px";
                        indexpost_time.style.color = "#737373";
                        indexpost_time.style.display = "flex";
                        indexpost_time.style.justifyContent = "center";
                        indexpost_time.style.alignItems = "center";

                        var createDate = new Date(post.createDate);
                        var now = new Date();
                        var dateObject = now - createDate;

                        var days = Math.floor(dateObject / (1000 * 60 * 60 * 24));
                        if (days > 7) {
                            indexpost_time.innerText = "• " + Math.floor(days / 7) + "주";
                        } else if (days > 0) {
                            indexpost_time.innerText = "• " + days + "일";
                        } else {
                            var hours = Math.floor((dateObject % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                            if (hours > 0) {
                                indexpost_time.innerText = "• " + hours + "시간";
                            } else {
                                var minutes = Math.floor((dateObject % (1000 * 60 * 60)) / (1000 * 60));
                                indexpost_time.innerText = "• " + minutes + "분";
                            }
                        }

                        // indexpost_option
                        const indexpost_option = document.createElement("div");
                        indexpost_option.id = "indexpost_option";
                        indexpost_option.style.marginLeft = "auto";
                        indexpost_option.style.display = "flex";
                        indexpost_option.style.justifyContent = "center";
                        indexpost_option.style.alignItems = "center";

                            // indexpost_optionButton
                            const indexpost_optionButton = document.createElement("img");
                            indexpost_optionButton.src = "/dynamicImage/profile/useroption.png";
                            indexpost_option.appendChild(indexpost_optionButton);

                        indexpost_userInfo.appendChild(indexpost_imgDiv);
                        indexpost_userInfo.appendChild(indexpost_username);
                        indexpost_userInfo.appendChild(indexpost_time);
                        indexpost_userInfo.appendChild(indexpost_option);

                        indexpost.appendChild(indexpost_userInfo);

                    // indexpost_postImgBox
                    const indexpost_postImgBox = document.createElement("div");
                    indexpost_postImgBox.id = "indexpost_postImgBox";
                    indexpost_postImgBox.style.width = "468px";
                    indexpost_postImgBox.style.height = "585px";
                    indexpost_postImgBox.style.backgroundColor = "black";
                    indexpost_postImgBox.style.display = "flex";
                    indexpost_postImgBox.style.justifyContent = "center";
                    indexpost_postImgBox.style.alignItems = "center";
                    indexpost_postImgBox.style.border = "1px solid #ededed";
                    indexpost_postImgBox.style.borderRadius = "4px";
                    indexpost_postImgBox.style.position = "relative";

                        // indexpost_postImage
                        const indexpost_postImage = document.createElement("img");
                        indexpost_postImage.id = "indexpost_postImage";
                        indexpost_postImage.src = "/dynamicImage/posts/" + post.id + "/0.jpg";
                        indexpost_postImage.style.width = "466px";
                        indexpost_postImage.style.maxHeight = "585px";
                        indexpost_postImgBox.appendChild(indexpost_postImage);

                        // imagePrevButton
                        const imagePrevButton = document.createElement("div");
                        indexpost_postImgBox.appendChild(imagePrevButton);
                        imagePrevButton.id = "imagePrevButton";
                        imagePrevButton.className = "imagePrevNextButton";
                        imagePrevButton.style.left = "10px";
                        imagePrevButton.style.display = "none";
                        imagePrevButton.innerText = "◀";
                        imagePrevButton.onclick = function () {
                            NextPrevImage(postId, post.pic_size-1, 0);
                        }

                        // imageNextButton
                        const imageNextButton = document.createElement("div");
                        indexpost_postImgBox.appendChild(imageNextButton);
                        imageNextButton.id = "imageNextButton";
                        imageNextButton.className = "imagePrevNextButton";
                        imageNextButton.style.right = "10px";
                        imageNextButton.innerText = "▶";
                        if (post.pic_size > 1) {
                            imageNextButton.style.display = "block";
                        } else {
                            imageNextButton.style.display = "none";
                        }
                        imageNextButton.onclick = function () {
                            NextPrevImage(postId, post.pic_size-1, 1);
                        }

                        const indexpost_postImageIdx = document.createElement("div");
                        indexpost_postImageIdx.id = "indexpost_postImageIdx";
                        indexpost_postImageIdx.innerText = 0;
                        indexpost_postImageIdx.style.display = "none";
                        indexpost.appendChild(indexpost_postImageIdx);

                        indexpost.appendChild(indexpost_postImgBox);

                    // indexpost_buttons
                    const indexpost_buttons = document.createElement("div");
                    indexpost_buttons.id = "indexpost_buttons";
                    indexpost_buttons.style.width = "468px";
                    indexpost_buttons.style.marginTop = "4px";
                    indexpost_buttons.style.display = "flex";
                    indexpost_buttons.style.flexDirection = "row";

                        // likeButtonDiv
                        const likeButtonDiv = document.createElement("div");
                        likeButtonDiv.id = "likeButtonDiv";
                        indexpost_buttons.appendChild(likeButtonDiv);

                        let getLikeData = {
                            accountId: principal.id,
                            postId: post.id
                        }

                        $.ajax({
                            type: "GET",
                            url: "/post/getLike",
                            data: getLikeData,
                            contentType: "application/json"
                        }).done(function (resp) {
                            if (resp == 1) {
                                // unLikeButton
                                const unlikeButton = document.createElement("div");
                                unlikeButton.id = "unLikeButton";
                                unlikeButton.className = "buttons";
                                unlikeButton.innerText = "❤️";
                                unlikeButton.onclick = function () {
                                    Unlike(postId);
                                };
                                likeButtonDiv.appendChild(unlikeButton);

                            } else {
                                // likeButton
                                const likeButton = document.createElement("div");
                                likeButton.id = "likeButton";
                                likeButton.className = "buttons";
                                likeButton.innerText = "🤍";
                                likeButton.onclick = function () {
                                    Like(postId);
                                };
                                likeButtonDiv.appendChild(likeButton);

                            }
                        }).fail(function (error) {
                            alert("에러 발생 (콘솔 확인)");
                            console.log(error);
                        })

                        // messageButton
                        const messageButton = document.createElement("div");
                        messageButton.id = "messageButton";
                        messageButton.className = "buttons";
                        messageButton.innerText = "💬";
                        messageButton.onclick = function () {
                            location.href = "/post/" + postId;
                        }
                        indexpost_buttons.appendChild(messageButton);

                        // shareButton
                        const shareButton = document.createElement("div");
                        shareButton.id = "shareButton";
                        shareButton.className = "buttons";
                        shareButton.innerText = "🔗";
                        indexpost_buttons.appendChild(shareButton);

                        indexpost.appendChild(indexpost_buttons);

                    // indexpost_likes
                    const indexpost_likes = document.createElement("div");
                    indexpost_likes.id = "indexpost_likes";
                    indexpost_likes.innerText = "좋아요 " + post.likecount + "개";
                    indexpost_likes.onclick = function () {
                        viewLikedUser(postId);
                    }
                    indexpost.appendChild(indexpost_likes);

                    const indexpost_commentDiv = document.createElement("div");
                    indexpost_commentDiv.style.width = "468px";
                    indexpost_commentDiv.style.display = "flex";
                    indexpost_commentDiv.style.flexDirection = "row";

                    // indexpost_comment
                    const indexpost_comment = document.createElement("div");
                    indexpost_comment.id = "indexpost_comment";
                    indexpost_comment.innerText = post.account.username;
                    indexpost_comment.onclick = function () {
                        gotoProfile(username);
                    }

                        // indexpost_commentspan
                        const indexpost_commentspan = document.createElement("span");
                        indexpost_commentspan.id = "indexpost_commentspan";
                        indexpost_commentspan.innerText = post.comment;

                        indexpost_commentDiv.appendChild(indexpost_comment);
                        indexpost_commentDiv.appendChild(indexpost_commentspan);
                        indexpost.appendChild(indexpost_commentDiv);

                    // indexpost_viewReplies
                    const indexpost_viewReplies = document.createElement("div");
                    indexpost_viewReplies.id = "indexpost_viewReplies";
                    indexpost_viewReplies.innerText = "댓글 모두 보기";
                    indexpost_viewReplies.onclick = function () {
                        location.href = "/post/" + postId;
                    }
                    indexpost.appendChild(indexpost_viewReplies);

                    // indexpost_tempReply
                    const indexpost_tempReply = document.createElement("div")
                    indexpost_tempReply.id = "indexpost_tempReply";
                    indexpost_tempReply.style.marginBottom = "10px";
                    indexpost.appendChild(indexpost_tempReply);

                    // indexpost_makeReply
                    const indexpost_makeReply = document.createElement("div");
                    indexpost_makeReply.id = "indexpost_makeReply";
                    indexpost_makeReply.style.position = "relative";
                    indexpost_makeReply.style.width = "468px";

                        // indexpost_makeReplyInput
                        const indexpost_makeReplyInput = document.createElement("input");
                        indexpost_makeReplyInput.id = "indexpost_makeReplyInput";
                        indexpost_makeReplyInput.style.width = "468px";
                        indexpost_makeReplyInput.style.border = "none";
                        indexpost_makeReplyInput.style.paddingRight = "50px";
                        indexpost_makeReplyInput.placeholder = "댓글 달기...";
                        indexpost_makeReply.appendChild(indexpost_makeReplyInput);

                        // replySpan
                        const replySpan = document.createElement("span");
                        replySpan.id = "replySpan"
                        replySpan.innerText = " 게시"
                        replySpan.onclick = function () {
                            makeReply(postId);
                        }
                        indexpost_makeReply.appendChild(replySpan);

                        indexpost.appendChild(indexpost_makeReply);

                    const hrDiv = document.createElement("div");
                    hrDiv.style.width = "468px";
                    const hrElement = document.createElement("hr");
                    hrDiv.appendChild(hrElement);

                FollowingContents.appendChild(indexpost);
                FollowingContents.appendChild(hrDiv);

            });

        }).fail(function (error) {
            alert("에러 발생 (콘솔 확인)");
            console.log(error);
        });

    });
}

function viewLikedUser(postId) {
    document.getElementById("likedUserList").innerHTML = "";

    let data = {
        postId: postId
    };

    $.ajax({
        type: "GET",
        url: "/viewLikedUser",
        data: data,
        contentType: "application/json"
    }).done(function (resp) {

        resp.forEach(function(account) {
            var likedUser = document.createElement("div");
            likedUser.id = "likedUser" + account.id;
            likedUser.className = "likedUser";
            document.getElementById("likedUserList").appendChild(likedUser);

            const likedUser_image = document.createElement("img");
            likedUser_image.id = "likedUser_image";
            if(account.use_profile_img === 1) {
                likedUser_image.src = "/dynamicImage/profile/" + account.username + "/profile.jpg";
            } else {
                likedUser_image.src = "/dynamicImage/profile/default.jpg";
            }
            likedUser_image.onclick = function () {
                location.href = "/profile/" + account.username;
            }
            likedUser.appendChild(likedUser_image);

            const likedUser_UsernameAndName = document.createElement("div");
            likedUser_UsernameAndName.id = "likedUser_UsernameAndName";
            likedUser.appendChild(likedUser_UsernameAndName);

            const likedUser_username = document.createElement("span");
            likedUser_username.id = "likedUser_username";
            likedUser_username.innerText = account.username;
            likedUser_username.onclick = function () {
                location.href = "/profile/" + account.username;
            }
            likedUser_UsernameAndName.appendChild(likedUser_username);

            const likedUser_name = document.createElement("span");
            likedUser_name.id = "likedUser_name";
            likedUser_name.innerText = account.name;
            likedUser_UsernameAndName.appendChild(likedUser_name);

            var accountId = account.id;
            getFollowInfo(accountId, 1, likedUser);
        });
        document.getElementById("likeListPopupBackground").style.display = 'block';
    }).fail(function (error) {
        alert("에러 발생 (콘솔 확인)");
        console.log(error);
    })
}