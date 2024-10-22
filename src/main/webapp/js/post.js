function postReply(postId) {
    const replyButton = document.getElementById('replyButton');
    replyButton.disabled = true;  // 버튼 비활성화
    const replyContent = document.getElementById(`replyInput${postId}`).value; 
    const principalEmail = document.getElementById('principalEmail').value; 
    const principalUsername = document.getElementById('principalUsername').value; 
    const principalImg = document.getElementById('principalImg').value; 

    if (!replyContent) {
        alert("댓글을 입력해주세요."); 
        return;
    }

    if (!principalEmail) {
        alert("로그인해야 합니다."); 
        return;
    }

    const data = {
        postId: postId, 
        email: principalEmail, 
        username: principalUsername, 
        useProfileImg: principalImg, 
        comments: replyContent,
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
            return response.json();
        } else {
            alert("댓글 추가에 실패했습니다.");
        }
    })
    .then(data => {
        const postReplyBox = document.getElementById('post_replyBox');
        postReplyBox.innerHTML = '';

        data.forEach(reply => {
            const replyDiv = document.createElement('div');
            replyDiv.id = "post_reply";
            replyDiv.style.marginTop = '10px';
            const img = document.createElement('img');
            img.src = reply.useProfileImg || '/image/profile/default.jpg'; 
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

        document.getElementById(`replyInput${postId}`).value = ''; 
    })
    .catch(error => {
        console.error('댓글 추가 중 오류 발생:', error);
    });
}



function Like() {
    const accountId = document.getElementById('principalEmail').value;
    const postId = document.getElementById('postId').value;

    fetch('/like', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ accountId: accountId, postId: postId }),
    })
    .then(response => response.json())
    .then(updatedLikeCount => {
        document.getElementById('likeOrUnlike').innerHTML = '<div id="unLikeButton" class="buttons" onclick="Unlike()"><span>❤️</span></div>';
        updateLikeCount(updatedLikeCount); // 좋아요 수 갱신
    })
    .catch(error => console.error('좋아요 추가 중 오류 발생:', error));
}

function Unlike() {
    const accountId = document.getElementById('principalEmail').value;
    const postId = document.getElementById('postId').value;

    fetch('/unlike', {
        method: 'DELETE',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ accountId: accountId, postId: postId }),
    })
    .then(response => response.json())
    .then(updatedLikeCount => {
        document.getElementById('likeOrUnlike').innerHTML = '<div id="likeButton" class="buttons" onclick="Like()"><span>🤍</span></div>';
        updateLikeCount(updatedLikeCount); // 좋아요 수 갱신
    })
    .catch(error => console.error('좋아요 취소 중 오류 발생:', error));
}

function updateLikeCount(newCount) {
    const likeCountElement = document.getElementById('likeCounts');
    likeCountElement.textContent = `좋아요 ${newCount}개`;
}
