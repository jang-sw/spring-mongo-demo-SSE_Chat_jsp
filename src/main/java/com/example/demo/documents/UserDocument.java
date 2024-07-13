package com.example.demo.documents;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Data;
import lombok.ToString;


@Data
@ToString
@Document(collection = "user")
public class UserDocument {

	@Id
	String id;
	String username;
	String pwd;
}
