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
        var use_profile_img = document.createElement('img');
        use_profile_img.style.width = '56px';
        use_profile_img.style.height = '56px';
        use_profile_img.style.borderRadius = '50%';
        use_profile_img.style.border = '1px solid #dbdbdb';
        if (principal.use_profile_img) {
            use_profile_img.src = "/dynamicImage/profile/" + principal.username + "/profile.jpg";
        } else {
            use_profile_img.src = "/dynamicImage/profile/default.jpg";
        }
        imageBox.appendChild(use_profile_img);

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
    charCount.textContent = remainingChars + " / 150";
}

function changeImage(event) {
    console.log("Image file selected");
    var profileBox = document.getElementById('profile_img');
    var files = event.target.files;

    if (files.length > 0) {
        var file = files[0];
        var reader = new FileReader();

        reader.onload = function (e) {
            console.log("Image loaded");
            profileBox.src = e.target.result; // 이미지 URL을 미리보기로 업데이트
        };
        reader.readAsDataURL(file);
    }
}



//function changeImage() {
//    var profileBox = document.getElementById('use_profile_img');
//    var files = event.target.files;

//    for (var i=0; i<files.length; i++) {
//        oriImages = files[i];

//        var reader = new FileReader();

//        reader.onload = function (e) {
//            var image = new Image();
//            image.src = e.target.result;
//            image.className = 'uploadedImage';

            // 이미지를 표시하는 div를 비우고 현재 이미지 추가
//profileBox.innerHTML = '';
//            profileBox.appendChild(image);
//        };
//        reader.readAsDataURL(files[i]);
//    }
//}

function profile_save() {
    let data = new FormData();
    data.append('comments', document.getElementById('commentInput').value); // 코멘트 값 추가
    if (document.getElementById('imageFile').files.length > 0) {
        data.append('use_profile_img', document.getElementById('use_profile_img').files[0]); // 프로필 이미지 추가
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