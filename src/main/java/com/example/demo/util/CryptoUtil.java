package com.example.demo.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;


import org.springframework.stereotype.Component;

import jakarta.xml.bind.DatatypeConverter;

@Component
public class CryptoUtil {


    public String encodeSHA512(String planeText) {
    	try {
    		planeText = planeText + "salt";

    		String encodingText = "";
    		MessageDigest md = MessageDigest.getInstance("SHA-512");
    		md.update(planeText.getBytes(StandardCharsets.UTF_8));
    		encodingText = DatatypeConverter.printBase64Binary(md.digest());
    		return encodingText;
    	}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
    
}
