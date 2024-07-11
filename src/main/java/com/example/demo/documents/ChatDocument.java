package com.example.demo.documents;

import java.time.LocalDateTime;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Data;


@Data
@Document(collection = "chat")
public class ChatDocument {

	@Id
	String id;
	String msg;
	String sender;
	String receiver;
	
	LocalDateTime created;
}
