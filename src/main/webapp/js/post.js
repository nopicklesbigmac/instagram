// 게시글 작성 날짜 표기
var dateString = document.getElementById("post_infoBox_likes_date").innerText;
var dateObject = new Date(dateString);

var formattedDate = dateObject.getFullYear() + "년 " +
    (dateObject.getMonth() + 1).toString().padStart(2, '0') + "월 " +
    dateObject.getDate().toString().padStart(2, '0') + "일";

document.getElementById("post_infoBox_likes_date").innerHTML = formattedDate;


function postReply(postId) {
    var comment = document.getElementById("post_commentInput").value;

    if (!comment) {
        alert("댓글을 입력해 주세요.");
    } else {
        let data = {
            comment: comment,
            accountId: principal.id,
            postId: postId
        };

        $.ajax({
            type: "POST",
            url: "/postReply",
            data: JSON.stringify(data),
            contentType: "application/json"
        }).done(function (resp) {
            alert("댓글이 작성되었습니다.");
            updateReplies(resp);
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
    }
}

function updateReplies(resp) {
    var replyBox = $("#post_replyBox");

    replyBox.empty();

    for (var i = 0; i < resp.length; i++) {
        reply = resp[i]
        var reply_username = reply.account.username;
        var profileImgSrc = reply.account.use_profile_img === 1
            ? "/dynamicImage/profile/" + reply.account.username + "/profile.jpg"
            : "/dynamicImage/profile/default.jpg";

        // 동적으로 생성한 HTML 추가
        replyBox.append(
            '<div id="post_reply" style="margin-top: 10px">' +
            '<img src="' + profileImgSrc + '" class="profileMini" style="cursor: pointer" onclick="gotoUserProfile(\'' + reply_username + '\')">' +
            '<span style="font-weight: bold; font-size: 16px; cursor: pointer" onclick="gotoUserProfile(\'' + reply_username + '\')">' + " " + reply.account.username + " " + '</span>' +
            '<span style="font-weight: normal">' + reply.comment + '</span>' +
            '</div>'
        );
    }
    $("#post_commentInput").val('');
}


// 사진 표기
let currentIdx = 0; // 시작 사진 인덱스
var postId = document.getElementById("post_id").innerText;
var post_picsize = document.getElementById("post_pic_size").innerText;
const imagePath = '/dynamicImage/posts/' + postId + '/'; // 사진의 기본 경로
const imageContainer = document.getElementById('post_imageConatiner');

const prevButton = document.getElementById('imagePrevButton');
const nextButton = document.getElementById('imageNextButton');
prevButton.style.display = currentIdx === 0 ? 'none' : '';
nextButton.style.display = currentIdx === post_picsize - 1 ? 'none' : '';

document.getElementById('imagePrevButton').addEventListener('click', () => {
    currentIdx = (parseInt(currentIdx-1, 10) + parseInt(post_picsize, 10)) % post_picsize;
    updateImage();
    prevButton.style.display = currentIdx === 0 ? 'none' : '';
    nextButton.style.display = currentIdx === post_picsize - 1 ? 'none' : '';
});

document.getElementById('imageNextButton').addEventListener('click', () => {
    currentIdx = (currentIdx + 1) % post_picsize;
    updateImage();
    prevButton.style.display = currentIdx === 0 ? 'none' : '';
    nextButton.style.display = currentIdx === post_picsize - 1 ? 'none' : '';
});

function updateImage() {
    const imageUrl = `${imagePath}${currentIdx}.jpg`;
    imageContainer.innerHTML = `<img src="${imageUrl}" style="max-width: 100%; height: auto;">`;
}


function Like() {
    let data = {
        principalId: principal.id,
        postId: document.getElementById("post_id").innerText
    };

    $.ajax({
        type: "POST",
        url: "/postLike",
        data: JSON.stringify(data),
        contentType: "application/json"
    }).done(function (resp) {
        document.getElementById('likeOrUnlike').removeChild(document.getElementById('likeButton'));
        document.getElementById('likeCounts').innerText = "좋아요 " + resp + "개";

        var likeButtonDiv = document.createElement('div');
        likeButtonDiv.id = 'unLikeButton';
        likeButtonDiv.className = 'buttons';
        likeButtonDiv.innerHTML = '<span>❤️</span>';
        likeButtonDiv.onclick = Unlike;
        document.getElementById('likeOrUnlike').appendChild(likeButtonDiv);
    }).fail(function (error) {
        alert(JSON.stringify(error));
    });
}

function Unlike() {
    let data = {
        principalId: principal.id,
        postId: document.getElementById("post_id").innerText
    };

    $.ajax({
        type: "DELETE",
        url: "/postUnlike",
        data: JSON.stringify(data),
        contentType: "application/json"
    }).done(function (resp) {
        document.getElementById('likeOrUnlike').removeChild(document.getElementById('unLikeButton'));
        document.getElementById('likeCounts').innerText = "좋아요 " + resp + "개";

        var likeButtonDiv = document.createElement('div');
        likeButtonDiv.id = 'likeButton';
        likeButtonDiv.className = 'buttons';
        likeButtonDiv.innerHTML = '<span>🤍</span>';
        likeButtonDiv.onclick = Like;
        document.getElementById('likeOrUnlike').appendChild(likeButtonDiv);
    }).fail(function (error) {
        alert(JSON.stringify(error));
    });
}


function gotoUserProfile(username) {
    location.href = "/profile/" + username;
}