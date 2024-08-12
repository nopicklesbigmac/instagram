<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
    <%@ include file="../../layout/indexHeader.jsp"%>
    <%@ include file="../../layout/menu.jsp"%>
    <%@ include file="../getPrincipal.jsp"%>

    <style>
        body {
            margin-left: 74px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-family: Arial;
        }

        .post_idBox {
            width: 100%;
            max-width: 1028px;
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: center;
            border-bottom: 1px solid #dbdbdb;
            padding-bottom: 6px;
            margin-top: 10px;
            margin-bottom: 10px;
        }

        .profile {
            border: 2px solid #dbdbdb;
            border-radius: 50%;
            width: 70px;
            height: 70px;
            max-width: 70px;
            max-height: 70px;
        }

        .profileMini {
            border: 1px solid #dbdbdb;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            max-width: 30px;
            max-height: 30px;
        }

        .post_upperBox {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .post_imagesBox {
            width: 50%;
            height: 800px;
            max-width: 512px;
            border: 1px solid #dbdbdb;
            margin: 2px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: black;
            position: relative;
        }

        .post_commentBox {
            width: 50%;
            height: 800px;
            max-width: 512px;
            border: 1px solid #dbdbdb;
            margin: 2px;
            padding: 20px;
        }

        .buttons {
            width: 40px;
            height: 40px;
            cursor: pointer;
            border-radius: 16px;
            font-size: 26px;
            text-align: center;
            line-height: 40px;
        }
        .buttons:hover {
            font-size: 29px;
        }
        .buttons:active {
            font-size: 23px;
        }

        .replyButton {
            width: 50px;
            height: 30px;
            border-radius: 10px;
            text-align: center;
            line-height: 30px;
            color: #0095f6;
            font-weight: bold;
            cursor: pointer;
        }
        .replyButton:hover {
            background-color: #ededed;
        }
        .replyButton:active {
            font-size: 15px;
            background-color: #ededed;
        }

        .imagePrevNextButton {
            color: white;
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            font-size: 24px;
            opacity: 0.3;
            cursor: pointer;
            border-radius: 10px;
            width: 40px;
            height: 100px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .imagePrevNextButton:hover {
            background-color: black;
        }
        .imagePrevNextButton:active {
            font-size: 20px;
        }

    </style>

    <div id="post_id" style="display: none">${post.id}</div>
    <div id="post_pic_size" style="display: none">${post.pic_size}</div>
</head>

<body style="margin-left: 74px; display: flex; flex-direction: column; align-items: center; justify-content: center;">

    <div id="post_idBox" class="post_idBox">
        <div id="profile_img_div" style="padding-right: 44px; cursor: pointer" onclick="gotoUserProfile('${post.account.username}')">
            <c:choose>
                <c:when test="${post.account.use_profile_img eq 1}">
                    <img src="/dynamicImage/profile/${post.account.username}/profile.jpg" class="profile">
                </c:when>
                <c:otherwise>
                    <img src="/dynamicImage/profile/default.jpg" class="profile">
                </c:otherwise>
            </c:choose>
            <span id="post_username" style="margin-left: 10px; font-weight: bold; font-size: 26px">${post.account.username}</span>
        </div>
    </div>

    <div id="post_upperBox" class="post_upperBox">
        <div id="post_imagesBox" class="post_imagesBox">
            <div id="post_imageConatiner"><img src="/dynamicImage/posts/${post.id}/0.jpg" style="max-width: 100%; height: auto; max-height: 800px;"></div>
            <div id="imagePrevButton" class="imagePrevNextButton" style="left: 10px">
                ◀
            </div>

            <div id="imageNextButton" class="imagePrevNextButton" style="right: 10px">
                ▶
            </div>
        </div>
        <div id="post_commentBox" class="post_commentBox">
            <div id="commentAndReply" style="height: 600px; border-bottom: 1px solid #dbdbdb; margin-bottom: 10px; overflow: auto">
                <div id="post_comment" style="margin-bottom: 20px">
                    <c:choose>
                        <c:when test="${post.account.use_profile_img eq 1}">
                            <img src="/dynamicImage/profile/${post.account.username}/profile.jpg" class="profileMini" style="cursor: pointer" onclick="gotoUserProfile('${post.account.username}')">
                        </c:when>
                        <c:otherwise>
                            <img src="/dynamicImage/profile/default.jpg" class="profileMini" style="cursor: pointer" onclick="gotoUserProfile('${post.account.username}')">
                        </c:otherwise>
                    </c:choose>
                    <span style="font-weight: bold; font-size: 18px; cursor: pointer" onclick="gotoUserProfile('${post.account.username}')">${post.account.username} </span><span style="font-size: 18px">${post.comment}</span>
                </div>
                <span></span>
                <!-- 댓글 출력 -->
                <div id="post_replyBox">
                    <c:forEach var="reply" items="${replies}">
                        <div id="post_reply" style="margin-top: 10px">
                            <c:choose>
                                <c:when test="${reply.account.use_profile_img eq 1}">
                                    <img src="/dynamicImage/profile/${reply.account.username}/profile.jpg" class="profileMini" style="cursor: pointer" onclick="gotoUserProfile('${reply.account.username}')">
                                </c:when>
                                <c:otherwise>
                                    <img src="/dynamicImage/profile/default.jpg" class="profileMini" style="cursor: pointer" onclick="gotoUserProfile('${reply.account.username}')">
                                </c:otherwise>
                            </c:choose>
                            <span style="font-weight: bold; font-size: 16px; cursor: pointer" onclick="gotoUserProfile('${reply.account.username}')">${reply.account.username} </span><span style="font-weight: normal">${reply.comment}</span>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div id="post_infoBox">
                <div id="post_infoBox_buttons" style="display: flex; flex-direction: row; margin-bottom: 4px">
                    <script>
                        $.ajax({
                        type: "GET",
                        url: "/getPrincipal",
                            headers: {'Authorization':localStorage.getItem('Authorization'),
                                'Refresh-Token':localStorage.getItem('Refresh-Token')},
                        contentType: "application/json; charset=utf-8",
                        }).done(function(resp) {
                            principal = resp;
                            var accountId = principal.id;
                            var postId = "${post.id}";
                            $.ajax({
                                type: "GET",
                                url: "/post/getLike?accountId=" + accountId + "&postId=" + postId,
                                contentType: "application/json; charset=utf-8"
                            }).done(function(resp) {
                                if (resp === 1) {
                                    document.getElementById('likeOrUnlike').innerHTML = '<div id="unLikeButton" class="buttons" onclick="Unlike()"><span>❤️</span></div>';
                                } else {
                                    document.getElementById('likeOrUnlike').innerHTML = '<div id="likeButton" class="buttons" onclick="Like()"><span>🤍</span></div>';
                                }
                            }).fail(function(error) {
                                console.log(JSON.stringify(error));
                            });
                        }).fail(function (resp) {
                        });
                    </script>
                    <div id="likeOrUnlike"></div>
                    <div id="messageButton" class="buttons"><span>💬</span></div>
                    <div id="shareButton" class="buttons"><span>🔗</span></div>
                </div>
                <div id="post_infoBox_likes" style="margin-bottom: 4px">
                    <span id="likeCounts" style="font-weight: bold; display: block">좋아요 ${post.likecount}개</span>
                    <span id="post_infoBox_likes_date" style="font-size: 14px; color: darkgray; display: block">${post.createDate}</span>
                </div>
                <div id="post_infoBox_replyBox" style="text-align: right;">
                    <input id="post_commentInput" style="width: 100%; margin-bottom: 2px">
                    <div style="width: 100%; display: flex; justify-content: right">
                        <div id="replyButton" class="replyButton" onclick="postReply(${post.id})">게시</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>

<script src="/js/post.js"></script>
