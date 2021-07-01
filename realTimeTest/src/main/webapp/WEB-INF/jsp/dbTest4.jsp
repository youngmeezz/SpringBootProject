<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
 <!-- jquery load -->
<script src="/webjars/jquery/2.1.3/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="http://cdn.jsdelivr.net/sockjs/0.3.4/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
<meta charset="UTF-8">
<title>새로운 데이터가 조회된 화면</title>
</head>
<script>
//마지막 저장 내역
var statusCount = "${listCount}";
var seq = "${seq}";
var crtDt = "${crtDt}";
var subject = "${subject}";
var contents = "${contents}";


//마지막 검색 내역
var seq2 = "${seq2}";
var crtDt2 = "${crtDt2}";
var subject2 = "${subject2}";
var user = "${user}";
var keyword ="${schKeyword}";

	$(document).ready(function() {
 	
 		  $('#keyword').val(keyword);
	});
	
	function fn_selectReserve(){
		
	
		var url = "${pageContext.request.contextPath}/search?keyword=" + $("#keyword").val()+ "&user=" + $("#user").val();
		
		
		localStorage.setItem('순번', seq);
		localStorage.setItem('생성일자', crtDt);
		localStorage.setItem('사업 명', subject);
		localStorage.setItem('사업 내용', contents);
		
		localStorage.setItem('LastSearchSEQ', seq2);
		localStorage.setItem('LastSearchCrtDt', crtDt2);
		localStorage.setItem('LastSearchSubject', subject2);
		localStorage.setItem('LastSearchUser', user);
		
		$.ajax({ //비동기 방식 (페이지가 넘어가지 않고 그 페이지에서 바로 자료가 변경됨)
		    type : "post",
		    url : url,
		    success : function(result){
		    	console.log(result);
		    	localStorage.setItem('검색된 총 건수', result.length);
		    	$("#boardList").empty();
		    	document.getElementById("allCount").innerHTML = "총 " + (result.length) +" 건!";
		    	//$("#allCount").val("총 " +result.length +"건");
		    	document.getElementById('choose-address-table').style.display  = 'none';
		    	
		    	$("#count").val(seq); 
		    	$("#crtDt").val(crtDt);
		    	$("#subject").val(subject);
		    	$("#contents").val(contents);
		    	
		    	   
		    	    var str = '<tbody>';
		        	str += '<th>NO</th>';
		            str += '<th>생성일시</th>';
		            str += '<th>사업 명</th>';
		            str += '<th>사업 내용</th>';
		            str += '<TR>';
		            $.each(result , function(i){
		                str += '<TD>' + result[i].seq + '</TD><TD>' + result[i].crtDt + '</TD><TD>' + result[i].subject + '</TD><TD>' + result[i].contents + '</TD>';
		                str += '</TR>';
		           });
		           
		           str += '</tbody>';
		           $("#boardList").append(str); 
           
		       
		        console.log('success');
		    }
		});
}
	
</script>
<body>
	사용자 명 <input type="text" id="user" name="user" value="홍길동"></>
	<br>
	사업 검색 <input type="text" id="keyword" name="keyword" value="${keyword}"></>
    <button id="search" name="search" onclick="fn_selectReserve();">조회</button>
    <table id="choose-address-table" style="none" border = "1">
        <tbody>
        	<th>NO</th>
            <th>생성일시</th>
            <th>사업</th>
            <th>사업내용</th>
        <c:forEach var="list" items="${list}" varStatus="status">
            <tr>
            	<td id ='count'><p>${status.count}</p></td>
                <td id ='crtDt'><p>${list.crtDt}</p></td> 
                <td id ='subject'><p>${list.subject}</p></td>
                <td id ='contents'><p>${list.contents}</p></td>
            </tr>                                                    
        </c:forEach>
        	<td id="visitReserveTimeInfoInnerHtml"></td> 
         </tbody>
    </table>
    
    <div><table id = "boardList" border = "1"></table></div>
    
    <div id ="allCount">현재 총 건수 : "${listCount}"</div>

    <div id="result"></div>
  
</body>
</html>
