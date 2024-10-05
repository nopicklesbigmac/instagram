function postReply(postId) {
    const replyContent = document.getElementById(`replyInput${postId}`).value; // 댓글 입력 값 가져오기
    const principalEmail = document.getElementById('principalEmail').value; // 로그인 사용자 이메일 가져오기
    const principalUsername = document.getElementById('principalUsername').value; // 로그인 사용자 이름 가져오기
    const principalImg = document.getElementById('principalImg').value; // 로그인 사용자 프로필 이미지 가져오기

    if (!replyContent) {
        alert("댓글을 입력해주세요."); // 댓글이 비어있을 경우
        return;
    }

    if (!principalEmail) {
        alert("로그인해야 합니다."); // 로그인되지 않았을 경우
        return;
    }

    const data = {
        postId: postId, // 게시글 ID
        email: principalEmail, // 댓글 작성자의 이메일
        username: principalUsername, // 댓글 작성자의 사용자 이름
        useProfileImg: principalImg, // 댓글 작성자의 프로필 이미지
        comments: replyContent, // 댓글 내용
    };

    fetch(`/postReply`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(data),
    })
    .then(response => {
        if (response.ok) {
            return response.json(); // 새로운 댓글 목록을 반환받기
        } else {
            alert("댓글 추가에 실패했습니다.");
        }
    })
    .then(data => {
        // 댓글 목록 갱신
        const postReplyBox = document.getElementById('post_replyBox');
        postReplyBox.innerHTML = ''; // 기존 댓글 지우기

        // 댓글 출력
        data.forEach(reply => {
            const replyDiv = document.createElement('div');
            replyDiv.id = "post_reply";
            replyDiv.style.marginTop = '10px';
            const img = document.createElement('img');
            img.src = reply.useProfileImg || '/image/profile/default.jpg'; // 기본 이미지 경로
            img.className = "profileMini";
            img.style.cursor = "pointer";
            img.onclick = function() {
                gotoUserProfile(reply.username);
            };

            const spanUsername = document.createElement('span');
            spanUsername.style.fontWeight = "bold";
            spanUsername.style.fontSize = "16px";
            spanUsername.style.cursor = "pointer";
            spanUsername.style.marginLeft = "0.8px";
            spanUsername.style.padding = "4px";
            spanUsername.onclick = function() {
                gotoUserProfile(reply.username);
            };
            spanUsername.innerText = reply.username;

            const spanComment = document.createElement('span');
            spanComment.innerText = reply.comments;

            replyDiv.appendChild(img);
            replyDiv.appendChild(spanUsername);
            replyDiv.appendChild(spanComment);
            postReplyBox.appendChild(replyDiv);
        });

        document.getElementById(`replyInput${postId}`).value = ''; // 입력값 초기화
    })
    .catch(error => {
        console.error('댓글 추가 중 오류 발생:', error);
    });
}
