package com.example.realTimeTest.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.realTimeTest.dto.SearchDTO;
import com.example.realTimeTest.dto.TestDTO;
import com.example.realTimeTest.service.DbService;

@Controller
public class TestController extends HttpServlet {

	@Autowired
	DbService dbService;

	
	  @RequestMapping("/") 
	  public ModelAndView main(@RequestParam(required = false) Map<String, Object> param) throws Exception {
		  
	  ModelAndView modelAndView = new ModelAndView(); 
	  int listCount = 0;

		List<TestDTO> list = new ArrayList<TestDTO>();
		list = dbService.getListLast(param);
		
		List<TestDTO> list2 = new ArrayList<TestDTO>();
		list2 = dbService.getList(param);
		listCount = list2.size();
	  
		modelAndView.addObject("listCount",listCount);
	    modelAndView.addObject("list", list);
	    
	    if(!list.isEmpty()) {
		modelAndView.addObject("seq", list.get(0).getSeq());
		modelAndView.addObject("crtDt", list.get(0).getCrtDt());
		modelAndView.addObject("subject", list.get(0).getSubject());
		modelAndView.addObject("contents", list.get(0).getContents());
	    }
		
	  modelAndView.setViewName("main");
	  
	  return modelAndView;
	  
	  }
	 
	@RequestMapping("/dbTest")
	public ModelAndView dbTest(@RequestParam(required = false) Map<String, Object> param) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		List<TestDTO> list = new ArrayList<TestDTO>();
		List<SearchDTO> listSearch = new ArrayList<SearchDTO>();
		int listCount = 0;
		int listCount2 = 0;
		// 마지막 저장 내역
		int seq = 0;
		String crtDt = null;
		String subject = null;
		String contents = null;

		// 마지막 검색 내역
		int seq2 = 0;
		String crtDt2 = null;
		String subject2 = null;
		String user = null;

		list = dbService.getList(param);
		listCount = list.size();
//
//		listSearch = dbService.getListSearch(param);
//		listCount2 = listSearch.size();
//
//		if (listCount != 0 && listCount2 != 0) {
//			seq = list.get(listCount - 1).getSeq();
//			crtDt = list.get(listCount - 1).getCrtDt();
//			subject = list.get(listCount - 1).getSubject();
//			contents = list.get(listCount - 1).getContents();
//
//			seq2 = listSearch.get(listCount2 - 1).getSeq();
//			crtDt2 = listSearch.get(listCount2 - 1).getCrtDt();
//			subject2 = listSearch.get(listCount2 - 1).getSubject();
//			user = listSearch.get(listCount2 - 1).getUser();
//		}
//
		modelAndView.addObject("listCount", listCount);
		modelAndView.addObject("list", list);
//		modelAndView.addObject("seq", seq);
//		modelAndView.addObject("crtDt", crtDt);
//		modelAndView.addObject("subject", subject);
//		modelAndView.addObject("contents", contents);
//
//		modelAndView.addObject("seq2", seq2);
//		modelAndView.addObject("crtDt2", crtDt2);
//		modelAndView.addObject("subject2", subject2);
//		modelAndView.addObject("user", user);

		modelAndView.addObject("schKeyword", param);
		modelAndView.setViewName("dbTest");

		return modelAndView;
	}
	
	
	@RequestMapping("/dbTest2")
	public ModelAndView dbTest2(@RequestParam(required = false) Map<String, Object> param) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		List<TestDTO> list = new ArrayList<TestDTO>();
		List<SearchDTO> listSearch = new ArrayList<SearchDTO>();
		int listCount = 0;
		int listCount2 = 0;
		// 마지막 저장 내역
		int seq = 0;
		String crtDt = null;
		String subject = null;
		String contents = null;

		// 마지막 검색 내역
		int seq2 = 0;
		String crtDt2 = null;
		String subject2 = null;
		String user = null;

		list = dbService.getList(param);
		listCount = list.size();

		modelAndView.addObject("listCount", listCount);
		modelAndView.addObject("list", list);

		modelAndView.addObject("schKeyword", param.get("keyword"));
		modelAndView.setViewName("dbTest2");

		return modelAndView;
	}

	@RequestMapping("/search")
	@ResponseBody
	public List<TestDTO> search(@RequestParam(required = false) Map<String, Object> param, Model model,
		HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		List<TestDTO> list = new ArrayList<TestDTO>();
		list = dbService.getList(param);

		dbService.insertList(param);

		model.addAttribute("list", list);
		return list;

	}

	@RequestMapping("/searchInterval")
	@ResponseBody
	public ResponseEntity searchInterval(@RequestParam(required = false) Map<String, Object> param, Model model,
		HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		Map<String,Object> map = new HashMap<>();
		// 마지막 저장 내역
		int listCount = 0;

		List<TestDTO> list = new ArrayList<TestDTO>();
		list = dbService.getListLast(param);
		
		List<TestDTO> list2 = new ArrayList<TestDTO>();
		list2 = dbService.getList(param);
		listCount = list2.size();
		
		map.put("list", list);
		map.put("listCount", listCount);
		//System.out.print("searchInterval");
		//System.out.print(listCount);
		return new ResponseEntity<>(map,HttpStatus.OK);

	}
	
}
