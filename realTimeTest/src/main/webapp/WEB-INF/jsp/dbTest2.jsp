<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
 <!-- jquery load -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="http://cdn.jsdelivr.net/sockjs/0.3.4/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<meta charset="UTF-8">
<title>새로운 데이터가 조회된 화면</title>
<style>
table.type10 {
  border-collapse: collapse;
  text-align: left;
  line-height: 1.5;
  border-top: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
  margin: 20px 10px;
}
table.type10 thead th {
  width: 155px;
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  color: #fff;
  background: #ce4869 ;
}
table.type10 tbody th {
  width: 150px;
  padding: 10px;
}
table.type10 td {
  padding: 10px;
  vertical-align: top;
}
table.type10 .even {
  background: #e3f2fd;
}

</style>
</head>
<script>
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
	
		//검색 조건 추가
		var url = "${pageContext.request.contextPath}/search?keyword=" + encodeURI($("#keyword").val())+ "&user=" + encodeURI($("#user").val());
		
		$.ajax({ //비동기 방식 (페이지가 넘어가지 않고 그 페이지에서 바로 자료가 변경됨)
		    type : "post",
		    url : url,
		    success : function(result){
		    	localStorage.setItem('검색된 총 건수', result.length);
				let today = new Date();   
				localStorage.setItem('LastSearchCrtDt', today);
				localStorage.setItem('LastSearchSubject', $("#keyword").val());
				localStorage.setItem('LastSearchUser', $("#user").val());
				
		    	$("#boardList").empty();
		    	document.getElementById("allCount").innerHTML = "총 " + (result.length) +" 건의 데이터가 조회되었습니다.";
		    	document.getElementById('choose-address-table').style.display  = 'none';
		    	
		    	$("#count").val(seq); 
		    	$("#crtDt").val(crtDt);
		    	$("#subject").val(subject);
		    	$("#contents").val(contents);
		    	
		    	   
		    	    var str = '<tbody>';
		        	str += '<th scope="cols" class="even">NO</th>';
		            str += '<th scope="cols" class="even" >사업 명</th>';
		            str += '<th scope="cols" class="even" >사업 내용</th>';
		            str += '<th scope="cols" class="even" >생성일시</th>';
		            str += '<tr>';
		            $.each(result , function(i){
		                str += '<td class="even">' + result[i].seq + '</td><td>' + result[i].crtDt + '</td><td>' + result[i].subject + '</td><td>' + result[i].contents + '</td>';
		                str += '</tr>';
		           });
		           str += '</tbody>';
		           $("#boardList").append(str); 
		    }
		});
}
	
</script>
<body>
	<input type="text" id="user" name="user" value="홍길동" placeholder="사용자 명 입력" style="border: none; text-align: center;" readOnly="readOnly"></input>
	님의 최근 검색 데이터가 변경되었습니다.
	<br>
	<input type="text" id="keyword" name="keyword" placeholder="사업 명 입력" value="" style="align: center;width: 1000px;margin-left: 450px;height: 30px;">
    
    <button id="search" class="style-scope ytd-searchbox" style="width:30px; height:30px;"  onclick="fn_selectReserve();" aria-label="사업명 검색">
    <yt-icon class="style-scope ytd-searchbox"><svg viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet" focusable="false" class="style-scope yt-icon" style="pointer-events: none; display: block; width: 100%; height: 100%;"><g class="style-scope yt-icon"><path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z" class="style-scope yt-icon"></path></g></svg><!--css-build:shady--></yt-icon>
    <tp-yt-paper-tooltip prefix="" class="style-scope ytd-searchbox" role="tooltip" tabindex="-1" style="left: 527.5px; top: 57px;"><!--css-build:shady-->
    

</tp-yt-paper-tooltip>
  </button>
   <div><table id="boardList" class="type10"></table></div>
    <div id ="allCount">현재 사업 총 건수 : "${listCount}"</div>
    
    <table id="choose-address-table" style="none" class="type10">
        <tbody>
        	<th scope="cols" class="even">NO</th>
            <th scope="cols" class="even">사업</th>
            <th scope="cols" class="even">사업내용</th>
             <th scope="cols" class="even">생성일시</th>
        <c:forEach var="list" items="${list}" varStatus="status">
            <tr>
            	<td id ='count' class="even"><p>${status.count}</p></td>
                <td id ='subject'><p>${list.subject}</p></td>
                <td id ='contents'><p>${list.contents}</p></td>
                <td id ='crtDt'><p>${list.crtDt}</p></td> 
            </tr>                                                    
        </c:forEach>
         </tbody>
    </table>
    
    
    

    <div id="result"></div>
    
    <!-- footer -->
	
	<footer id="footer_section" class="section fp-auto-height">
		<%@ include file="/WEB-INF/jsp/footer.jsp" %>
	</footer><!--// footer E-->
	 
</body>
</html>

