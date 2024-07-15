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
	
	/**
	 * 중복 여부 채크
	 * @param
	 * @return True or False
	 * */
	public Mono<Boolean> isDuplicateName(String name){
		return userRepo.findOneByUsername(name)
			.flatMap(user -> Mono.just(true))
			.defaultIfEmpty(false);
	}
	
	/**
	 * 유저 저장
	 * @param
	 * @return 저장된 유저
	 * */
	public Mono<UserDocument> saveUser(UserDocument user){
		user.setPwd(cryptoUtil.encodeSHA512(user.getPwd()));
		return userRepo.save(user);
	}
	
	/**
	 * 로그인 인증
	 * @param
	 * @return 로그인한 유저
	 * */
	public Mono<UserDocument> login(UserDocument user){
		return userRepo.findByUsernameAndPwd(user.getUsername() ,cryptoUtil.encodeSHA512(user.getPwd()));
	}
	
}
