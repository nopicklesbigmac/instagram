<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
    <%@ include file="../../layout/indexHeader.jsp"%>
    <%@ include file="../../layout/menu.jsp"%>
    <%@ include file="../getPrincipal.jsp"%>

    <style>
        .profileButton {
            color: black;
            font-size: 14px;
            font-weight: bold;
            background-color: #efefef;
            border: 0px;
            border-radius: 8px;
        }
        .profileButton:hover {
            background-color: #dbdbdb;
            border: 0px;
        }
        .profileButton:active {
            background-color: #ededed;
            color: #7f7f7f;
            border: 0px;
        }

        .followButton {
            background-color: #0095f6;
            color: white;
            font-weight: bold;
            border: 0px;
            border-radius: 8px;
            font-size: 14px;
        }
        .followButton:hover {
            background-color: #1877f2;
            border: 0px;
        }
        .followButton:active {
            background-color: #4cb5f9;
            border: 0px;
        }

        .middleboxButton {
            width: 138px;
            height: 52px;
        }

        .post {
            position: absolute;
            width: 30%;
            height: 150px;
            margin: 10px;
        }

        .optionPopupBackground {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.65);
            display: none
        }

        .optionPopup {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 100%;
            height: 100%;
            max-width: 400px;
            max-height: 384px;
            border-radius: 12px;
            background-color: white;
        }

        .optionButtons {
            width: 100%;
            height: 46%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            cursor: pointer;
        }

    </style>
</head>

<body style="margin-left: 74px">
    <div id="profilePage" style="padding-top: 30px; padding-left: 20px; width: 100%; height: 100%; display: flex; flex-direction: column; align-items: center;">
        <!-- 위쪽 프로필 설명들 -->
        
        <div id="debug-info" style="background-color: #f9f9f9; padding: 10px; margin-bottom: 20px;">
            <h3>Debug Info:</h3>
            <p>Session Email: <%= session.getAttribute("email") %></p>
            <p>User Email: ${user.email}</p>
            <p>Comparison Result: ${sessionScope.email eq user.email}</p>
        </div>
        
        <div id="profile-upperbox" style="display: flex">
            <div id="profile_img_div" style="padding-right: 44px">
                <!-- <img src="<%= session.getAttribute("Profile_img") %>" width="150px" height="150px" style="border-radius: 50%; border: 2px solid #dbdbdb"> <!-- 수정 --> -->
                <img src="${sessionScope.Profile_img}" width="150px" height="150px" style="border-radius: 50%; border: 2px solid #dbdbdb"> <!-- 수정 --> 
            </div>

            <div id="name_div">
                <div id="name_div_line1" style="display: flex; align-items: center;">
                    <span id="nameBox" style="font-size: 20px;"><%= session.getAttribute("username") %></span> <!-- 수정 -->
                    <div id="isMyProfile" style="display: flex; align-items: center;">
                        <!-- 사용자의 프로필인지 확인 -->
                        <c:if test="${sessionScope.email eq user.email}"> <!-- 자신의 프로필일 때 -->
                            <button id="editProfile" class="profileButton" style="width: 104px; height: 32px; margin-left: 16px" onclick="editProfile()">프로필 편집</button>
                            <button id="viewStory" class="profileButton" style="width: 150px; height: 32px; margin-left: 4px">보관된 스토리 보기</button>
                            <div id="optionButton" style="width: 40px; height: 40px; margin-left: 4px; cursor: pointer; display: flex; align-items: center; justify-content: center;" onclick="showOptionPopup()">
                                <img src="/image/profile/option.png">
                            </div>
                        </c:if>
                        <c:if test="${sessionScope.email ne user.email}"> <!-- 다른 사람의 프로필일 때 -->
                            <div id="followOrUnfollow"></div>
                            <button id="messageButton" class="profileButton" style="width: 120px; height: 32px; margin-left: 8px" onclick="sendDm(${user.email})">메시지 보내기</button>
                            <button id="recommendButton" class="profileButton" style="width: 34px; height: 32px; margin-left: 8px">
                                <img src="/dynamicImage/profile/recommend.png">
                            </button>
                            <button id="useroptionButton" style="background-color: white; border: 0px; width: 32px; height: 32px; margin-left: 16px">
                                <img src="/image/profile/useroption.png">
                            </button>
                        </c:if>
                    </div>
                </div>

                <div style="margin-bottom: 16px"></div>

                <div id="name_div_line2" style="margin-bottom: 20px">
                    게시물 <span style="font-weight: bold; margin-right: 30px">${posts.size()}</span>
                    팔로워 <span style="font-weight: bold; margin-right: 30px"><%= session.getAttribute("Follower") %></span> <!-- 수정 -->
                    팔로우 <span style="font-weight: bold;"><%= session.getAttribute("Following") %></span> <!-- 수정 -->
                </div>

                <div id="name_div_line3" style="margin-bottom: 50px">
                    <span style="font-size: 14px; font-weight: bold; margin-bottom: 10px; display: block"><%= session.getAttribute("name") %></span> <!-- 수정 -->
                    <span style="font-size: 14px;">${sessionScope.comment}</span>
                </div>
            </div>
        </div>
 		<div id="profile_middlebox" style="border-top: 1px solid #dbdbdb; width: 90%; padding-left: 30px; padding-right: 50px; display: flex; flex-direction: row; justify-content: center; align-items: center;">
            <div id="postsButton" class="middleboxButton" style="cursor: pointer; text-align: center; padding-top: 16px">
                <span style="font-size: 12px; font-weight: bold; color: #737373">게시물</span>
            </div>
            <div id="savedButton" class="middleboxButton" style="cursor: pointer; text-align: center; padding-top: 16px">
                <span style="font-size: 12px; font-weight: bold; color: #737373">저장됨</span>
            </div>
            <div id="taggedButton" class="middleboxButton" style="cursor: pointer; text-align: center; padding-top: 16px">
                <span style="font-size: 12px; font-weight: bold; color: #737373">태그됨</span>
            </div>
        </div>
        <!-- 프로필 포스트 박스 -->
       <div id="profile_postbox" style="width: 90%; height: 100%; padding-left: 30px; padding-right: 50px; display: flex; justify-content: center;">
            <c:choose>
                <c:when test="${posts.size() eq 0}">
                    <div id="NoPostsBox" style="margin-top: 50px; display: flex; flex-direction: column; align-items: center; text-align: center;">
                        <img src="/dynamicImage/profile/noPostsCamera.png" style="margin-bottom: 16px">
                        <span style="font-size: 30px; font-weight: bold; margin-bottom: 10px">사진 공유</span>
                        <span style="font-size: 14px; margin-bottom: 16px">사진을 공유하면 회원님의 프로필에 표시됩니다.</span>
                        <a href style="text-decoration: none;"><span style="color: #0095f6; font-weight: bold; font-size: 14px">첫 사진 공유하기</span></a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div id="postBox" style="width: 100%; max-width: 963px; display: flex; flex-wrap: wrap; justify-content: center">
                        <c:forEach var="post" items="${posts}">
                            <div id="tmpBox" style="width: 300px; height: 300px; margin: 10px; cursor: pointer" onclick="gotoPost('/post/${post.id}')">
                                <img class="post" src="/dynamicImage/posts/${post.id}/0.jpg" style="width: 290px; height: 290px">
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div id="optionPopupBackground" class="optionPopupBackground">
        <div id="optionPopup" class="optionPopup">
            <div id="optionLogout" class="optionButtons" style="height: 46%" onclick="optionLogout()">
                로그아웃
            </div>
            <hr />
            <div id="optionCancel" class="optionButtons" style="height: 50%" onclick="optionCancel()">
                취소
            </div>
        </div>
    </div>
</body>

<script src="/js/profile.js"></script>