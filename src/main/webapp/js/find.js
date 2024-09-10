function gotoProfile(user_name) {
    location.href = "/profile/" + user_name;
}

function keyHandler(event) {
    if (event.key === 'Enter') {
        event.preventDefault();
        findUsers();
    }
}

function findUsers() {
    var usernameInput = document.getElementById('findInput').value;
    if (usernameInput === "") {
        alert("유저네임을 입력해주세요.");
    } else {
        $.ajax({
            type: "GET",
            url: "/findUser",
            data: { username: usernameInput },
            success: function (accounts) {
                var usersDiv = document.getElementById('usersDiv');
                usersDiv.innerHTML = "";

                accounts.forEach(function (account) {
                    const userDiv = document.createElement("div");
                    userDiv.className = "user";
                    userDiv.onclick = function () {
                        gotoProfile(account.user_name); // 'username'을 'user_name'으로 수정
                    }

                    const userContent = document.createElement("div");
                    userContent.id = "user_content"; // HTML 요소의 ID는 고유해야 합니다.
                    userContent.style.display = "flex";
                    userContent.style.flexDirection = "row";

                    const userProfileImg = document.createElement("img");
                    userProfileImg.className = "user_profile_img";
                    if (account.use_profile_img === "1") {
                        userProfileImg.src = "/dynamicImage/profile/" + account.user_name + "/profile.jpg"; // 'username'을 'user_name'으로 수정
                    } else {
                        userProfileImg.src = "/dynamicImage/profile/default.jpg";
                    }
                    userContent.appendChild(userProfileImg);

                    const userInfo = document.createElement("div");
                    userInfo.className = "user_info";
                    userInfo.style.display = "flex";
                    userInfo.style.flexDirection = "column";

                    const userUsername = document.createElement("span");
                    userUsername.className = "user_username";
                    userUsername.style.fontSize = "14px";
                    userUsername.style.fontWeight = "bold";
                    userUsername.style.marginBottom = "-2px";
                    userUsername.innerText = account.user_name; // 'username'을 'user_name'으로 수정
                    userInfo.appendChild(userUsername);

                    const userName = document.createElement("span");
                    userName.className = "user_name";
                    userName.style.fontSize = "14px";
                    userName.style.color = "#737373";
                    userName.innerText = account.name;
                    userInfo.appendChild(userName);

                    userContent.appendChild(userInfo);

                    const userFollowers = document.createElement('div');
                    userFollowers.className = "user_followers";
                    userFollowers.style.fontSize = "14px";
                    userFollowers.style.color = "#737373";
                    userFollowers.style.paddingTop = "19px";
                    userFollowers.style.marginLeft = "4px";
                    userFollowers.innerText = "• 팔로워 " + account.follower + "명";
                    userContent.appendChild(userFollowers);

                    userDiv.appendChild(userContent);
                    usersDiv.appendChild(userDiv);
                });
            },
            error: function (error) {
                alert("에러 발생 (콘솔 확인)");
                console.log(error);
            }
        });
    }
}
