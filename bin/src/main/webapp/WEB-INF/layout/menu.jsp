<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
  #menu {
    width: 73px;
    padding: 11px;
    position: fixed;
    left: 0;
    height: 100%;
    background-color: white;

    border: 1px solid #dbdbdb;
  }
</style>

<body>
  <div id="menu">
    <div id="insta" style="cursor: pointer; margin-top: 12px; width: 48px; height: 48px; border-radius: 10px; display: flex; align-items: center; justify-content: center;" onmouseover="MenuMouseOver('insta')" onmouseleave="MenuMouseLeave('insta')" onmousedown="MenuMouseDown('insta')">
      <img id="instabutton" src="/image/menu/insta.png">
    </div>

    <div id="home" style="cursor: pointer; margin-top: 32px; width: 48px; height: 48px; border-radius: 10px; display: flex; align-items: center; justify-content: center;" onmouseover="MenuMouseOver('home')" onmouseleave="MenuMouseLeave('home')" onmousedown="MenuMouseDown('home')">
      <img id="homebutton" src="/image/menu/home.png">
    </div>

    <div id="find" style="cursor: pointer; margin-top: 8px; width: 48px; height: 48px; border-radius: 10px; display: flex; align-items: center; justify-content: center;" onmouseover="MenuMouseOver('find')" onmouseleave="MenuMouseLeave('find')" onmousedown="MenuMouseDown('find')">
      <img id="findbutton" src="/image/menu/find.png">
    </div>

    <div id="compass" style="cursor: pointer; margin-top: 8px; width: 48px; height: 48px; border-radius: 10px; display: flex; align-items: center; justify-content: center;" onmouseover="MenuMouseOver('compass')" onmouseleave="MenuMouseLeave('compass')" onmousedown="MenuMouseDown('compass')">
      <img id="compassbutton" src="/image/menu/compass.png">
    </div>

    <div id="rels" style="cursor: pointer; margin-top: 8px; width: 48px; height: 48px; border-radius: 10px; display: flex; align-items: center; justify-content: center;" onmouseover="MenuMouseOver('rels')" onmouseleave="MenuMouseLeave('rels')" onmousedown="MenuMouseDown('rels')">
      <img id="relsbutton" src="/image/menu/rels.png">
    </div>

    <div id="dm" style="cursor: pointer; margin-top: 8px; width: 48px; height: 48px; border-radius: 10px; display: flex; align-items: center; justify-content: center;" onmouseover="MenuMouseOver('dm')" onmouseleave="MenuMouseLeave('dm')" onmousedown="MenuMouseDown('dm')">
      <img id="dmbutton" src="/image/menu/dm.png">
    </div>

    <div id="heart" style="cursor: pointer; margin-top: 8px; width: 48px; height: 48px; border-radius: 10px; display: flex; align-items: center; justify-content: center;" onmouseover="MenuMouseOver('heart')" onmouseleave="MenuMouseLeave('heart')" onmousedown="MenuMouseDown('heart')">
      <img id="heartbutton" src="/image/menu/heart.png">
    </div>

    <div id="write" style="cursor: pointer; margin-top: 8px; width: 48px; height: 48px; border-radius: 10px; display: flex; align-items: center; justify-content: center;" onmouseover="MenuMouseOver('write')" onmouseleave="MenuMouseLeave('write')" onmousedown="MenuMouseDown('write')">
      <img id="writebutton" src="/image/menu/write.png">
    </div>

    <div id="profile" style="cursor: pointer; margin-top: 8px; width: 48px; height: 48px; border-radius: 10px; display: flex; align-items: center; justify-content: center;" onmouseover="MenuMouseOver('profile')" onmouseleave="MenuMouseLeave('profile')">
      <img id="profilebutton" id="mini_profile" width="24px" height="24px" style="border-radius: 50%">
    </div>

    <div id="setting" style="cursor: pointer; margin-top: 301px; width: 48px; height: 48px; border-radius: 10px; display: flex; align-items: center; justify-content: center;" onmouseover="MenuMouseOver('setting')" onmouseleave="MenuMouseLeave('setting')" onmousedown="MenuMouseDown('setting')">
      <img id="settingbutton" src="/image/menu/setting.png">
    </div>
  </div>
</body>

<script src="/js/menu.js"></script>