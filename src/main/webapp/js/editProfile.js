var oriImages;

// 페이지가 로드된 후 호출되는 함수
function init() {
    $.ajax({
        type: "GET",
        url: "/getPrincipal",
        contentType: "application/json; charset=utf-8",
    }).done(function(resp) {
        var principal = resp;

        // 프로필 이미지 불러오기
        var imageBox = document.getElementById('profile_image');
        var profileImage = document.createElement('img');
        profileImage.style.width = '56px';
        profileImage.style.height = '56px';
        profileImage.style.borderRadius = '50%';
        profileImage.style.border = '1px solid #dbdbdb';
        profileImage.src = principal.use_profile_img || "/dynamicImage/profile/default.jpg";
        imageBox.appendChild(profileImage);

        // 닉네임과 이름 불러오기
        document.getElementById('profile_username').innerText = principal.username;
        document.getElementById('profile_name').innerText = principal.name;
        
    }).fail(function(textStatus, errorThrown) {
        console.error("프로필 정보 로드 실패: ", textStatus, errorThrown);
    });
}

// 텍스트 영역의 최대 길이를 체크하는 함수
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

// 파일 선택 시 이미지 미리보기 기능
function changeImage(event) {
    var profileBox = document.getElementById('profile_image');
    var files = event.target.files;

    if (files.length > 0) {
        oriImages = files[0];

        var reader = new FileReader();
        reader.onload = function (e) {
            var image = new Image();
            image.src = e.target.result;
            image.className = 'uploadedImage';

            // 이미지를 표시하는 div를 비우고 현재 이미지 추가
            profileBox.innerHTML = '';
            profileBox.appendChild(image);
        };
        reader.readAsDataURL(files[0]);
    }
}



// 프로필 저장 함수
function submitForm() {
    var formElement = document.getElementById('editProfileForm');
    
    if (!formElement) {
        console.error("폼 요소를 찾을 수 없습니다.");
        return;
    }
    
    var formData = new FormData(formElement);

    $.ajax({
        type: "POST",
        url: "/profile/editProfile",
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            alert("편집이 완료되었습니다.");
            location.href = "/profile/" + response.email;
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error("AJAX 요청 에러:", textStatus, errorThrown);
        }
    });
}





// 프로필 업데이트 함수
function updateProfile(response) {
    // 프로필 정보를 업데이트하는 로직을 추가합니다.
    var profileImage = document.querySelector('#profile_image img');
    if (profileImage) {
        profileImage.src = response.profileImage || "/dynamicImage/profile/default.jpg";
    }
    document.getElementById('profile_username').innerText = response.username;
    document.getElementById('profile_name').innerText = response.name;
}

// 페이지가 로드된 후 init 함수 호출
$(document).ready(function() {
    init();
});