<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html style="height: 920px">
<%@ include file="../../layout/menu.jsp"%>
<head>
<link href="../css/dm.css" rel="stylesheet" />

<link href="https://fonts.googleapis.com/css?family=Raleway"
	rel="stylesheet" />
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet" />
	 <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<!-- <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.css"
    /> -->

</head>
<body>
	<div class="main-section">
		<div class="head-section">
			<div class="headLeft-section">
				<div class="headLeft-sub">
					<div style="height:16px;"></div>
					<input type="text" name="search"id="search-input" placeholder="Search..." onkeyup="send()"/>
					
					<button id="search-btn" onclick="send()">
						<i class="fa fa-search"></i>
					</button>
					<ul id="search_list">
					
					</ul>
				</div>
			</div>
			<div class="headRight-sub" >
			<c:if test="${not empty receiverinfo}">
					<img style="margin:10px; float:left; width: 40px; height: 40px;" src="/image/profile/default.jpg" />
					<h3 style="margin-top:17px; margin-left:50px;">
					${receiverinfo.name} ${'@'+= receiverinfo.username}	
						
					</h3>
				</c:if>
				</div>
		</div>
		<div class="body-section">
			<div class="left-section mCustomScrollbar" id="f7Bj3"
				data-mcs-theme="minimal-dark">
				<ul>
				<c:forEach var="left_msg" items="${left_msg}" varStatus="status">
								<c:choose>
								<c:when test="${left_msg.sender_username eq sessionScope.username}">
									<c:set var="receiver_left" value="${left_msg.receiver_username}"></c:set>
								</c:when>
								<c:otherwise> 
									<c:set var="receiver_left" value="${left_msg.sender_username}"></c:set>
								</c:otherwise>
								</c:choose>
					<li class="msg_rcv" value="${receiver_left}">
						<div class="chatList">
							<div class="img">
								<!--접속중 표시 <i class="fa fa-circle"></i> -->
							
								<img src="/image/profile/default.jpg" />
							</div>
							<div class="desc">
								<small class="time">
								<fmt:formatDate value="${left_msg.timestamp}" pattern="hh:mm" /> 
								<fmt:formatDate value="${left_msg.timestamp}" pattern="a" var="fdate" />
								<c:if test="${fdate eq '오후'}">pm</c:if>
								<c:if test="${fdate eq '오전'}">am</c:if>
								</small>
								<h5>
								${receiver_left}
								</h5>
								<small>${left_msg.content}</small>
							</div>
						</div>
					</li>
				</c:forEach>

				</ul>
			</div>
			<div class="right-section">
				<div class="message mCustomScrollbar" data-mcs-theme="minimal-dark">
					<ul class="msg-ul" id="msg-ul">
						
						<c:forEach var="message" items="${messages}" varStatus="status">
						<c:set var="before" value="${messages[status.index - 1]} }"/>
						
						<c:if test="${receiver eq message.sender_username || receiver eq message.receiver_username}">
							<fmt:formatDate value="${messages[status.index - 1].timestamp}" pattern="yyyy-MM-dd" var="y-day" />
							<fmt:formatDate value="${message.timestamp}" pattern="yyyy-MM-dd" var="x-day" />
							<c:if
								test="${status.first ||(x-day != y-day && status.count > 1)}">
								<li class="msg-day">
									<small>
										<fmt:formatDate value="${message.timestamp}" pattern="yyyy-MM-dd" />
									</small>
								</li>
							</c:if>
							<c:choose>
								<c:when test="${message.sender_username eq sessionScope.username}">
									<li class="msg-right">
								</c:when>
								<c:otherwise> 
									<li class="msg-left">
								</c:otherwise>
							</c:choose>
										<div class="msg-left-sub">
											<img src="/image/profile/default.jpg" />
											<div class="msg-desc">${message.content}</div>
											<small> 
											<fmt:formatDate value="${message.timestamp}" pattern="hh:mm" /> 
											<fmt:formatDate value="${message.timestamp}" pattern="a" var="fmtdate" />
												<c:if test="${fmtdate eq '오후'}">pm</c:if>
												<c:if test="${fmtdate eq '오전'}">am</c:if>
											</small>
										</div>
									</li>
									</c:if>
						</c:forEach>
						<li style="height: 5px;"></li>
					</ul>
				</div>
				<div class="right-section-bottom">
					<%-- <form action="/send?value=${receiver}" method="post"> --%>
						<input style="display: none;" type="text" id="sender" placeholder="Sender username" value="${sessionScope.username}" required>
						<input style="display: none;" type="text" id="receiver" placeholder="Receiver username" value="${receiverinfo.username}" required>
						<div class="upload-btn">
							<button class="btn">
								<i class="fa fa-photo"></i>
							</button>
							<input type="file" name="myfile" />
						</div>
						<input type="text" id="content" placeholder="type here..."
							required>
						<button type="submit" class="btn-send"  onclick="sendMessage()">
							<i class="fa fa-send"></i>
						</button>
					<!-- </form> -->
				</div>
			</div>
		</div>
	</div>
	
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
		const listItems = document.querySelectorAll('.msg_rcv'); // class로 선택

		listItems.forEach(function(item) {
			item.addEventListener('click', function() {
				const value = this.getAttribute('value'); // value 속성값 가져오기
				const url = `/direct?value=` + value; // URL 생성
				window.location.href = url; // URL로 이동

			});
		});

	});
	window.onload = function() {
		Scrollbarbottom()

	};
	function send() {
		req = new XMLHttpRequest();
		req.onreadystatechange = textChange;
		req.open('post', 'searchuser');
		req.send(document.getElementById('search-input').value);
	}
	function textChange() {
		if (req.readyState == 4 && req.status == 200) {
			try {
				var jsonDatas = JSON.parse(req.responseText);
				console.log(jsonDatas);
				var data = "";

				// 서버에서 전달된 u_name 값을 대체합니다.
				var u_name = '${sessionScope.username}'; // 이 부분이 올바르게 작동하는지 확인

				for (var i = 0; i < jsonDatas.cd.length; i++) {
					console.log(u_name);
					if (u_name != jsonDatas.cd[i].username) {
						data += "<li class=msg_rcv2 value='" + jsonDatas.cd[i].username + "'>";
						data += "<img src='/image/profile/default.jpg' />"
								+ jsonDatas.cd[i].username;
						data += "</li>";
						console.log(jsonDatas.cd[i].username);
					}
				}

				var tbody = document.getElementById('search_list');
				if (tbody) { // tbody가 null이 아닌지 확인
					tbody.innerHTML = data;
				} else {
					console.error("Element with ID 'search_list' not found.");
				}
				// 클릭 이벤트를 추가합니다.
				tbody.addEventListener('click', function(event) {
					// 클릭한 요소가 li인지 확인
					if (event.target.tagName === 'LI'
							|| event.target.closest('li')) {
						var item = event.target.tagName === 'LI' ? event.target
								: event.target.closest('li');
						const value2 = item.getAttribute('value'); // value 속성값 가져오기 // 알림으로 값 표시
						const url2 = `/direct?value=` + value2; // URL 생성
						window.location.href = url2; // URL로 이동
					}
				});
			} catch (e) {
				console.error("Parsing error:", e);
			}
		}
	}
	var stompClient = null;

	function connect() {
		var socket = new SockJS('/direct');
		stompClient = Stomp.over(socket);
		stompClient.connect({}, function(frame) {
			console.log('Connected: ' + frame);
			stompClient.subscribe('/topic/messages', function(message) {
				const parsedMessage = JSON.parse(message.body);
				console.log("수신된 메시지:", parsedMessage);
				showMessage(parsedMessage);
			});
		}, function(error) {
			console.error('Error connecting to WebSocket:', error); // 연결 오류 로그
		});
	}

	function sendMessage() {
		const message = {
			sender_username : document.getElementById('sender').value,
			receiver_username : document.getElementById('receiver').value,
			content : document.getElementById('content').value
		};
		stompClient.send("/app/sendMessage", {}, JSON.stringify(message));
		document.getElementById('content').value = '';
	}

	function showMessage(message) {
		// 메세지 추가 
		const messagesDiv = document.getElementById('msg-ul'); // ul 요소를 선택
    	const receiver = document.getElementById('receiver').value; // 특정 리시버의 이름을 설정
         const lastItem = messagesDiv.lastElementChild; // 마지막 li 요소 선택

         if (lastItem) {
        	 messagesDiv.removeChild(lastItem); // 마지막 li 요소 삭제
         }
    // 메시지를 보낼 사용자 이름 또는 수신자 이름이 세션 사용자와 일치하는지 확인
    	if (receiver === message.sender_username || receiver === message.receiver_username) {
        // 새로운 li 요소 생성
        let listItem = document.createElement('li');
/* 
        // 메시지의 타임스탬프를 기반으로 날짜 표시
        const messageDate = new Date(message.timestamp);
        const today = new Date();

        // 날짜가 오늘인 경우에만 날짜를 표시
        if (messageDate.toDateString() === today.toDateString()) {
            listItem.classList.add('msg-day');
            listItem.innerHTML = `<small><fmt:formatDate value="${message.timestamp}" pattern="yyyy-MM-dd" /></small>`;
            messagesDiv.appendChild(listItem);
        } */

        // 메시지 방향에 따라 클래스 추가
        console.log("저장된 사용자 이름:", sessionStorage.getItem("username"));
console.log("메시지 보낸 사람:", message.sender_username);
const sender = document.getElementById('sender').value
        if (message.sender_username === sender) {
            listItem.classList.add('msg-right');
        } else {
            listItem.classList.add('msg-left');
        }

        // 메시지 내용 추가
        listItem.innerHTML += "<div class='msg-left-sub'>";
    listItem.innerHTML += "<img src='/image/profile/default.jpg' />";
    listItem.innerHTML += "<div class='msg-desc'>" + message.content + "</div>";
    
    // 시간 포맷팅
    const timeFormatted = formatDate(message.timestamp, 'hh:mm');
    const amPm = formatDate(message.timestamp, 'a') === '오후' ? 'pm' : 'am';
    
    listItem.innerHTML += "<small>" + timeFormatted + " " + amPm + "</small>";
    listItem.innerHTML += "</div>";

        // 완성된 listItem을 messagesDiv에 추가
        messagesDiv.appendChild(listItem);
        const newItem = document.createElement('li');
        newItem.style.height = '5px'; // 높이 5px 설정
        messagesDiv.appendChild(newItem);
        Scrollbarbottom()
    }
	}
	
	function Scrollbarbottom(){
		var chatContainers = document
		.getElementsByClassName('message mCustomScrollbar'); // 클래스 선택
if (chatContainers.length > 0) {
	var chatContainer = chatContainers[0]; // 첫 번째 요소 선택
	chatContainer.scrollTop = chatContainer.scrollHeight;

	var button = document.getElementById('search-btn');
	button.onclick = send();
}
	}
	
	function formatDate(timestamp, format) {
	    const date = new Date(timestamp);
	    let hours = date.getHours();
	    let minutes = date.getMinutes();

	    // 12시간 형식으로 변환
	    if (format === 'hh:mm') {
	        hours = hours % 12 || 12; // 0을 12로 변환
	        return (hours < 10 ? '0' : '') + hours + ':' + (minutes < 10 ? '0' : '') + minutes;
	    } else if (format === 'a') {
	        return date.getHours() >= 12 ? '오후' : '오전';
	    }
	    return '';
	}
	connect();
</script>
</body>
</html>