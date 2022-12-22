<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memIdCheck.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
	<jsp:include page="/include/hotel.jsp"></jsp:include>
  <script>
  	'use strict';
  	
  	opener.window.document.myform.mid.value ="";
  	//중복 아이디 재검색하기
  	function idCheck(){
  		let mid = childForm.mid.value;
  		
  		if(mid.trim()==""){
  			alert("아이디를 입력하세요!");
  			childForm.mid.focus();
  		}
  		else {
  			childForm.submit();
  		}
  		
  	}
  	function sendCheck(){
  		opener.window.document.myform.mid.value ='${mid}';
  		opener.window.document.myform.pwd.focus();

  		window.close()
  	}
  
  </script>
</head>
<body>
<div class="container">
	<br/>
	<h3 class="text-center">아이디 중복확인</h3>
	<hr/>
	<c:if test="${res==1}">
		<h4 class="text-center"><font color="blue"><b>${mid}</b></font> 아이디는 사용 가능합니다.</h4>
		<br/>
		<p class="text-right"><input type="button" value="창닫기" onclick="sendCheck()"/></p>
	</c:if>
	<c:if test="${res!=1}">
		<h4 class="text-center"><font color="blue"><b>${mid}</b></font> 아이디는 이미 사용중인 아이디입니다.</h4>
		<form name="childForm" method="post" action="${ctp}/memIdCheck.mem"><br/>
			<P>
				<input type="text" name="mid"/>
				<input type="button" value="아이디재검색" onclick="idCheck()"/>	
			</P>
		</form>
	</c:if>
</div>
<p><br/></p>
</body>
</html>