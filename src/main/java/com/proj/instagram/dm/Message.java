package com.proj.instagram.dm;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;


@Entity
@Table(name = "message")
public class Message {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "message_seq")
	@SequenceGenerator(name = "message_seq", sequenceName = "message_seq", allocationSize = 1)
	private Long id;

    @Column(name = "sender_username")
    private String sender;

    @Column(name = "receiver_username")
    private String receiver;


	private String content;
	private Timestamp timestamp;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
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

	public Message() {
		this.timestamp = new Timestamp(System.currentTimeMillis()); // 현재 시간으로 타임스탬프 초기화
	}

	// getters and setters
}