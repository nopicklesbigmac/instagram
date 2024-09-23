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

        // 좋아요 상태를 가져오기 위한 AJAX 요청
        var postId = "${post.postId}"; // post.jsp에서 postId를 직접 가져옴
        var accountId = encodeURIComponent(principal.email); // accountId 인코딩

        $.ajax({
            type: "GET",
            url: "/post/getLike?accountId=" + accountId + "&postId=" + postId,
            contentType: "application/json; charset=utf-8"
        }).done(function(resp) {
            if (resp === 1) {
                document.getElementById('likeOrUnlike').innerHTML = '<div id="unLikeButton" class="buttons" onclick="unLikePost(' + postId + ')"><span>❤️</span></div>';
            } else {
                document.getElementById('likeOrUnlike').innerHTML = '<div id="likeButton" class="buttons" onclick="likePost(' + postId + ')"><span>🤍</span></div>';
            }
        }).fail(function(error) {
            console.log("Error fetching like status: ", JSON.stringify(error));
        });
    }).fail(function(resp) {
        console.log("Error fetching principal: ", resp);
    });
});