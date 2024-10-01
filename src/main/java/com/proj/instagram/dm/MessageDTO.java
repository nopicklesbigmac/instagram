package com.proj.instagram.dm;

import java.sql.Timestamp;



public class MessageDTO {

	private Long id;


    private String sender_username;


    private String receiver_username;


	private String content;
	private Timestamp timestamp;

	public MessageDTO(Long id, String sender_username, String receiver_username, String content, Timestamp timestamp) {
        this.id = id;
        this.sender_username = sender_username;
        this.receiver_username = receiver_username;
        this.content = content;
        this.timestamp = timestamp;
    }
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getSender_username() {
		return sender_username;
	}

	public void setSender_username(String sender_username) {
		this.sender_username = sender_username;
	}

	public String getReceiver_username() {
		return receiver_username;
	}

	public void setReceiver_username(String receiver_username) {
		this.receiver_username = receiver_username;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Timestamp timestamp) {
		this.timestamp = timestamp;
	}

	public MessageDTO() {
		this.timestamp = new Timestamp(System.currentTimeMillis());
	}


}