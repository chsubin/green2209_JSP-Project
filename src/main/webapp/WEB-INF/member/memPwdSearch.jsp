<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>그린아트호텔</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/include/bs4.jsp"></jsp:include> 
	<jsp:include page="/include/hotel.jsp"></jsp:include>
</head>
<script>
	'use strict';
	function pwdSearch(){
		let mid = $("#mid").val();
		let name = $("#name").val();
		let email = $("#email").val();
		
  	if(mid.trim() == "") {
  		alert("아이디를 입력하세요.");
  		$("#mid").focus();
  		return false;
  	}
  	else if(name.trim() == "") {
  		alert("이름을 입력하세요.");
  		$("#name").focus();
  		return false;
  	}
  	else if(email.trim() == "") {
  		alert("이름을 입력하세요.");
  		$("#email").focus();
  		return false;
  	}
		
		$.ajax({
			url:"${ctp}/memPwdSearchOk.mem",
			data: {
				mid: mid,
				name: name,
				email: email
				},
			success: function(res){
				if(res=="0") $("#demoid").html("<font color='red'>일치하는 정보가 없습니다.</font>");
				else if(res=="2") $("#demoid").html("<font color='red'>비밀번호 초기화 실패.</font>");
				else $("#demoid").html("새로운 비밀번호는 <b>"+res+"</b> 입니다.");
			},
			error : function(){
				alert("전송오류~~");
			}
		});
	}

</script>
<body>
<jsp:include page="/include/header.jsp"></jsp:include>
<div class="container" style="margin-top:30px;">
<div style="height:30px"></div>
	<h2>비밀번호 초기화</h2>
	<hr style="border : 1px solid #444"/>
	<form>
	  <br/><br/><h6 class="text-center">* 비밀번호를 초기화합니다.</h6>
		<div class="border mt-5" style="width:60%;margin:30px auto;background-color: #F6EFD7;">
			<table class="form-group p-5 text-center" style="width:80%;margin:20px auto">
				<tr>
					<td class="p-1" width="30%">아이디</td>
					<td width="70%"><input type="text" name="mid" id="mid" class="form-control"/></td>
				</tr>			
				<tr>
					<td class="p-1" width="30%">성명</td>
					<td width="70%"><input type="text" name="name" id="name" class="form-control"/></td>
				</tr>			
				<tr>
					<td class="p-1" width="30%">이메일</td>
					<td width="70%"><input type="text" name="email" id="email" class="form-control"/></td>
				</tr>
				<tr>
					<td colspan="2" class="p-3"><div id="demoid"></div></td>
				</tr>
				<tr>
					<td colspan="2" class="pt-3">
						<input type="button" class="btn btn-warning" onclick="location.href='${ctp}/memIdSearch.mem';" value="아이디 찾기"/>
						<input type="button" class="btn btn-success" onclick="pwdSearch()"  value="비밀번호 초기화"/>
					</td>
				</tr>
			</table>
		</div>
	</form>
</div>
<p><br/></p>
<div style="height:100px"></div>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>