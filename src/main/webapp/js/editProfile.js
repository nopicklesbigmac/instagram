var oriImages;

function  init() {
    var principal;
    $.ajax({
        type: "GET",
        url: "/getPrincipal",
        headers: {'Authorization':localStorage.getItem('Authorization'),
            'Refresh-Token':localStorage.getItem('Refresh-Token')},
        contentType: "application/json; charset=utf-8",
    }).done(function(resp) {

        principal = resp;

        // 프로필 이미지 불러오기
        var imageBox = document.getElementById('profile_image');
        var profileImage = document.createElement('img');
        profileImage.style.width = '56px';
        profileImage.style.height = '56px';
        profileImage.style.borderRadius = '50%';
        profileImage.style.border = '1px solid #dbdbdb';
        if(principal.use_profile_img == 1) {
            profileImage.src = "/dynamicImage/profile/" + principal.username + "/profile.jpg";
        } else {
            profileImage.src = "/dynamicImage/profile/default.jpg";
        }
        imageBox.appendChild(profileImage);

        // 닉네임과 이름 불러오기
        document.getElementById('profile_username').innerText = principal.username;
        document.getElementById('profile_name').innerText = principal.name;


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

function changeImage() {
    var profileBox = document.getElementById('profile_image');
    var files = event.target.files;

    for (var i=0; i<files.length; i++) {
        oriImages = files[i];

        var reader = new FileReader();

        reader.onload = function (e) {
            var image = new Image();
            image.src = e.target.result;
            image.className = 'uploadedImage';

            // 이미지를 표시하는 div를 비우고 현재 이미지 추가
            profileBox.innerHTML = '';
            profileBox.appendChild(image);
        };
        reader.readAsDataURL(files[i]);
    }
}

function profile_save() {

    $.ajax({
        type: "GET",
        url: "/getPrincipal",
        headers: {'Authorization':localStorage.getItem('Authorization'),
            'Refresh-Token':localStorage.getItem('Refresh-Token')},
        contentType: "application/json; charset=utf-8",
    }).done(function(resp) {

        let data = new FormData();
        data.append('accountId', principal.id);
        data.append('comment', document.getElementById('commentInput').value);
        data.append('picture', oriImages, 'profile');

        principal = resp;
        $.ajax({
            type: "PUT",
            url: "/profile/editProfile",
            data: data,
            contentType: false,
            processData: false
        }).done(function (resp){
            alert("편집이 완료되었습니다.");
            location.href = "/profile/" + principal.username;
        }).fail(function(error){
            alert(JSON.stringify(error));
        });

    });
}

this.init();