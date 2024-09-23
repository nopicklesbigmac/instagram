<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>

<!--	<%@ include file="../../layout/indexHeader.jsp"%>  -->

    <%@ include file="../../layout/menu.jsp"%>
    <%@ include file="../getPrincipal.jsp"%>

    <style>
        body {
            margin-left: 74px;
        }

        #recommendForyouLable {
            width: 90%;
            min-width: 600px;
            max-width: 600px;
            font-weight: bold;
            font-size: 16px;
            margin-left: auto;
            margin-right: auto;
            margin-bottom: 36px;
        }

        #index_accountBox {
            width: 90%;
            min-width: 600px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
            display: flex;
            flex-direction: column;
            overflow: auto;
        }

        #Contents {
            width: 100%;
            height: 100%;
            padding: 50px;
        }

        .index_account {
            display: flex;
            flex-direction: row;
            margin-bottom: 16px;
        }

        #index_profileImg {
            border: 1px solid #dbdbdb;
            border-radius: 50%;
            width: 44px;
            height: 44px;
            margin-right: 10px;
            cursor: pointer;
        }

        #index_account_names {
            width: 90%;
            max-width: 500px;
            display: flex;
            flex-direction: column;
            margin-top: -4px;
        }

        .index_account_followButton {
            width: 82px;
            height: 32px;
            margin-top: 11px;
            background-color: #0095f6;
            border-radius: 6px;
            font-size: 14px;
            font-weight: bold;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer
        }
        .index_account_followButton:hover {
            background-color: #1877f2;
        }
        .index_account_followButton:active {
            background-color: #4cb5f9;
        }

        .index_account_unFollowButton {
            width: 82px;
            height: 32px;
            margin-top: 11px;
            color: black;
            background-color: #efefef;
            border-radius: 6px;
            font-size: 14px;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer
        }
        .index_account_unFollowButton:hover {
            background-color: #dbdbdb;
        }
        .index_account_unFollowButton:active {
            background-color: #e6e6e6;
            color: #4c4c4c;
        }

        #unfollowPopupBackground {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.65);
            display: none;
        }

        #unfollowPopup {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 100%;
            height: 50%;
            max-width: 400px;
            max-height: 290px;
            border-radius: 12px;
            background-color: white;
        }

        .unfollowPopupButtons {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            cursor: pointer;
        }

        #unfollowPopupInfo {
            height: 184px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        #unfollowPopupInfoImg {
            width: 90px;
            height: 90px;
            border: 1px solid #ededed;
            border-radius: 50%;
            margin-top: 20px;
            margin-bottom: 30px;
        }

        #likeListPopupBackground {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.65);
            display: none;
        }

        #likeListPopup {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 400px;
            height: 400px;
            border-radius: 12px;
            background-color: white;
        }

        .buttons {
            width: 40px;
            height: 40px;
            cursor: pointer;
            border-radius: 16px;
            font-size: 26px;
            text-align: center;
            line-height: 40px;
            margin-right: 4px;
        }
        .buttons:hover {
            font-size: 29px;
        }
        .buttons:active {
            font-size: 23px;
        }

        #replySpan {
            position: absolute;
            top: 0;
            right: 0;
            margin-top: 2px;
            padding-right: 10px;
            color: #0095f6;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
        }
        #replySpan:hover {
            color: #1877f2;
        }
        #replySpan:active {
            color: #4cb5f9;
        }

        #indexpost_likes {
            margin-top: 6px;
            margin-right: auto;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }
        #indexpost_likes:active {
            color: #939393;
        }

        #indexpost_username {
            margin-right: 4px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }
        #indexpost_username:active {
            color: #939393;
        }

        #indexpost_comment {
            margin-top: 6px;
            margin-right: 4px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }
        #indexpost_comment:hover {
            color: #939393;
        }
        #indexpost_comment:active {
            color: #939393;
        }

        #indexpost_commentspan {
            margin-top: 6px;
            font-size: 14px;
        }

        #indexpost_viewReplies {
            margin-top: 2px;
            margin-right: auto;
            font-size: 14px;
            color: #737373;
            cursor: pointer;
        }
        #indexpost_viewReplies:active {
            color: #b9b9b9;
        }

        .likedUser {
            padding: 8px 16px;
            display: flex;
            flex-direction: row;
        }

        #likedUser_image {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            border: 1px solid #ededed;
            margin-right: 12px;
            cursor: pointer;
        }

        #likedUser_UsernameAndName {
            display: flex;
            flex-direction: column;
        }

        #likedUser_username {
            font-size: 14px;
            font-weight: bold;
            margin-bottom: -2px;
            cursor: pointer;
        }
        #likedUser_username:active {
            color: #969696;
        }

        #likedUser_name {
            font-size: 14px;
            color: #737373;
        }

        #likedUser_buttonDiv {
            margin-left: auto;
            margin-top: 6px;
        }
 
        #likedUser_followButton {
            width: 82px;
            height: 32px;
            border-radius: 6px;
            color: white;
            font-weight: bold;
            background-color: #0095f6;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
        }
        #likedUser_followButton:hover {
            background-color: #1877f2;
        }
        #likedUser_followButton:active {
            background-color: #4cb5f9;
        }

        #likedUser_unFollowButton {
            width: 82px;
            height: 32px;
            border-radius: 6px;
            color: black;
            font-weight: bold;
            background-color: #efefef;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
        }
        #likedUser_unFollowButton:hover {
            background-color: #dbdbdb;
        }
        #likedUser_unFollowButton:active {
            background-color: #e6e6e6;
            color: #4c4c4c;
        }

        .imagePrevNextButton {
            display: flex;
            align-items: center;
            justify-content: center;
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
            line-height: 90px;
            text-align: center;
        }
        .imagePrevNextButton:hover {
            background-color: black;
        }
        .imagePrevNextButton:active {
            font-size: 20px;
        }

        ::placeholder {
            font-size: 14px;
        }

    </style>
</head>

<script src="/js/indexTop.js"></script>

<body>
    <div id="Contents">

        <!----- 팔로우 중인 유저가 없는 경우 -----> 
        <div id="NoFollowing" style="display: none">
            <div id="recommendForyouLable">회원님을 위한 추천</div>
            <div id="index_accountBox">
                <c:forEach var="accounts" items="${NoFollowingAccounts}">
                    
                    <%
                        // 세션에서 사용자 정보 가져오기
                        String sessionId = (String) session.getAttribute("email");
                        String sessionUsername = (String) session.getAttribute("username");
                        String sessionName = (String) session.getAttribute("name");
                        String sessionProfileImg = (String) session.getAttribute("Profile_img");
                    %>

                    <script>
                        // JavaScript에서 세션 정보를 사용하기 위해 JSP 변수를 JS 변수에 할당
                        var sessionEmail = "<%= sessionId %>";
                        var sessionUsername = "<%= sessionUsername %>";
                        var sessionName = "<%= sessionName %>";
                        var sessionProfileImg = "<%= sessionProfileImg %>";
                        
                        console.log("Session Email: " + sessionEmail);
                        console.log("Session Username: " + sessionUsername);
                        console.log("Session Name: " + sessionName);
                        console.log("Session Profile Image: " + sessionProfileImg);

                        // addDivs 함수에 세션 정보를 넘겨 호출
                        addDivs(sessionEmail, sessionUsername, sessionName, sessionProfileImg);
                    </script>

                </c:forEach>
            </div>

            <script>
                this.getFollowings();
            </script>
        </div>

        <!----- 팔로우 중인 유저가 있는 경우 -----> 
        <div id="FollowingContents" style="display: flex; flex-direction: column; justify-content: center; align-items: center">
            <script>
                this.addPosts(); // 팔로우 중인 사용자의 게시물 표시
            </script>
        </div>
    </div>

    <!-- 좋아요 목록 팝업 -->
    <div id="likeListPopupBackground" onclick="onclickLikeListPopupCancel()">
        <div id="likeListPopup" onclick="event.stopPropagation();">
            <div id="likeListPopupTitle" style="height: 44px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #dbdbdb">
                <div style="flex-grow: 1; text-align: center; margin-left: 46px">
                    <span style="font-weight: bold">좋아요</span>
                </div>
                <div style="margin-top: -8px; cursor: pointer" onclick="onclickLikeListPopupCancel()">
                    <span style="margin-right: 12px; font-size: 36px">×</span>
                </div>
            </div>

            <div style="">
                <div id="likedUserList" style="width: 400px; height: 356px; overflow: auto; overflow-x: hidden">
                </div>
            </div>
        </div>
    </div>

    <!-- 언팔로우 팝업 -->
    <div id="unfollowPopupBackground" onclick="onclickPopupCancel()">
        <div id="unfollowPopup">
            <div id="unfollowPopupInfo">
                <img id="unfollowPopupInfoImg" src="/dynamicImage/profile/default.jpg">
                <span id="unfollowPopupSpan" style="font-size: 14px"></span>
            </div>
            <hr />
            <div id="optionUnfollow" class="unfollowPopupButtons" style="height: 5%; color: #ed4956; font-weight: bold">
                팔로우 취소
            </div>
            <hr />
            <div id="optionCancel" class="unfollowPopupButtons" style="height: 3%" onclick="onclickPopupCancel()">
                취소
            </div>
        </div>
    </div>
</body>

<script>
    // 팔로우 상태 확인 AJAX 요청 및 버튼 추가
    function getFollowings() {
        $.ajax({
            type: "GET",
            url: "/getFollowInfo",
            data: {
                fromaccountId: sessionEmail,
                toaccountId: profileUserEmail // 팔로우 대상자의 이메일
            },
            success: function (response) {
                if (response === 1) {
                    // 팔로우 중인 경우
                    $('#followOrUnfollow').append('<button id="unfollowButton" class="profileButton" style="width: 82px; height: 32px; margin-left: 20px" onclick="onclickUnfollow(\'' + sessionEmail + '\', \'' + profileUserEmail + '\')">팔로잉</button>');
                } else {
                    // 팔로우하지 않은 경우
                    $('#followOrUnfollow').append('<button id="followButton" class="followButton" style="width: 82px; height: 32px; margin-left: 20px" onclick="onclickFollow(\'' + sessionEmail + '\', \'' + profileUserEmail + '\')">팔로우</button>');
                }
            },
            error: function (error) {
                console.error("팔로우 상태 확인 실패", error);
            }
        });
    }

    // 팔로우 버튼 클릭 시 호출되는 함수
    function onclickFollow(fromaccountId, toaccountId) {
        let data = {
            fromaccountId: fromaccountId,
            toaccountId: toaccountId
        };

        $.ajax({
            type: "POST",
            url: "/follow",
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8",
            success: function () {
                // 버튼을 '팔로잉'으로 변경
                $('#followOrUnfollow').empty();
                $('#followOrUnfollow').append('<button id="unfollowButton" class="profileButton" style="width: 82px; height: 32px; margin-left: 20px" onclick="onclickUnfollow(\'' + fromaccountId + '\', \'' + toaccountId + '\')">팔로잉</button>');
            },
            error: function (error) {
                console.error("팔로우 실패", error);
            }
        });
    }

    // 언팔로우 버튼 클릭 시 호출되는 함수
    function onclickUnfollow(fromaccountId, toaccountId) {
        let data = {
            fromaccountId: fromaccountId,
            toaccountId: toaccountId
        };

        $.ajax({
            type: "DELETE",
            url: "/unfollow",
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8",
            success: function () {
                // 버튼을 '팔로우'로 변경
                $('#followOrUnfollow').empty();
                $('#followOrUnfollow').append('<button id="followButton" class="followButton" style="width: 82px; height: 32px; margin-left: 20px" onclick="onclickFollow(\'' + fromaccountId + '\', \'' + toaccountId + '\')">팔로우</button>');
            },
            error: function (error) {
                console.error("언팔로우 실패", error);
            }
        });
    }
</script>

<script src="/js/indexBottom.js"></script>