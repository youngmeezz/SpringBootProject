package com.example.realTimeTest.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.realTimeTest.dao.DbMapper;
import com.example.realTimeTest.dto.SearchDTO;
import com.example.realTimeTest.dto.TestDTO;

@Service
public class DbService {
   
   @Autowired
   DbMapper dbmapper;
   

public List<TestDTO> getList(Map<String, Object> param) {
	// TODO Auto-generated method stub
	  return dbmapper.getList(param);
}

public List<TestDTO> getListLast(Map<String, Object> param) {
	// TODO Auto-generated method stub
	  return dbmapper.getListLast(param);
}


public List<SearchDTO> getListSearch(Map<String, Object> param) {
	// TODO Auto-generated method stub
	  return dbmapper.getListSearch(param);
}


public void insertList(Map<String, Object> param) {
	// TODO Auto-generated method stub
		dbmapper.insertList(param);
	return ;
}

public List<SearchDTO> getSearchLast(Map<String, Object> param) {
	// TODO Auto-generated method stub
	return dbmapper.getListSearch(param);
}


}

