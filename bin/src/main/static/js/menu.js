function MenuMouseOver(name) {
    document.getElementById(name).style.backgroundColor = '#f2f2f2';
    document.getElementById(name+"button").style.width = '26px';
    document.getElementById(name+"button").style.heightth = '26px';
}

function MenuMouseLeave(name) {
    document.getElementById(name).style.backgroundColor = '#ffffff';
    document.getElementById(name+"button").style.width = '22px';
    document.getElementById(name+"button").style.heightth = '22px';
}

function MenuMouseDown(name) {
    document.getElementById(name+"button").style.width = '20px';
    document.getElementById(name+"button").style.heightth = '20px';
}

$("#find").on("click", function() {
    location.href = "/find";
})

$("#insta").on("click", function() {
    location.href = "/index";
})

$("#home").on("click", function() {
    location.href = "/index";
})

$("#write").on("click", function() {
    location.href = "/write";
})

$("#profile").on("click", function() {
    location.href = "/profile/" + principal.username;
})