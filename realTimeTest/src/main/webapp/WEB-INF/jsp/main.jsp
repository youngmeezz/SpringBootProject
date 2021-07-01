<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<meta charset="EUC-KR">
<title>메인 화면</title>
</head>
	 <!-- jquery load -->
<script src="/webjars/jquery/2.1.3/dist/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script>

function fn_movePage() {
		window.open("/dbTest");
}
</script>
<body>
	<input type="hidden" id="user" name="user" value="홍길동"></>
	<input type="hidden" id="keyword" name="keyword" value="${subject}"></>
    <h1>메인 화면 입니다.</h1>

    <button id="btn3" name="btn3" onclick="fn_movePage();">페이지 이동</button>
    <div id="result"></div>
    
     <!-- footer -->
	<footer id="footer_section" class="section fp-auto-height">
		<%@ include file="/WEB-INF/jsp/footer.jsp" %>
	</footer><!--// footer E-->
</body>
</html>
