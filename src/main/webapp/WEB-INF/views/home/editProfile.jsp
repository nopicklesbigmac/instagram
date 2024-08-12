<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
    <%@ include file="../../layout/indexHeader.jsp"%>
    <%@ include file="../../layout/menu.jsp"%>
    <%@ include file="../getPrincipal.jsp"%>

    <style>
        body {
            margin-left: 74px;
            font-family: Arial;
        }

        #editProfileLable {
            width: 50%;
            min-width: 304px;
            max-width: 400px;
            font-weight: bold;
            font-size: 20px;
            margin-left: auto;
            margin-right: auto;
            margin-bottom: 36px;
        }

        #profile_info {
            width: 50%;
            height: 88px;
            min-width: 304px;
            max-width: 400px;
            border-radius: 20px;
            background-color: #efefef;
            margin-left: auto;
            margin-right: auto;
            display: flex;
            flex-direction: row;
            margin-bottom: 100px;
        }

        #profile_image {
            height: 88px;
            display: flex;
            align-items: center;
            margin-left: 18px;
            margin-right: 16px;
        }

        #profile_usernameBox {
            height: 88px;
            margin-top: 20px;
        }

        #profile_username {
            display: block;
            font-weight: bold;
            font-size: 16px;
        }

        #profile_name {
            font-size: 14px;
            color: #737373;
        }

        .profile_changeImgButton {
            width: 96px;
            height: 32px;
            cursor: pointer;
            background-color: #0095f6;
            font-weight: bold;
            border-radius: 8px;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-left: auto;
            margin-right: 16px;
            margin-top: 27px
        }
        .profile_changeImgButton:hover {
            background-color: #1877f2;
        }
        .profile_changeImgButton:active {
            background-color: #4cb5f9;
        }

        #profile_comment {
            width: 50%;
            height: 88px;
            min-width: 304px;
            max-width: 400px;
            margin-left: auto;
            margin-right: auto;
            display: flex;
            flex-direction: column;
            margin-bottom: 30px;
        }

        #commentBox {
            width: 100%;
            height: 62px;
            min-width: 304px;
            max-width: 400px;
            margin-left: auto;
            margin-right: auto;
        }

        #commentInput {
            width: 100%;
            height: 62px;
            min-width: 304px;
            max-width: 400px;
            border: 1px solid #dbdfe4;
            resize: none;
            border-radius: 14px;
            padding-top: 6px;
            padding-left: 10px;
            padding-right: 70px;
        }
        #commentInput:focus {
            border: 1px solid black;
            outline: none;
        }

        #charCount {
            font-size: 12px;
            color: #737373;
            position: absolute;
            top: 60%;
            right: 6%;
        }

        #Savearea {
            width: 50%;
            height: 44px;
            min-width: 304px;
            max-width: 400px;
            margin-top: 100px;
            margin-left: auto;
            margin-right: auto;
            display: flex;
            align-items: center;
            justify-content: right;
        }

        #profile_save {
            width: 253px;
            height: 44px;
            background-color: #0095f6;
            color: white;
            font-weight: bold;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }
        #profile_save:hover {
            background-color: #1877f2;
        }
        #profile_save:active {
            background-color: #4cb5f9;
        }

        .uploadedImage {
            width: 56px;
            height: 56px;
            border-radius: 50%;
            border: 1px solid #dbdbdb;
        }

    </style>
</head>

<body>
    <div id="Contents" style="width: 100%; height: 100%; padding: 50px;">
        <div id="editProfileLable">프로필 편집</div>

        <div id="profile_info">
            <div id="profile_image"></div>
            <div id="profile_usernameBox">
                <span id="profile_username"></span>
                <span id="profile_name"></span>
            </div>
            <input type="file" accept="image/*" id="imageFile" style="display: none" onchange="changeImage(event)">
            <label for="imageFile" class="profile_changeImgButton">
                사진 변경
            </label>
        </div>

        <div id="profile_comment">
            <div style="font-size: 16px; font-weight: bold; margin-bottom: 10px"> 소개</div>
            <div id="commentBox" style="position: relative">
                <textarea id="commentInput" placeholder="소개" oninput="checkMaxLength()"></textarea>
                <div id="charCount">0 / 150</div>
            </div>
        </div>

        <div id="Savearea">
            <div id="profile_save" onclick="profile_save()">제출</div>
        </div>
    </div>
</body>


<script src="/js/editProfile.js"></script>