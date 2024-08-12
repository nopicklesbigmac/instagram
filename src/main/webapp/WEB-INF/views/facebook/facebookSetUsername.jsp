<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
    <%@ include file="../../layout/indexHeader.jsp"%>

    <style>
        #button {
            width: 100px;
            height: 30px;
            text-align: center;
            padding-top: 1px;
            background-color: #0095f6;
            border: 1px solid #ededed;
            color: white;
            cursor: pointer;
        }
        #button:hover {
            background-color: #1877f2;
        }
        #button:active {
            background-color: #4cb5f9;
        }
    </style>
</head>

<body>
    <div style="width: 100%; height: 50%; display: flex; flex-direction: column; justify-content: center; align-items: center">
        <div style="font-size: 26px; font-weight: bold">
            아이디 설정
        </div>
        <div style="margin-bottom: 20px">
            kimstagram에서 사용할 아이디를 입력해 주세요.
        </div>
        <input id="input" style="width: 300px; margin-bottom: 10px">
        <div id="button" onclick="setUsername('${oriusername}')">
            확인
        </div>

        <div id="using" style="display: none; color: #ed4956; margin-top: 30px">
            이미 사용 중인 아이디입니다.
        </div>
    </div>
</body>


<script src="/js/facebookSetUsername.js"></script>