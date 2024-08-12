<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
    <%@ include file="../../layout/indexHeader.jsp"%>
</head>

<body>
    <div style="width: 100%; height: 50%; display: flex; flex-direction: column; justify-content: center; align-items: center">
        <div style="font-size: 26px">
            잠시만 기다려 주세요...
        </div>
        <script>
            localStorage.setItem('Authorization', '${Authorization}')
            localStorage.setItem('Refresh-Token', '${refresh}')
            location.href = "/index";
        </script>
    </div>
</body>


<script src="/js/facebookSetUsername.js"></script>