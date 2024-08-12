<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
    <%@ include file="../../layout/indexHeader.jsp"%>
    <%@ include file="../../layout/menu.jsp"%>
    <%@ include file="../getPrincipal.jsp"%>

    <style>
        body {
            margin-left: 74px;
        }

        #Contents {
            position: relative;
            display: flex;
            justify-content: center;
        }

        #findDiv {
            position: absolute;
            top: 130px;
            width: 700px;
        }

        #findButton {
            width: 80px;
            margin-left: 10px;
            margin-right: 10px;
            color: #0095f6;
            cursor: pointer;
            font-weight: bold;
        }
        #findButton:hover {
            font-size: 17px;
            color: #1877f2;
        }
        #findButton:active {
            font-size: 16px;
            color: #4cb5f9;
        }

        #users {
            width: 700px;
            padding: 16px 20px;
            cursor: pointer;
            border-radius: 6px;
        }
        #users:hover {
            background-color: #f2f2f2;
        }
        #users:active {
            background-color: #fafafa;
        }

        #users_profileImg {
            width: 44px;
            height: 44px;
            border: 1px solid #ededed;
            border-radius: 50%;
            margin-right: 10px;
        }
    </style>
</head>

<body>
    <div id="Contents">
        <div id="findDiv">
            <div style="margin-right: auto; padding: 20px 0px">
                <span style="font-size: 26px; font-weight: bold">검색</span>
            </div>
            <div style="display: flex; flex-direction: row; margin-bottom: 20px">
                <input id="findInput" style="width: 600px; height: 36px; border: none; border-radius: 8px; background-color: #efefef" placeholder="  유저네임 입력" onkeydown="keyHandler(event)">
                <div id="findButton" style="width: 80px; margin-left: 10px; margin-right: 10px; display: flex;  align-items: center; justify-content: center" onclick="findUsers()">검색</div>
            </div>

            <div id="usersDiv" style="height:500px; overflow-y: auto; overflow-x: hidden">

            </div>
        </div>
    </div>
</body>

<script src="/js/find.js"></script>