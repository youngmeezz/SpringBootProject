<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
 <!-- jquery load -->
<script src="/webjars/jquery/2.1.3/dist/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>

</script>
<body>
	<h1>Chatting Page</h1>
	<div>
		<input type="button" id="chattinglistbtn" value="채팅 참여자 리스트">
		<input type="button" id="outroom" value="채팅방 나가기">
	</div>
	<br>
	<div>
		<textarea id="chatOutput" name="" class="chatting_history" rows="30" cols="70"></textarea>
		<div class="chatting_input">
			<input id="chatInput" type="text" class="chat">&nbsp
			<input type="button" id="sendbtn" value="전송">
		</div>
	</div>
	<input type="hidden" value='${userid}' id="sessionuserid">
</body>
</html>
