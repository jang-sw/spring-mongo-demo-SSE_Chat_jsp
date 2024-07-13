package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ViewController {

	@GetMapping(value = "/")
	public String main(HttpServletRequest httpServletRequest) {
		if(httpServletRequest.getSession().getAttribute("user") == null) {
			return "redirect:/login";
		}
		return "main";
	}
	
	@GetMapping(value = "/chat/{room}")
	public String chatRoom(HttpServletRequest httpServletRequest, @PathVariable String room) {
		if(httpServletRequest.getSession().getAttribute("user") == null) {
			return "redirect:/login";
		}
		if(room == null) {
			return "redirect:/";
		}
		httpServletRequest.setAttribute("room", room);
		return "chat";
	}
	
	@GetMapping(value = "/login")
	public String loginView(HttpServletRequest httpServletRequest) {
		if(httpServletRequest.getSession().getAttribute("user") != null) {
			return "redirect:/";
		}
		return "login";
	}
	@GetMapping(value = "/logout")
	public String logout(HttpServletRequest httpServletRequest) {
		httpServletRequest.getSession().removeAttribute("user");
		return "redirect:/login";
	}
}
