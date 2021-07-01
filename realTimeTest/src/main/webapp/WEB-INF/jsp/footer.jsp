<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
<html>
<head>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
.swal-overlay--show-modal .swal-modal {
   margin-top: 30%;
   margin-left: 50%;
}
</style>
</head>
    <script>
   //마지막 저장 내역
var seq = "${seq}";
var crtDt = "${crtDt}";
var subject = "${subject}";
var contents = "${contents}";

	$(document).ready(function(){
		greet();
	});

	function greet(){
		console.log("greet start");
		var cnt = localStorage.getItem("검색된 총 건수");
		var lastKeyword = localStorage.getItem("LastSearchSubject");
		console.log("lastKeyword", lastKeyword);
		//이전 검색한 조건이 있을 경우만 ajax
		console.log("getItem cnt", cnt);
		if(lastKeyword != null && cnt != null){
		  $.ajax({ //비동기 방식 (페이지가 넘어가지 않고 그 페이지에서 바로 자료가 변경됨)
					    type : "post",
					    url :  "${pageContext.request.contextPath}/searchInterval?keyword=" + encodeURI(lastKeyword)+ "&user=" + encodeURI($("#user").val()),
				        success : function(data){
								console.log("success cnt=", cnt);
								
								if(data.listCount != cnt){
								
									localStorage.setItem('검색된 총 건수',data.listCount);	
									if(cnt != null){
										localStorage.setItem('순번',data.list[0].seq);
										localStorage.setItem('사업 명',data.list[0].subject);
										localStorage.setItem('사업 내용',data.list[0].contents);
										localStorage.setItem('생성 일자',data.list[0].crtDt);
									}
									swal("새로운 정보가 조회되었습니다.")
									.then(function(){
										window.open('/dbTest2?keyword='+encodeURI(lastKeyword), '_blank'); 
								
									});
								}
				    		}
				});
			}
			console.log("greet end.", new Date());
			setTimeout(greet, 10000);
		}
       
		
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