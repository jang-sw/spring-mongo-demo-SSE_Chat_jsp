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
	
	/**
	 * 채팅 목록 읽기
	 * @param
	 * @return 채팅 목록 스트림
	 * */
	public Flux<ChatDocument> getChatting(String room){
		return chatRepo.findByRoomOrderByCreatedDesc(room).switchIfEmpty(Flux.empty());
	}
	/**
	 * 채팅 저장
	 * @param
	 * @return 저장된 채팅
	 * */
	public Mono<ChatDocument> saveMsg(ChatDocument chat){
		return chatRepo.save(chat);
	}
}
