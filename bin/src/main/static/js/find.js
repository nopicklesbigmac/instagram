function gotoProfile(username) {
    location.href = "/profile/" + username;
}

function keyHandler(event) {
    if (event.key == 'Enter') { // Enter 키를 누르는 경우
        event.preventDefault(); // 기본 Enter 키 동작을 막는다.
        findUsers(); // 'send' Div 클릭 시 작동하는 함수
    }
}

function findUsers () {
    var usernameInput = document.getElementById('findInput').value;
    if (usernameInput === "") {
        alert("유저네임을 입력해주세요.");
    } else {
        let data = {
           username: usernameInput
        }
        $.ajax({
            type: "GET",
            url: "/findUser",
            data: data,
            contentType: "application/json; charset=utf-8",
        }).done(function(accounts) {

            var usersDiv = document.getElementById('usersDiv');
            usersDiv.innerHTML = "";

            accounts.forEach(function(account) {

                const users = document.createElement("div");
                users.id = "users";
                users.onclick = function () {
                    gotoProfile(account.username);
                }

                    const users_contents = document.createElement("div");
                    users_contents.id = "users_contents";
                    users_contents.style.display = "flex";
                    users_contents.style.flexDirection = "row";

                        const users_profileImg = document.createElement("img");
                        users_profileImg.id = "users_profileImg";
                        if (account.use_profile_img === 1) {
                            users_profileImg.src = "/dynamicImage/profile/" + account.username + "/profile.jpg";
                        } else {
                            users_profileImg.src = "/dynamicImage/profile/default.jpg";
                        }
                        users_contents.appendChild(users_profileImg);

                        const users_namesInfo = document.createElement("div");
                        users_namesInfo.id = "users_namesInfo";
                        users_namesInfo.style.display = "flex";
                        users_namesInfo.style.flexDirection = "column";

                            const users_username = document.createElement("span");
                            users_username.id = "users_username";
                            users_username.style.fontSize = "14px";
                            users_username.style.fontWeight = "bold";
                            users_username.style.marginBottom = "-2px";
                            users_username.innerText = account.username;
                            users_namesInfo.appendChild(users_username);

                            const users_name = document.createElement("span");
                            users_name.id = "users_name";
                            users_name.style.fontSize = "14px";
                            users_name.style.color = "#737373";
                            users_name.innerText = account.name;
                            users_namesInfo.appendChild(users_name);

                        users_contents.appendChild(users_namesInfo);

                        const users_followers = document.createElement('div');
                        users_followers.id = "users_followers";
                        users_followers.style.fontSize = "14px";
                        users_followers.style.color = "#737373";
                        users_followers.style.paddingTop = "19px";
                        users_followers.style.marginLeft = "4px";
                        users_followers.innerText = "• 팔로워 " + account.follower + "명";
                        users_contents.appendChild(users_followers);

                    users.appendChild(users_contents);

                usersDiv.appendChild(users);
            });
        }).fail(function (error) {
            alert("에러 발생 (콘솔 확인)");
            console.log(error);
        });
    }
}