package com.example.demo.controller;


import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.documents.ChatDocument;
import com.example.demo.service.ChatService;

import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.core.scheduler.Schedulers;

@RestController
public class ChatController {

	@Autowired ChatService chatService;
	
	@GetMapping(value="/chatting/{room}", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
	public Flux<ChatDocument> getChatting(@PathVariable String room){
		return chatService.getChatting(room)
				.subscribeOn(Schedulers.boundedElastic());
	}
	@PostMapping(value="/chatting")
	public Mono<ChatDocument> sendChat(@RequestBody ChatDocument chatDocument){
		chatDocument.setCreated(LocalDateTime.now());
		return chatService.saveMsg(chatDocument);
	}	
	
}
