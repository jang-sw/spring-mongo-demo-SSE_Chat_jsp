package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.documents.UserDocument;
import com.example.demo.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import reactor.core.publisher.Mono;

@RestController
public class UserController {

	
	@Autowired UserService userService;
	
	@PostMapping(value="/join")
	public Mono<ResponseEntity<Integer>> join(@RequestBody UserDocument user){
		return userService.isDuplicateName(user.getUsername()) 
			.flatMap(res -> res.booleanValue() ? 
				Mono.just(ResponseEntity.ok(-1)) : userService.saveUser(user).thenReturn(ResponseEntity.ok(1)));
	}	
	
	@PostMapping(value="/login")
	public Mono<ResponseEntity<Integer>> login(@RequestBody UserDocument user, HttpServletRequest httpServletRequest){
		return userService.login(user)
			.flatMap(u -> {
				httpServletRequest.getSession().setAttribute("user", user);
				return Mono.just(ResponseEntity.ok(1));
			}).defaultIfEmpty(ResponseEntity.ok(1));
	}
}
