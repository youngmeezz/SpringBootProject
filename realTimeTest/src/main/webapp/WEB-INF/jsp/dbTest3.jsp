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
<title>Insert title here</title>
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

	$(document).ready(function() {
 	
 		fn_selectReserve();
	});
	
	function greet(){
		console.log("greet start");
		  $.ajax({ //비동기 방식 (페이지가 넘어가지 않고 그 페이지에서 바로 자료가 변경됨)
					    type : "post",
					    url :  "${pageContext.request.contextPath}/searchInterval?keyword=" + $("#keyword").val()+ "&user=" + $("#user").val(),
				        success : function(data){
							var cnt = localStorage.getItem("검색된 총 건수"); //이전에 검색된 33건 -> 데이터베이스 값 하나 34건 data.length
								console.log("success cnt=", cnt);
								if(data.listCount == cnt){
									 
								}else if(data.listCount != cnt){
									alert("데이터가 변경되었습니다.");
									localStorage.setItem('검색된 총 건수',data.listCount);	
									localStorage.setItem('순번', seq);
									localStorage.setItem('생성일자', crtDt);
									localStorage.setItem('사업 명', subject);
									localStorage.setItem('사업 내용', contents);
								}
								
								setTimeout(greet, 10000);
								console.log("111");
				    		}
				});
		}
	console.log("222");
	setTimeout(greet, 10000);
	
	
	function connect(){
	
	    $("#connect").val("on");
		var socket = new SockJS("/websockethandler");
		stompClient = Stomp.over(socket);
		
		stompClient.connect({}, function(){
		
			//메시지를 받는다 각각 구독
			stompClient.subscribe('/topic/roomId', function(msg){
				printMessage(JSON.parse(msg.body).sendMessage + '/' + JSON.parse(msg.body).senderName);
			});
			
			stompClient.subscribe('/topic/out', function(msg){
				printMessage(msg.body);
			});
			
			stompClient.subscribe('/topic/in', function(msg){
				printMessage(msg.body);
			});
			
			//입장글//
			//stompClient.send("/app/in",{}, usersessionId.value + ' is in chatroom');
			stompClient.send("/app/in",{} + ' 테스트 is in chatroom');
		});
	}
	
	function disconnect(){
	$("#connect").val("")
	if(stompClient !== null){
		stompClient.send("/app/out", {}  + '테스트 is out chatroom');
		stompClient.disconnect();
		}
	}
	
	function sendMessage(text){
		stompClient.send("/app/hello", {}, JSON.stringify({'sendMessage':text, 'senderName':'' + usersessionid.value}));
	}
	
	function fn_selectReserve(){
		
		//connect 이후에 눌러줘야됨 조회는
		if($("#connect").val() == "on"){
		 stompClient.send("/app/hello", {}, JSON.stringify([{"keyword": $("#keyword").val() , "user": $("#user").val() }]));
		 var url = "${pageContext.request.contextPath}/search?keyword=" + $("#keyword").val();
		 }else{
		//검색 조건 추가
		//var url = "${pageContext.request.contextPath}/search?keyword=" + $("#keyword").val()+ "&user=" + $("#user").val();
		 var url = "${pageContext.request.contextPath}/search?keyword=" + $("#keyword").val()+ "&user=" + $("#user").val();
		}
		
		
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
	사용자 명 <input type="text" id="user" name="user" value="aa"></>
	<br>
	사업 검색 <input type="text" id="keyword" name="keyword" value="${param.schKeyword}"></>
    <button id="search" name="search" onclick="fn_selectReserve();">조회</button>
    <button id="connect" name="connect" value="" onclick="connect();">connect</button>
    <button id="disconnect" name="disconnect" onclick="disconnect();">disconnect</button>
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
    
    <!-- footer -->
	<footer id="footer_section" class="section fp-auto-height">
		<%@ include file="/WEB-INF/jsp/footer.jsp" %>
	</footer><!--// footer E-->
</body>
</html>
