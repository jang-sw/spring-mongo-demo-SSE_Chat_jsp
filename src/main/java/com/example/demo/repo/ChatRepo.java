package com.example.demo.repo;

import org.springframework.data.mongodb.repository.Query;
import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
//import org.springframework.data.mongodb.repository.Tailable;
import org.springframework.data.mongodb.repository.Tailable;

import com.example.demo.documents.ChatDocument;

import reactor.core.publisher.Flux;

public interface ChatRepo extends ReactiveMongoRepository<ChatDocument, String>{

	
	@Tailable
	@Query("{room:?0}")
	Flux<ChatDocument> findByRoomOrderByCreatedDesc(String room);
	
} 
