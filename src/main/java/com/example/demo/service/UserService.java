package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.documents.UserDocument;
import com.example.demo.repo.UserRepo;
import com.example.demo.util.CryptoUtil;

import reactor.core.publisher.Mono;

@Service
public class UserService {

	@Autowired UserRepo userRepo;
	@Autowired CryptoUtil cryptoUtil;
	
	public Mono<Boolean> isDuplicateName(String name){
		return userRepo.findOneByUsername(name)
			.flatMap(user -> Mono.just(true))
			.defaultIfEmpty(false);
	}
	
	public Mono<UserDocument> saveUser(UserDocument user){
		user.setPwd(cryptoUtil.encodeSHA512(user.getPwd()));
		return userRepo.save(user);
	}
	
	public Mono<UserDocument> login(UserDocument user){
		return userRepo.findByUsernameAndPwd(user.getUsername() ,cryptoUtil.encodeSHA512(user.getPwd()));
	}
	
}
