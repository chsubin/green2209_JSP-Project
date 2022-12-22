<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>title</title>
</head>
<script>
	'use strict';
		let msg = "${msg}";
		let url = "${url}";
		let val = "${val}";
	
		if(msg=="memJoinOk") msg = "회원가입이 되었습니다.\n가입 포인트 1,000점이 적립되었습니다.";
		else if(msg=="memJoinNo") msg = "회원가입 실패";
		else if(msg=="loginNo") msg = "로그인 실패";
		else if(msg=="loginNone") msg = "로그인 실패";
		else if(msg=="loginMem") msg = "회원 아이디로 로그인 해주시기 바랍니다.";
		else if(msg=="loginOk") msg = "${sMid}${val}님 로그인 되었습니다.";
		else if(msg=="logout") msg= val+"님 로그아웃 되었습니다.";
		else if(msg=="roomInputNo") msg = "객실 등록 실패";
		else if(msg=="roomInputOk") msg = "객실이 등록되었습니다.";
		else if(msg=="hotelReserveOk") msg = "예약되었습니다.";
		else if(msg=="hotelReserveNo") msg = "예약 실패";
		else if(msg=="memUpdateOk") msg = "정보수정 되었습니다.";
		else if(msg=="memUpdateNo") msg = "정보수정 실패";
		else if(msg=="deleteReservationOk") msg = "예약 취소 되었습니다.";
		else if(msg=="deleteReservationNo") msg = "예약 취소 실패~~";	
		else if(msg=="pdsInputOk") msg = "게시글이 등록되었습니다.";
		else if(msg=="pdsInputOkOk") msg = "게시글이 등록되었습니다. 1,000포인트가 적립되었습니다!";
		else if(msg=="pdsInputNo") msg = "게시글 등록 실패~~";
		else if(msg=="roomUpdateOk") msg = "객실 수정 완료!";
		else if(msg=="roomUpdateNo") msg = "객실 수정 실패~~";
		else if(msg=="pdsUpdateOk") msg = "게시글 수정 완료!";
		else if(msg=="pdsUpdateNo") msg = "게시글 수정 실패~~";
		else if(msg=="pdsDeleteOk") msg = "게시글 삭제 완료!!";
		else if(msg=="pdsDeleteNo") msg = "게시글 삭제 실패~~";

	
		alert(msg);
		location.href=url;

</script>
<body>
</body>
</html>