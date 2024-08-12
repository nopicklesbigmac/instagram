<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<head>
    <title>가입하기 • Kimstagram</title>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            margin-top: 12px;
        }

        .InputForm { /* 입력 창 스타일 */
            width: 268px;
            height: 38px;
            background-color: #fafafa;
            margin: auto;
            display: block;
            /* 수직과 수평 정렬 */
            align-items: center;
            justify-content: center;
        }

        .Join { /* 가입 버튼 */
            width: 268px;
            height: 32px;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            color: #0095f6;
        }
        .Join span {
            position: relative;
            top: -2px;
            font-size: 14px;
            font-weight: bold;
        }

        ::placeholder { /* placeholder의 옵션 변경 */
            font-size: 12px;
        }
    </style>
</head>

<body>
    <!-- 첫 번째 큰 박스 -->
    <div id="OneBorder"; style="border:1px solid #dbdbdb; border-radius: 1px; width: 350px; text-align: center; padding: 40px; margin-bottom: 10px;">
        <a href="/"><img src="/image/logo_b.png" alt="kimstagram"></a>
        <div style="margin-bottom: 25px"></div>
        <span style="color: #737373; font-weight: bold; font-size: 16px;">친구들의 사진과 동영상을 보려면 가입하세요.</span>
        <div style="margin-bottom: 16px"></div>
        <a href="https://kimdevstudio.com"><img src="/image/join/facebook.png" id="facebookJoin" onmouseup="index.facebookJoinMouseUp()" onmousedown="index.facebookJoinClick()"/></a>

        <div style="text-align: center; margin-top: 26px; margin-bottom: 26px; position: relative;">
            <hr />
            <span style="font-size: 13px;font-weight: bold; color: #737373; background-color: #ffffff; padding: 0 16px; position: absolute; top: -10px; left: 50%; transform: translateX(-50%);">또는</span>
        </div>

        <!-- id, password, 로그인 -->
        <div class="form-group">
            <input id="email" type="text" class="form-control InputForm" placeholder="휴대폰 번호 또는 이메일 주소" style="margin-bottom: 6px;">
            <input id="name" type="text" class="form-control InputForm" placeholder="성명" style="margin-bottom: 6px;">
            <input id="username" type="text" class="form-control InputForm" placeholder="사용자 이름" style="margin-bottom: 6px;">
            <input id="password" type="password" class="form-control InputForm" placeholder="비밀번호" style="margin-bottom: 12px;">

            <div style="margin-bottom: 12px">
                <span style="font-size: 12px; color: #737373">저희 서비스를 이용하는 사람이 회원님의 연락처 정보를 Kimstagram에 업로드했을 수도 있습니다. <a href="https://kimdevstudio.com" style="text-decoration: none; color: #00376b">더 알아보기</a></span>
            </div>

            <button id="btn-join" class="btn btn-primary Join" style="width: 268px; height: 32px;" disabled><span id="joinText">가입</span></button>
        </div>
    </div>

    <!-- 두 번째 작은 박스 -->
    <div style="border: 1px solid #dbdbdb; border-radius: 1px; width: 350px; height: 70px; text-align: center; display: flex; flex-direction: column; align-items: center; justify-content: center;">
        <span style="font-size: 14px">계정이 있으신가요? <a href="/" style="font-weight: bold; text-decoration: none;"><span>로그인</span></a></span>
    </div>

    <div style="margin-bottom: 15px"></div>

    <!-- 앱 다운 -->
    <div style="width: 350px; text-align: center; display: flex; flex-direction: column; align-items: center; justify-content: center;">
        <span style="font-size: 14px; margin-bottom: 15px;">앱을 다운로드하세요.</span>
        <div style="display: flex; gap: 6px;">
            <a href="https://play.google.com/store/apps/details?id=com.instagram.android&referrer=ig_mid%3DEF8F2770-AB79-45DE-B81E-EBC88B711668%26utm_campaign%3DloginPage%26utm_content%3Dlo%26utm_source%3Dinstagramweb%26utm_medium%3Dbadge%26original_referrer%3Dhttps://www.google.com/&pli=1"><img src="/image/login/download_google.png"/></a>
            <a href="ms-windows-store://pdp/?productid=9nblggh5l9xt&referrer=appbadge&source=www.instagram.com&mode=mini&pos=-7%2C0%2C974%2C1047"><img src="/image/login/download_microsoft.png"/></a>
        </div>
    </div>
</body>

<footer>
    <%@ include file="../layout/footer.jsp"%>
</footer>

<script src="/js/join.js"></script>