var currentIndex = 0;
var oriImages = []; // 원본 파일 보관 리스트
var images = []; // 미리보기 파일 보관 리스트

function previewImages(event) {
    var preview = document.getElementById('imageBox');
    var files = event.target.files;

    if (files.length + images.length > 10) {
        alert('이미지는 최대 10개까지 업로드 가능합니다.');
        event.target.value = '';
        return;
    }

    // 업로드될 때마다 비우기
    preview.innerHTML = '';

    for(var i = 0; i < files.length; i++) {
        var file = files[i];
        oriImages.push(file);

        var reader = new FileReader();

        reader.onload = function (e) {
            var image = new Image();
            image.src = e.target.result;
            image.className = 'uploadedImage';
            images.push(image);

            // 이미지 개수 업데이트
            document.getElementById('totalImages').innerText = images.length;

            showImage(currentIndex);
        };
        reader.readAsDataURL(file);
    }
}

function showImage(index) {
    var imageBox = document.getElementById('imageBox');

    // 이미지 개수 업데이트
    document.getElementById('totalImages').innerText = images.length;

    // 이미지를 표시하는 div를 비우고 현재 이미지 추가
    imageBox.innerHTML = '';
    imageBox.appendChild(images[index]);

    document.getElementById('currentIndex').innerText = index + 1;
}

function showPrev() {
    currentIndex = (currentIndex - 1 + images.length) % images.length;
    showImage(currentIndex);
}

function showNext() {
    currentIndex = (currentIndex + 1) % images.length;
    showImage(currentIndex);
}

function postUpload() {
    let data = new FormData();
    data.append('userId', principal.id);
    data.append('comment', document.getElementById('contentBox').value);

    for (let i=0; i<oriImages.length; i++) {
        data.append('pictures', oriImages[i], 'image'+i);
    }

    $.ajax({
        type: "POST",
        url: "/upload",
        data: data,
        contentType: false,
        processData: false
    }).done(function (resp){
        alert("글이 작성되었습니다.");
        location.href = "/index";
    }).fail(function(error){
        alert(JSON.stringify(error));
    });
}