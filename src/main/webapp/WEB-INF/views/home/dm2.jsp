<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>

  <head>
<!--   
  	<script type="text/javascript">
  	async function chatSave(data, selectedUserId) {
  		let response = await fetch("/chatSave/" + selectedUserId, {
  			method: "post",
  			body: data,
  			headers: {
  				"Content-Type": "text/html"
  			}
  		}).then(function(res) {
  			return res.text();
  		}).then(function(res) {
  			//alert("채팅성공");
  		});



  		// let result = await response.text();
  		// if(result === "ok"){
  		// 	//location.reload();
  		// }
  	}
  	/*$(document).ready(function(){
  		$('.hangoverClass').hover(
  			function(){ $(this).li.addClass('active') },
  			function(){ $(this).li.removeClass('active') }
  		)
  	});*/
	</script>
	 -->
  <style>
body {
  font-family: "Raleway", sans-serif;
  /* background-color: #accedc; */
  background-color: white;
  margin: 50px 0px;
}
.main-section small {
  font-size: 12px;
}
.main-section h3,
.main-section h5 {
  margin: 0px;
}
.main-section {
  border: 1px solid #e6e6e6;
  margin: 80px auto;
  margin-bottom: 160px;
  margin-top: 120px;
  width: 960px;
  background-color: #fff;
  /* margin: auto; */
}
.head-section {
  border-bottom: 1px solid #e6e6e6;
  clear: both;
  overflow: hidden;
  width: 100%;
}
.headLeft-section {
  width: calc(30% - 1px);
  float: left;
  border-right: 1px solid #e6e6e6;
}
.headLeft-sub {
  padding: 15px;
  text-align: center;
}
.headLeft-sub input {
  width: 60%;
  border-radius: 0px;
  border: 1px solid #e6e6e6;
  padding: 7px;
}
.headLeft-sub button {
  background: #009ef7;
  color: #fff;
  border: 1px solid #e6e6e6;
  padding: 7px 15px;
}
.headRight-section {
  width: 70%;
  float: left;
}
.headRight-sub {
  padding: 15px 15px 0px 15px;
}
.headRight-sub h3 {
  font-size: 20px;
  font-weight: 700;
}

.body-section {
  clear: both;
  overflow: hidden;
  width: 100%;
  display: flex;
}

.left-section {
  width: calc(30% - 1px);
  float: left;
  height: 500px;
  border-right: 1px solid #e6e6e6;
  background-color: #fff;
  z-index: 1;
  position: relative;
}
.left-section ul {
  padding: 0px;
  margin: 0px;
  list-style: none;
}

.left-section ul li {
  padding: 15px 0px;
  cursor: pointer;
}
.left-section ul li:hover {
  background: rgb(237, 246, 255);
}
.left-section ul li.active {
  background: #009ef7;
  color: #fff;
  position: relative;
}
.mCustomScrollBox,
.mCSB_container {
  overflow: unset !important;
}
.left-section ul li.active .desc .time {
  color: #fff;
}
.left-section ul li.active:before {
  position: absolute;
  content: "";
  right: -10px;
  border: 5px solid #009ef7;
  top: 0px;
  bottom: 0px;
  border-radius: 0px 3px 3px 0px;
}
.left-section ul li.active:after {
  position: absolute;
  content: "";
  bottom: 0px;
  right: 0px;
  left: auto;
  width: 100%;
  top: 0px;
  -webkit-box-shadow: -8px 4px 10px #a1a1a1;
  -moz-box-shadow: -8px 4px 10px #a1a1a1;
  box-shadow: -8px 4px 10px #a1a1a1;
}

.left-section .chatList {
  overflow: hidden;
}
.left-section .chatList .img {
  width: 60px;
  float: left;
  text-align: center;
  position: relative;
}
.left-section .chatList .img img {
  width: 30px;
  height: 30px;
  border-radius: 50%;
}
.left-section .chatList .img i {
  position: absolute;
  font-size: 10px;
  color: #52e2a7;
  border: 1px solid #fff;
  border-radius: 50%;
  left: 10px;
}
.left-section .chatList .desc {
  width: calc(100% - 60px);
  float: left;
  position: relative;
}
.left-section .chatList .desc h5 {
  margin-top: 7px;
  margin-bottom: 2px;
  line-height: 5px;
  font-size: 15px;
  font-weight: 500;
}
.left-section .chatList .desc .time {
  position: absolute;
  right: 15px;
  color: #c1c1c1;
}
.right-section {
  width: 70%;
  float: left;
  height: 500px;
  background-color: #f6f6f6;
  position: relative;
}
.message {
  height: calc(100% - 68px);
  font-family: sans-serif;
}
.message ul {
  padding: 0px;
  list-style: none;
  margin: 0px auto;
  width: 90%;
  overflow: hidden;
}
.message ul li {
  position: relative;
  width: 80%;
  padding: 15px 0px;
  clear: both;
}
.message ul li.msg-left {
  float: left;
}
.message ul li.msg-left img {
  position: absolute;
  width: 40px;
  bottom: 22px;
  height: 40px;
  border-radius: 50%;
}
.message ul li.msg-left .msg-desc {
  margin-left: 70px;
  font-size: 12px;
  background: #e8e8e8;
  padding: 5px 10px;
  border-radius: 5px 5px 5px 0px;
  position: relative;
}
.message ul li.msg-left .msg-desc:before {
  position: absolute;
  content: "";
  border: 10px solid transparent;
  border-bottom-color: #e8e8e8;
  bottom: 0px;
  left: -10px;
}
.message ul li.msg-left small {
  float: right;
  color: #c1c1c1;
}

.message ul li.msg-right {
  float: right;
}
.message ul li.msg-right img {
  position: absolute;
  width: 40px;
  right: 0px;
  bottom: 22px;
  height: 40px;
  border-radius: 50%;
}
.message ul li.msg-right .msg-desc {
  margin-right: 70px;
  font-size: 12px;
  background: #cce5ff;
  color: #004085;
  padding: 5px 10px;
  border-radius: 5px 5px 5px 0px;
  position: relative;
}
.message ul li.msg-right .msg-desc:before {
  position: absolute;
  content: "";
  border: 10px solid transparent;
  border-bottom-color: #cce5ff;
  bottom: 0px;
  right: -10px;
}
.message ul li.msg-right small {
  float: right;
  color: #c1c1c1;
  margin-right: 70px;
}
.message ul li.msg-day {
  border-top: 1px solid #ebebeb;
  width: 100%;
  padding: 0px;
  margin: 15px 0px;
}
.message ul li.msg-day small {
  position: absolute;
  top: -10px;
  background: #f6f6f6;
  color: #c1c1c1;
  padding: 3px 10px;
  left: 50%;
  transform: translateX(-50%);
}
.right-section-bottom {
  background: #fff;
  width: 100%;
  padding: 15px;
  position: absolute;
  bottom: 0px;
  border-top: 1px solid #e6e6e6;
  text-align: center;
}
.right-section-bottom input {
  border: 0px;
  padding: 8px 5px;
  margin-top: 5px;
  width: calc(100% - 150px);
}
.right-section-bottom .btn-send {
  border: 0px;
  padding: 8px 10px;
  margin-top: 5px;
  float: right;
  margin-right: 30px;
  color: #009ef7;
  font-size: 18px;
  background: #fff;
  cursor: pointer;
}
.upload-btn {
  position: relative;
  overflow: hidden;
  display: inline-block;
  float: left;
}
.upload-btn .btn {
  border: 0px;
  padding: 8px 10px;
  color: #009ef7;
  font-size: 18px;
  background: #fff;
  cursor: pointer;
}
.upload-btn input[type="file"] {
  font-size: 100px;
  position: absolute;
  left: 0;
  top: 0;
  opacity: 0;
}

/* 사이드바 속성 */
/* 스크롤바없이 스크롤하기 구현 */
#forscrolls {
  overflow-y: auto;
  -ms-overflow-style: none;
  scrollbar-width: none;
}
#forscrolls::-webkit-scrollbar {
  display: none;
}

#for-scroll {
  overflow-y: auto;
  -ms-overflow-style: none;
  scrollbar-width: none;
}
#for-scroll::-webkit-scrollbar {
  display: none;
}

.chatting-main {
  margin-top: 85px;
  /* height: 790px; */
}
</style>
    <link
      href="https://fonts.googleapis.com/css?family=Raleway"
      rel="stylesheet"
    />
    <link
      href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
      rel="stylesheet"
    />
    <!-- <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.css"
    /> -->
    <link rel="stylesheet" href="/css/chattingStyle.css" />
  </head>
  <body>
    <div class="main-section">
      <div class="head-section">
        <div class="headLeft-section">
          <div class="headLeft-sub">
            <input type="text" name="search" placeholder="Search..." />
            <button><i class="fa fa-search"></i></button>
          </div>
        </div>
        <div class="headRight-section">
          <div class="headRight-sub">
            <h3>Lajy Ion</h3>
            <small>Lorem ipsum dolor sit amet...</small>
          </div>
        </div>
      </div>
      <div class="body-section">
        <div
          class="left-section mCustomScrollbar"
          id="f7Bj3"
          data-mcs-theme="minimal-dark"
        >
          <ul>
            <li>
              <div class="chatList">
                <div class="img">
                  <!--접속중 표시 <i class="fa fa-circle"></i> -->
                  <img
                    src="/image/profile/default.jpg"
                  />
                </div>
                <div class="desc">
                  <small class="time">05:30 am</small>
                  <h5>이상협</h5>
                  <small>시발 dm ㅈㄴ 어려운...</small>
                </div>
              </div>
            </li>
            
          </ul>
        </div>
        <div class="right-section">
          <div class="message mCustomScrollbar" data-mcs-theme="minimal-dark">
            <ul>
              <li class="msg-left">
                <div class="msg-left-sub">
                  <img
                    src="/image/profile/default.jpg"
                  />
                  <div class="msg-desc">
                   ㅎㅇ
                  </div>
                  <small>05:25 am</small>
                </div>
              </li>
              <li class="msg-right">
                <div class="msg-left-sub">
                  <img
                    src="/image/profile/default.jpg"
                  />
                  <div class="msg-desc">
                   ㅎㅇ
                  </div>
                  <small>05:25 am</small>
                </div>
              </li>
              <li class="msg-day"><small>Wednesday</small></li>
              <li class="msg-left">
                <div class="msg-left-sub">
                  <img
                    src="/image/profile/default.jpg"
                  />
                  <div class="msg-desc">
                   할만함?
                  </div>
                  <small>05:25 am</small>
                </div>
              </li>
              <li class="msg-right">
                <div class="msg-left-sub">
                  <img
                    src="/image/profile/default.jpg"
                  />
                  <div class="msg-desc">
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit,
                    sed do eiusmod tempor incididunt ut labore et dolore magna
                    aliqua.
                  </div>
                  <small>05:25 am</small>
                </div>
              </li>
              <li class="msg-left">
                <div class="msg-left-sub">
                  <img
                    src="/image/profile/default.jpg"
                  />
                  <div class="msg-desc">
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit
                  </div>
                  <small>05:25 am</small>
                </div>
              </li>
              <li class="msg-right">
                <div class="msg-left-sub">
                  <img
                    src="/image/profile/default.jpg"
                  />
                  <div class="msg-desc">
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit,
                    sed do eiusmod tempor incididunt ut labore et dolore magna
                    aliqua.
                  </div>
                  <small>05:25 am</small>
                </div>
              </li>
            </ul>
          </div>
          <div class="right-section-bottom">
            <form>
              <div class="upload-btn">
                <button class="btn"><i class="fa fa-photo"></i></button>
                <input type="file" name="myfile" />
              </div>
              <input type="text" name="" placeholder="type here..." />
              <button class="btn-send"><i class="fa fa-send"></i></button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <!-- custom scrollbar plugin -->
    <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script> -->
  </body>
</html>