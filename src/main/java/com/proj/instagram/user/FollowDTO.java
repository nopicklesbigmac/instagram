package com.proj.instagram.user;

public class FollowDTO {
	public String FOLLOWER_username;
	public String FOLLOWING_username;
	public String getFOLLOWER_username() {
		return FOLLOWER_username;
	}
	public void setFOLLOWER_username(String fOLLOWER_username) {
		FOLLOWER_username = fOLLOWER_username;
	}
	public String getFOLLOWING_username() {
		return FOLLOWING_username;
	}
	public void setFOLLOWING_username(String fOLLOWING_username) {
		FOLLOWING_username = fOLLOWING_username;
	}
	
}
