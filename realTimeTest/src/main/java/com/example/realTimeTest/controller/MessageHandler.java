package com.example.realTimeTest.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.realTimeTest.dto.TestDTO;

@Controller
public class MessageHandler{
	
	
	@MessageMapping("/hello")
	@SendTo("/topic/roomId")
	public List<TestDTO> broadcasting(List<TestDTO> message) throws Exception{
		System.out.println("message: " + message);
		return message;
	}
	
	@MessageMapping("/out")
	@SendTo("/topic/out")
	public String outroom(String message) throws Exception{
		System.out.println("out message: " + message);
		return message;
	}
	
	@MessageMapping("/in")
	@SendTo("/topic/in")
	public String inroom(String message) throws Exception{
		System.out.println("in message: " + message);
		return message;
	}
}
