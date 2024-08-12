<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
    <%@ include file="../../layout/indexHeader.jsp"%>
    <%@ include file="../../layout/menu.jsp"%>
    <%@ include file="../getPrincipal.jsp"%>

    <style>
        body {
            margin-left: 74px;
            display: flex;
            justify-content: center;
        }

        .contentBox {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .uploadedImage {
            max-width: 500px;
            max-height: 700px;
            width: auto;
            height: auto;
        }

        .imageUploadButton {
            width: 120px;
            height: 30px;
            padding-left: 5px;
            padding-right: 5px;
            border: 1px solid #dbdbdb;
            border-radius: 3px;
            cursor: pointer;
            font-size: 12px;
            text-align: center;
            line-height: 30px;
            margin-left: 10px;
        }

        .NextPrevButton {
            border: 1px solid #dbdbdb;
            border-radius: 3px;
            font-size: 14px;
        }

        .postUploadButton {
            width: 200px;
            height: 30px;
            background-color: #0095f6;
            border: none;
            border-radius: 5px;
            color: white;
            margin-left: 300px;
        }
    </style>
</head>

<body>
    <div id="Content" class="contentBox">
        <div id="writeLableBox" style="margin-top: 30px">
            <span style="font-size: 16px; font-weight: bold; margin-bottom: 20px">새 게시물 만들기</span>
            <hr />
            <input type="file" accept="image/*" id="imageFile" multiple="multiple" style="display: none" onchange="previewImages(event)">
        </div>

        <div id="imageAndComment" style="margin-left: 0px; display: flex; flex-direction: row">
            <div id="imageBox" style="width: 500px; height: 700px; margin-right: 4px; border: 1px solid #dbdbdb"></div>
            <textarea id="contentBox" style="width: 300px; height: 700px; border: 1px solid #dbdbdb" placeholder="문구를 입력하세요..."></textarea>
        </div>
        <div style="margin-top: 10px">
            <button class="NextPrevButton" onclick="showPrev()">이전</button>
            <span id="currentIndex" style="font-size: 14px">0</span> / <span id="totalImages" style="font-size: 14px">0</span>
            <button class="NextPrevButton" onclick="showNext()">다음</button>
            <label for="imageFile" class="imageUploadButton">
                사진 업로드
            </label>
            <button class="postUploadButton" onclick="postUpload()">업로드</button>
        </div>
    </div>
</body>


<script src="/js/write.js"></script>