package com.example.realTimeTest.dao;

import java.util.List;
import java.util.Map;

import com.example.realTimeTest.dto.SearchDTO;
import com.example.realTimeTest.dto.TestDTO;
 
public interface DbMapper {
    
	public List<TestDTO> getList(Map<String, Object> param);

	public List<TestDTO> getListLast(Map<String, Object> param);
	
	public void insertList(Map<String, Object> param);

	public List<SearchDTO> getListSearch(Map<String, Object> param);
}