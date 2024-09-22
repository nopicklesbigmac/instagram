<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.proj.instagram.post.PostDTO" %>


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

    <div id="post_id" style="display: none">${post.postId}</div>
</head>

<body style="margin-left: 74px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
    <% PostDTO post = (PostDTO) request.getAttribute("post"); %>

    <div id="post_idBox" class="post_idBox">
        <div id="profile_img_div" style="padding-right: 44px; cursor: pointer" onclick="gotoUserProfile('${post.email}')">
            <c:choose>
                <c:when test="${not empty post.imagePath}">
                    <img src="${user.use_profile_img}" class="profile">
                </c:when>
                <c:otherwise>
                    <img src="/image/profile/default.jpg" class="profile">
                </c:otherwise>
            </c:choose>
            <span id="post_username" style="margin-left: 10px; font-weight: bold; font-size: 26px">${post.username}</span>
        </div>
    </div>

    <div id="post_upperBox" class="post_upperBox">
        <div id="post_imagesBox" class="post_imagesBox">
            <div id="post_imageContainer">
                <img src="${post.imagePath}" style="max-width: 100%; height: auto; max-height: 800px;">
            </div>
            <div id="imagePrevButton" class="imagePrevNextButton" style="left: 10px">◀</div>
            <div id="imageNextButton" class="imagePrevNextButton" style="right: 10px">▶</div>
        </div>

        <div id="post_commentBox" class="post_commentBox">
            <div id="commentAndReply" style="height: 600px; border-bottom: 1px solid #dbdbdb; margin-bottom: 10px; overflow: auto">
                <div id="post_comment" style="margin-bottom: 20px">
                    <c:choose>
                        <c:when test="${not empty post.imagePath}">
                            <img src="${user.use_profile_img}" class="profileMini" style="cursor: pointer" onclick="gotoUserProfile('${post.email}')">
                        </c:when>
                        <c:otherwise>
                            <img src="/image/profile/default.jpg" class="profileMini" style="cursor: pointer" onclick="gotoUserProfile('${post.email}')">
                        </c:otherwise>
                    </c:choose>
                    <span style="font-weight: bold; font-size: 18px; cursor: pointer" onclick="gotoUserProfile('${post.email}')">${post.username}</span>
                    <span style="font-size: 18px; display: block; margin-top: 30px;">${post.content}</span> <!-- 'post.comment'에서 'post.content'로 변경 -->
                </div>

                <!-- 댓글 출력 -->
                <div id="post_replyBox">
                    <c:forEach var="reply" items="${replies}">
                        <div id="post_reply" style="margin-top: 10px">
                            <c:choose>
                                <c:when test="${not empty reply.imagePath}">
                                    <img src="/image/profile/${reply.email}/profile.jpg" class="profileMini" style="cursor: pointer" onclick="gotoUserProfile('${reply.email}')">
                                </c:when>
                                <c:otherwise>
                                    <img src="/image/profile/default.jpg" class="profileMini" style="cursor: pointer" onclick="gotoUserProfile('${reply.email}')">
                                </c:otherwise>
                            </c:choose>
                            <span style="font-weight: bold; font-size: 16px; cursor: pointer" onclick="gotoUserProfile('${reply.email}')">${reply.username}</span>
                            <span style="font-weight: normal">${reply.comment}</span>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</body>


<script src="/js/post.js"></script>
