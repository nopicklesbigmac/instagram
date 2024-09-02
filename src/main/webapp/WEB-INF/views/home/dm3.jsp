<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html
  xmlns:th="http://www.thymeleaf.org"
  xmlns:layout="http://www.ultraq.net.nz/web/thymeleaf/layout"
>
  <head th:replace="layout/header :: header"> </head>
  <body>
    <!-- chatTemplate ��ũ�� -->
    <link
      href="https://fonts.googleapis.com/css?family=Raleway"
      rel="stylesheet"
    />
    <link
      href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="/css/chattingStyle.css" />
    <!-- chatTemplate ��ũ�� -->

    <!-- stomp ���̺귯�� �߰� -->
    <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.0/sockjs.min.js"></script> -->
    <script src="/js/chatting.js"></script>

    <!-- stomp ���̺귯�� �߰� -->
    <nav th:replace="layout/header :: menu"></nav>

    <!-- ä�� ���� ���� -->
    <div class="main-section">
      <div class="head-section">
        <div class="headLeft-section">
          <div class="headLeft-sub">
            <form
              th:action="${SelectedUser} == null ? @{/chat} : @{|/chat/${SelectedUser.id}|}"
              method="GET"
            >
              <input
                type="text"
                id="searchInput"
                name="searchInput"
                placeholder="Search..."
                th:value="${param.searchInput}"
              />
              <button><i class="fa fa-search"></i></button>
            </form>
          </div>
        </div>
        <div class="headRight-section">
          <div class="headRight-sub">
            <h3
              th:text="${SelectedUser} == null ? 'DirectMessage' : ${SelectedUser.username}"
            >
              UserName Section
            </h3>
            <small
              th:text="${SelectedUser} == null ? '��ȭ��븦 �����ϼ���' : ${SelectedUser.email}"
              >User Email section</small
            >
          </div>
        </div>
      </div>

      <div class="body-section">
        <div
          class="left-section mCustomScrollbar"
          id="for-scroll"
          data-mcs-theme="minimal-dark"
        >
          <ul>
            <a
              th:each="AllUserList : ${AllUserList}"
              th:href="${param.searchInput} == null ? |/chat/${AllUserList.id}| : |/chat/${AllUserList.id}?searchInput=${param.searchInput}|"
              style="color: black"
            >
              <li
                th:classappend="(${SelectedUser} == null ? 0 : ${SelectedUser.id}) == ${AllUserList.id} ? active : ''"
              >
                <div class="chatList">
                  <div class="img">
                    <img th:src=|/upload/${AllUserList.profileImage}|
                    onerror="this.src='/images/avatar.jpg'" />
                  </div>
                  <div class="desc">
                    <!-- <small class="time">4 day</small> -->
                    <h5 th:text="${AllUserList.username}">Lajy Ion</h5>
                    <small th:text="${AllUserList.email}"
                      >Lorem ipsum dolor sit amet...</small
                    >
                  </div>
                </div>
              </li>
            </a>
          </ul>
        </div>

        <div class="right-section">
          <div
            class="message mCustomScrollbar"
            id="forscrolls"
            data-mcs-theme="minimal-dark"
          >
            <ul id="ChatSection" th:if="${MessageList} != null">
              <!-- <li class="msg-day"><small>Wednesday</small></li> -->

              <li
                th:each="MessageList : ${MessageList}"
                th:classappend="${MessageList.fromUser.id} == ${session.loginUser.id} ? 'msg-right' : 'msg-left'"
              >
                <div class="msg-left-sub">
                  <a th:href="|/user/${MessageList.fromUser.id}|">
                    <img
                      th:src="|/upload/${MessageList.fromUser.profileImage}|"
                      onerror="this.src='/images/avatar.jpg'"
                    />
                  </a>
                  <div class="msg-desc" th:text="${MessageList.message}">
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit,
                    sed do eiusmod tempor incididunt ut labore et dolore magna
                    aliqua.
                  </div>
                  <small
                    th:text="${#dates.format(MessageList.createDate, 'yyyy. MM. dd. a h:mm:ss')}"
                    >05:25 am</small
                  >
                  <!-- <small th:text="${MessageList.createDate}">05:25 am</small> -->
                </div>
              </li>
              <li class="msg-day" th:if="${MessageList.size()} > 0">
                <small>������� �����̽��ϴ�.</small>
              </li>
              <li class="msg-day" th:unless="${MessageList.size()} > 0">
                <small>��ȭ������ ���� �����ϴ�.</small>
              </li>
            </ul>
          </div>
          <div class="right-section-bottom">
            <div class="upload-btn">
              <button class="btn"><i class="fa fa-photo"></i></button>
              <input type="file" name="myfile" />
            </div>
            <input
              type="text"
              id="messageInput"
              name=""
              placeholder="type here..."
              onkeydown="JavaScript:Enter_Check();"
            />
            <button id="messageSendBtn" class="btn-send">
              <i class="fa fa-send"></i>
            </button>
          </div>
        </div>
      </div>
    </div>
    <!-- ä�ÿ��� �� -->

    <script th:inline="javascript">
        // LKH Ÿ�Ӹ��� ������ �ڹٽ�ũ��Ʈ ����Ҷ�
      // LKH backend �ܿ��� ���̳� ���ǿ� ����ص� ��ü�� �״�� ��밡���� �����

      //�Ʒ��� �ʱ�ȭ����
      /*<![CDATA[*/
      var SelectedUser = /*[[ ${SelectedUser} ]]*/;
      var LoginUser = /*[[ ${session.loginUser} ]]*/;
      const MessageInput = document.getElementById("messageInput");
      const MessageSendBtn = document.getElementById("messageSendBtn");
      var ClientSection = document.getElementById("forscrolls");

      if(SelectedUser != null){
        if(SelectedUser.username === LoginUser.username){
          alert("�ڽŰ��� ��ȭ �� �� �����ϴ�.");
          history.back();
        }
        ClientSection.scrollTop = ClientSection.scrollHeight;
      }

      /*]]*/

      //�Ʒ��� ��� ����
       MessageSendBtn.addEventListener("click", () => {
        if(MessageInput.value.trim() === ""){
            alert("ä���� �Է����ּ���.");
        }
        else if(SelectedUser === null){
            alert("��ȭ ��븦 �������ּ���.")
        }
        else{
          send(LoginUser.username, SelectedUser.username, MessageInput.value, true, "message");
          var data = MessageInput.value;
          chatSave(data, SelectedUser.id);
          //LKH ��ǲ�ڽ� ����ġ���� �ٽú���ֱ�
          MessageInput.value = "";
        }

      });
      // disconnectBtn.addEventListener("click", function () {
      //   disconnect(name.value);
      // });


       //��ǲ�ڽ� ����Ű �̺�Ʈ
       function Enter_Check(){
      // ����Ű�� �ڵ�� 13�Դϴ�.
        if(event.keyCode == 13){
            MessageSendBtn.click();
        }
      }

      //LKH �������� �κ�
      // function disconnect(name) {
      //   if (stompClient === null) {
      //     alert("�������� �ƴմϴ�.");
      //   } else {
      //     stompClient.disconnect(function () {
      //       alert("�������� �Ǿ����ϴ�.");
      //     });
      //   }
      // }

      function addDirectMessageLine(fromUser, toUser, msg, isMe) {
        var today = new Date();
        var date = today.toLocaleString();

        var FromUsertags = $("<li class=\"msg-right\"><div class=\"msg-left-sub\"><img src=\"/upload/" + LoginUser.imageUrl + "\" onerror=\"this.src='/images/avatar.jpg'\" /><div class=\"msg-desc\">"+ msg +"</div><small>"+date+"</small></div></li>");

        var ReceivedUsertags = $("<li class=\"msg-left\"><div class=\"msg-left-sub\"><img src=\"/upload/" + SelectedUser.profileImage + "\" onerror=\"this.src='/images/avatar.jpg'\" /><div class=\"msg-desc\">"+ msg +"</div><small>"+date+"</small></div></li>");


        if((fromUser === SelectedUser.username && !isMe) || isMe){
          $('#ChatSection').append(isMe ? FromUsertags : ReceivedUsertags);
        }

        //LKH ä�ý� ��ũ�� ������ ���� �κ�
        ClientSection.scrollTop = ClientSection.scrollHeight;
      }
    </script>
    <footer th:replace="layout/footer :: footer"></footer>
  </body>
</html>