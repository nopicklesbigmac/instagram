package com.proj.instagram.dm;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface MessageRepository extends JpaRepository<Message, Long> {
    List<Message> findBySenderAndReceiver(User sender, User receiver);
    List<Message> findAll();
    
	/*
	 @Query("SELECT m FROM Message m WHERE (m.sender_username = :username1 AND m.receiver_username = :username2) OR (m.sender_username = :username2 AND m.receiver_username = :username1)"
	 ) List<Message> findBySenderOrReceiver(@Param("username1") String
	username1, @Param("username2") String username2);
	 */    
    @Query(value = "SELECT m.id, m.sender_username , m.receiver_username, m.content, m.timestamp " +
            "FROM ( " +
            "    SELECT m.*, " +
            "           ROW_NUMBER() OVER (PARTITION BY CASE " +
            "               WHEN sender_username  = :userSender THEN receiver_username  " +
            "               ELSE sender_username  " +
            "           END ORDER BY timestamp DESC) as rn " +
            "    FROM message m " +
            "    WHERE sender_username  = :userSender OR receiver_username  = :userSender " +
            ") m " +
            "WHERE rn = 1", 
 nativeQuery = true)
List<Message> left_msg(@Param("userSender") String userSenderId);
}