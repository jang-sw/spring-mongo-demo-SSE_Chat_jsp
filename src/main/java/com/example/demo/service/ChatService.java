package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.documents.ChatDocument;
import com.example.demo.repo.ChatRepo;

import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Service
public class ChatService {

	@Autowired ChatRepo chatRepo;
	
	public Flux<ChatDocument> getChatting(String sender, String receiver){
		return chatRepo.findByUserOrderByCreatedDesc(sender, receiver);
	}
	
	public Mono<ChatDocument> saveMsg(ChatDocument chat){
		return chatRepo.save(chat);
	}
}
