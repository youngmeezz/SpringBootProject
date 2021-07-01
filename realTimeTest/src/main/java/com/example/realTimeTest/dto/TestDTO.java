package com.example.realTimeTest.dto;

import antlr.collections.List;

public class TestDTO {
    
	private int seq;
    private String crtDt;
    private String subject;
    private String contents;
    
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getCrtDt() {
		return crtDt;
	}
	public void setCrtDt(String crtDt) {
		this.crtDt = crtDt;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}


    public static class TestWapper{
        private List data;
    }
   
 
}
 
