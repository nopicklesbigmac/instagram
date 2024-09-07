var principal;

function init() {
    $.ajax({
        type: "GET",
        url: "/getPrincipal",
        contentType: "application/json; charset=utf-8",
    }).done(function(resp) {
        principal = resp;

        // 프로필 이미지 불러오기
        var imageBox = document.getElementById('use_profile_img');
        imageBox.src = principal.use_profile_img ? 
                       "/dynamicImage/profile/" + principal.username + "/profile.jpg" : 
                       "/dynamicImage/profile/default.jpg";

        // 닉네임과 이름 불러오기
        document.getElementById('profile_username').innerText = principal.username;
        document.getElementById('profile_name').innerText = principal.name;

        // 코멘트 표시
        document.getElementById('commentInput').value = principal.comments || '';
        checkMaxLength(); // 문자 수 표시 업데이트
    });
}


function checkMaxLength() {
    var maxLength = 150;
    var commentInput = document.getElementById('commentInput');
    var charCount = document.getElementById('charCount');

    if (commentInput.value.length > maxLength) {
        commentInput.value = commentInput.value.substring(0, maxLength);
    }

    var remainingChars = maxLength - commentInput.value.length;
    charCount.textContent = commentInput.value.length + " / " + maxLength;
}

function changeImage(event) {
    console.log("Image file selected");
    var profileBox = document.getElementById('use_profile_img');

    var files = event.target.files;
    if (files.length > 0) {
        var file = files[0];
        var reader = new FileReader();

        reader.onload = function (e) {
            console.log("Image loaded");
            profileBox.src = e.target.result; // 미리보기를 위한 이미지 URL 업데이트
        };
        reader.readAsDataURL(file);
    }
}

function profile_save() {
    let data = new FormData();
    data.append('comments', document.getElementById('commentInput').value); // 코멘트 값 추가
    
    var imageFileInput = document.getElementById('imageFile');
    if (imageFileInput.files.length > 0) {
        data.append('use_profile_img', imageFileInput.files[0]); // 프로필 이미지 추가
    }

    $.ajax({
        type: "POST",
        url: "/editProfile",
        data: data,
        contentType: false,
        processData: false,
    }).done(function(resp) {
        alert("편집이 완료되었습니다.");
        location.reload();
    }).fail(function(error) {
        alert(JSON.stringify(error));
    });
}

this.init();
