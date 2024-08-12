<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>


<head>
    <title>instagram</title>
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
        .IdAndPwd { /* id와 password 입력창 스타일 */
            width: 268px;
            height: 38px;
            background-color: #fafafa;
            margin: auto;
            display: block;
            /* 수직과 수평 정렬 */
            align-items: center;
            justify-content: center;
        }

        .Login { /* 로그인 버튼 */
            width: 268px;
            height: 32px;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            color: #0095f6;
        }
        .Login span {
            position: relative;
            top: -2px;
            font-size: 14px;
            font-weight: bold;
        }

        hr {
            width: 268px;
            margin: auto;
        }

        ::placeholder { /* placeholder의 옵션 변경 */
            font-size: 12px;
        }
    </style>
</head>

<body>
<!-- 본격적인 로그인 폼 -->
<div class="container" style="margin: auto; margin-top: 48px">
    <div class="container" style="width: 100%; display: flex; flex-direction: row;">
        <div>
            <!-- 휴대폰 이미지 -->
            <div style="position: relative">
                <img src="/image/login/mobile.png" style="margin-right: 20px">
                <img src="/image/login/mobile_images/HUFS.jpg" style="position: absolute; top: 100px; left: 111px; width:250px; height: 400px;">
            </div>
        </div>
        <div>
            <!-- 첫 번째 큰 박스 -->
            <div id="OneBorder"; style="border:1px solid #dbdbdb; border-radius: 1px; width: 350px; text-align: center;">
                <div style="margin-bottom: 45px"></div>
                <a href="/"><img src="./image/logo_b.png" alt="instagram"></a>
                <div style="margin-bottom: 45px"></div>
                <!-- id, password, 로그인 -->
                <div class="form-group">
                    <input id="username" type="text" class="form-control IdAndPwd" placeholder="전화번호, 사용자 이름 또는 이메일" style="margin-bottom: 6px;">
                    <input id="password" type="password" class="form-control IdAndPwd" placeholder="비밀번호" style="margin-bottom: 12px;" onkeydown="keyHandler(event)">
                    <button id="btn-login" class="btn btn-primary Login" disabled><span id="loginText">로그인</span></button>

                    <div style="text-align: center; margin-top: 20px; margin-bottom: 30px; position: relative;">
                        <hr />
                        <span style="font-size: 13px;font-weight: bold; color: #737373; background-color: #ffffff; padding: 0 16px; position: absolute; top: -10px; left: 50%; transform: translateX(-50%);">또는</span>
                    </div>

                    <!-- 페이스북 로그인 버튼 -->
                    <a href="/oauth2/authorization/facebook"><img src="/image/login/log_fc.png" id="facebookButton" onmousedown="index.facebookClick()"/></a>
                    <div style="margin-bottom: 16px"></div>

                    <div id="ErrorMessageBox" style="margin-bottom: 20px"></div>

                    <!-- 비밀번호 찾기 -->
                    <div style="margin-bottom: 19px">
                        <a href="https://kimdevstudio.com" style="text-decoration: none; color: #00376b;"><span style="font-size: 12px" onmousedown="this.style.color='#7f9bb5'" onmouseup="this.style.color='#00376b'">비밀번호를 잊으셨나요?</span></a>
                    </div>
                </div>
            </div>

            <div style="margin-bottom: 10px"></div>

            <!-- 두 번째 작은 박스 -->
            <div style="border: 1px solid #dbdbdb; border-radius: 1px; width: 350px; height: 63px; text-align: center; display: flex; flex-direction: column; align-items: center; justify-content: center;">
                <span style="font-size: 14px">계정이 없으신가요? <a href="join" style="font-weight: bold; text-decoration: none;"><span>가입하기</span></a></span>
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
        </div>
    </div>
</div>
</body>

<footer>
    <%@ include file="../layout/footer.jsp"%>
</footer>

<script src="/js/login.js"></script>