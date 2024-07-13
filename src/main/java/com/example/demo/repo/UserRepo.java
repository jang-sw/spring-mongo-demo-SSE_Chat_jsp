package com.example.demo.repo;

import org.springframework.data.mongodb.repository.ReactiveMongoRepository;

import com.example.demo.documents.ChatDocument;
import com.example.demo.documents.UserDocument;

import reactor.core.publisher.Mono;

public interface UserRepo extends ReactiveMongoRepository<UserDocument, String>{

	Mono<UserDocument> findOneByUsername(String username);
	Mono<UserDocument> findByUsernameAndPwd(String username, String pwd);
	
} 
