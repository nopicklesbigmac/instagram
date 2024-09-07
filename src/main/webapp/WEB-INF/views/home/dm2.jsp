<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<%@ include file="../../layout/menu.jsp"%>
<head>
<link href="../css/dm.css" rel="stylesheet" />
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
  
<link href="https://fonts.googleapis.com/css?family=Raleway"
	rel="stylesheet" />
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet" />
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
					<button>
						<i class="fa fa-search"></i>
					</button>
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
			<div class="left-section mCustomScrollbar" id="f7Bj3"
				data-mcs-theme="minimal-dark">
				<ul>
					<li>
						<div class="chatList">
							<div class="img">
								<!--접속중 표시 <i class="fa fa-circle"></i> -->
								<img src="/image/profile/default.jpg" />
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
					<ul class="msg-ul">
						
						<li class="msg-right">
							<div class="msg-left-sub">
								<img src="/image/profile/default.jpg" />
								<div class="msg-desc">ㅎㅇ</div>
								<small>05:21 am</small>
							</div>
						</li>
						<li class="msg-day"><small>Wednesday</small></li>

						<li class="msg-left">
							<div class="msg-left-sub">
								<img src="/image/profile/default.jpg" />
								
								<div class="msg-desc">할만함?</div>
								<small>05:22 am</small>
							</div>
						</li>
						
						<li class="msg-right">
							<div class="msg-left-sub">
								<img src="/image/profile/default.jpg" />
								<div class="msg-desc">Lorem ipsum dolor sit amet,
									consectetur adipisicing elit, sed do eiusmod tempor incididunt
									ut labore et dolore magna aliqua.</div>
								<small>05:23 am</small>
							</div>
						</li>
						<li class="msg-left">
							<div class="msg-left-sub">
								<img src="/image/profile/default.jpg" />
								<div class="msg-desc">Lorem ipsum dolor sit amet,
									consectetur adipisicing elit</div>
								<small>05:24 am</small>
							</div>
						</li>
						<li class="msg-right">
							<div class="msg-left-sub">
								<img src="/image/profile/default.jpg" />
								<div class="msg-desc">Lorem ipsum dolor sit amet,
									consectetur adipisicing elit, sed do eiusmod tempor incididunt
									ut labore et dolore magna aliqua.</div>
								<small>05:25 am</small>
							</div>
						</li>
					</ul>
				</div>
				<div class="right-section-bottom">
					<form>
						<div class="upload-btn">
							<button class="btn">
								<i class="fa fa-photo"></i>
							</button>
							<input type="file" name="myfile" />
						</div>
						<input type="text" name="" placeholder="type here..." />
						<button class="btn-send">
							<i class="fa fa-send"></i>
						</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script
		src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<!-- custom scrollbar plugin -->
	<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script> -->
</body>
</html>