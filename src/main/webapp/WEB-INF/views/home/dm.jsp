<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
    <%@ include file="../../layout/indexHeader.jsp"%>
    <%@ include file="../getPrincipal.jsp"%>

    <style>
        body {
            padding: 10px 0px;
            margin-left: 20%;
            margin-right: 20%;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        #chatDiv {
            height: 80%;
            width: 550px;
            border: 1px solid #b9b9b9;
            margin-bottom: 4px;
        }

        #userInfo {
            height: 60px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-bottom: 1px solid #b9b9b9;
            cursor: pointer;
        }

        #userInfo_img {
            width: 50px;
            height: 50px;
            border: 1px solid #ededed;
            border-radius: 50%;
        }

        #userInfo_username {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: -2px;
        }

        #userInfo_name {
            margin-top: -2px;
        }

        #chatMessages {
            height: 656px;
            padding: 20px 20px;
            overflow-y: auto;
            overflow-x: hidden;
            scroll-behavior: smooth;
        }

        #inputIdv {
            display: flex;
            flex-direction: row;
        }

        #input {
            width: 500px;
            border: 1px solid #b9b9b9;
        }

        #send {
            width: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #0095f6;
            font-weight: bold;
            cursor: pointer;
        }
        #send:hover {
            color: #1877f2;
            font-size: 17px;
        }
        #send:active {
            color: #4cb5f9;
            font-size: 16px;
        }

        .yourMsg {
            width: fit-content;
            padding: 10px 20px;
            background-color: #efefef;
            border-radius: 10px;
            font-size: 15px;
            margin-bottom: 10px;
        }

        .myMsg {
            width: fit-content;
            padding: 10px 20px;
            background-color: #3797f0;
            border-radius: 10px;
            font-size: 15px;
            color: white;
            margin-left: auto;
            margin-bottom: 10px;
        }
    </style>
</head>

<body>
    <div id="chatDiv">

        <div id="userInfo">
            <img id="userInfo_img">
            <div style="display: flex; flex-direction: column; margin-left: 10px">
                <span id="userInfo_username"></span>
                <span id="userInfo_name"></span>
            </div>
        </div>
        <script>
            document.getElementById('userInfo').onclick = function () {
                gotoProfile('${user.username}');
            }

            if ('${user.use_profile_img}' === '1') {
                document.getElementById('userInfo_img').src = "/dynamicImage/profile/" + '${user.username}' + "/profile.jpg";
            } else {
                document.getElementById('userInfo_img').src = "/dynamicImage/profile/default.jpg";
            }

            document.getElementById('userInfo_username').innerText = '${user.username}';
            document.getElementById('userInfo_name').innerText = '${user.name}';
        </script>

        <div id="chatMessages">
            <!-- 이전 채팅 메시지들 불러오기 -->
            <c:forEach var='message' items='${messages}'>
                <c:if test="${message.messageType eq 'CHAT'}">
                    <script>
                        var messageDiv = document.getElementById('chatMessages');

                        var newMsg = document.createElement('div');
                        if ('${message.who}' === '${whoisme}') {
                            newMsg.className = "myMsg";
                        } else {
                            newMsg.className = "yourMsg";
                        }
                        newMsg.innerText = '${message.message}';

                        messageDiv.append(newMsg);
                    </script>
                </c:if>
            </c:forEach>
            <script>
                var chatMessages = document.getElementById('chatMessages');
                chatMessages.scrollTop = chatMessages.scrollHeight;
            </script>
        </div>
    </div>

    <div id="inputIdv">
        <input id="input" onkeydown="keyHandler(event)">
        <div id="send" onclick="sendMsg()">전송</div>
    </div>
</body>


<script>
    ///////////////////////////////////////////////////////////////////
    // 소켓 설정

    // DM창에 들어오면 웹소켓을 시작한다.
    let socket = new WebSocket("ws://25.20.167.96:8000/ws/chat");

    // 세션이 소켓에 참여할 때
    socket.onopen = function () {
        var enterMsg = {
            "messageType": "ENTER",
            "roomId": '${room.id}',
            "who": '${whoisme}',
            "message": ""
        }
        socket.send(JSON.stringify(enterMsg)); // 웹소켓은 메시지를 JSON 형태로 주고 받으니, JSON 형태로 변환해서 접속 메시지를 보낸다
    }

    // 소켓에 오류가 날 때
    socket.onerror = function (error) {
        console.log(error)
    }

    // 소켓에 메시지가 도착했을 때
    socket.onmessage = function (e) {
        parsedMsg = JSON.parse(e.data);

        var messageDiv = document.getElementById('chatMessages');

        let newMsg = document.createElement('div');
        if (parsedMsg.who === '${whoisme}') {
            newMsg.className = "myMsg";
        } else {
           newMsg.className = "yourMsg";
        }
        newMsg.innerText=parsedMsg.message;

        messageDiv.append(newMsg);
        scrollToBottom();

        $.ajax({
            type: "POST",
            url: "/saveDmMessage",
            data: parsedMsg,
            contentType: "application/json; charset=utf-8",
        });
    }

    // 페이지를 나가면 소켓을 종료한다.
    window.addEventListener('beforeunload', () => {
        var quitMessage = {
            "messageType": "QUIT",
            "roomId": '${room.id}',
            "who": '${whoisme}',
            "message": ""
        }
        socket.send(JSON.stringify(quitMessage));

        socket.close();
    });

    var chatMessages = document.getElementById('chatMessages');
    function scrollToBottom() {
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }

    function gotoProfile(username) {
        location.href = "/profile/" + username;
    }

    function sendMsg() {
        var message = document.getElementById('input').value;
        if (message == "") {
            alert("메시지를 입력해 주세요.")
        } else {
            document.getElementById('input').value = "";

            var chatMessage = {
                "messageType": "CHAT",
                "roomId": '${room.id}',
                "who": '${whoisme}',
                "message": message
            }
            socket.send(JSON.stringify(chatMessage));
        }
    }

    function keyHandler(event) {
        if (event.key == 'Enter') { // Enter 키를 누르는 경우
            event.preventDefault(); // 기본 Enter 키 동작을 막는다.
            sendMsg(); // 'send' Div 클릭 시 작동하는 함수
        }
    }
</script>