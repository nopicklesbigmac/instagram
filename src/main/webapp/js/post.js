$(document).ready(function() {
    // 사용자 정보를 가져오기 위한 AJAX 요청
    $.ajax({
        type: "GET",
        url: "/getPrincipal",
        contentType: "application/json; charset=utf-8",
    }).done(function(resp) {
        principal = resp;

        // 게시글 작성 날짜 표기
        var dateString = document.getElementById("post_infoBox_likes_date").innerText;

        if (dateString) {
            var dateObject = new Date(dateString + "T00:00:00");
            if (!isNaN(dateObject.getTime())) {
                var formattedDate = dateObject.getFullYear() + "년 " +
                    (dateObject.getMonth() + 1).toString().padStart(2, '0') + "월 " +
                    dateObject.getDate().toString().padStart(2, '0') + "일";

                document.getElementById("post_infoBox_likes_date").innerHTML = formattedDate;
            } else {
                console.error("Invalid date: ", dateString);
            }
        }
    });

    // 댓글 작성 함수
    function postReply(postId) {
        var comment = $("#post_commentInput").val();
        if (comment.trim() === "") {
            alert("댓글을 입력해주세요.");
            return;
        }

        var replyData = {
            accountId: principal.email,
            postId: postId,
            email: principal.email,
            username: principal.username,
            comments: comment,
            useProfileImg: principal.useProfileImg,
        };

        $.ajax({
            type: "POST",
            url: "/reply",
            contentType: "application/json",
            data: JSON.stringify(replyData),
            success: function(response) {
                // 댓글 추가 후 입력창 초기화
                $("#post_commentInput").val("");
                // 댓글 추가 로직 (예: 새 댓글 추가를 위해 페이지 새로고침)
            },
            error: function(error) {
                console.error("Error posting reply: ", error);
            }
        });
    }
});
