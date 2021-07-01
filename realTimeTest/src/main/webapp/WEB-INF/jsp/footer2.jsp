<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <script>
    //마지막 저장 내역
	var statusCount = "${listCount}";
	var seq = "${seq}";
	var crtDt = "${crtDt}";
	var subject = "${subject}";
	var contents = "${contents}";
	
    var cnt = 0;
 
     function sayHi() {
     
		  
		  	if(cnt == 0){
		   		cnt = localStorage.getItem("총 건수");
		    }
		    else if(cnt == 1){
		    	cnt = statusCount
		    }
			if(statusCount == cnt){
				
			}else if(statusCount != cnt && localStorage.getItem("LastSearchSubject") == localStorage.getItem("사업 명")){
				alert("최근 검색한 사업 명 "+ localStorage.getItem("LastSearchSubject") +"데이터가 변경되었습니다.");
				cnt = 1;
			}
			 //setTimeout(sayHi, 1000);
			 //setTimeout("location.reload()", 3000);
			 
		}
		setInterval(sayHi, 5000);
       
		
    </script>
	<div class="footer_bottom">
		<div class="layout">
		  	<address class="pc">
		       <p> <a href="http://www.mofa.go.kr" target="_blank"><img alt="외교부 로고" style="width: 52px; height: 65px;" src="<c:url value='/images/logo_footer.png'/>"></a>
			       03172 서울특별시 종로구 사직로8길 60 <a href="tel:+82-2-3210-0404">+82-2-3210-0404</a>
			       <a title="새창" href="http://www.wa.or.kr/board/list.asp?BoardID=0006" target="_blank">
		  	</address>
		</div>
	</div>