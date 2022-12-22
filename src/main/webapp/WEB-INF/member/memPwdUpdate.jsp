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
		let originPwd = $("#originPwd").val();
		let newPwd = $("#newPwd").val();
		let pwdConfirm = $("#pwdConfirm").val();
		
  	if(originPwd.trim() == "") {
  		alert("현재 비밀번호를 입력하세요.");
  		$("#originPwd").focus();
  		return false;
  	}
  	else if(newPwd.trim() == "") {
  		alert("새로운 비밀번호를 입력하세요.");
  		$("#newPwd").focus();
  		return false;
  	}
  	else if(newPwd!=pwdConfirm) {
  		alert("새 비밀번호와 비밀번호 확인이 서로 다릅니다.");
  		$("#newPwd").focus();
  		return false;
  	}
  	else if(newPwd==originPwd) {
  		alert("현재 비밀번호와 새 비밀번호가 서로 같습니다.");
  		$("#newPwd").focus();
  		return false;
  	}
		
		$.ajax({
			url:"${ctp}/memPwdUpdateOk.mem",
			data: {
				originPwd: originPwd,
				newPwd: newPwd,
				pwdConfirm: pwdConfirm
				},
			success: function(res){
				if(res=="2") alert("현재 비밀번호가 일치하지 않습니다.");
				else if(res=="0") alert("실패");
				else {
					alert("비밀번호가 변경되었습니다.");
					location.href='${ctp}/memMain.mem';
				}
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
	<h2>비밀번호 변경</h2>
	<hr style="border : 1px solid #444"/>
	<form>
		<div class="border mt-5" style="width:60%;margin:30px auto;background-color: #F6EFD7;">
		  <div style="height:20px"></div>
			<p class="text-center"> 비밀번호를 변경합니다.</p>
			<table class="form-group p-5 text-center" style="width:80%;margin:20px auto">
				<tr>
					<td class="p-1" width="30%">현재 비밀번호</td>
					<td width="70%"><input type="password" name="originPwd" id="originPwd" class="form-control"/></td>
				</tr>			
				<tr>
					<td class="p-1" width="30%">새 비밀번호</td>
					<td width="70%"><input type="password" name="newPwd" id="newPwd" class="form-control"/></td>
				</tr>			
				<tr>
					<td class="p-1" width="30%">비밀번호 확인</td>
					<td width="70%"><input type="password" name="pwdConfirm" id="pwdConfirm" class="form-control"/></td>
				</tr>
				<tr>
					<td colspan="2" class="p-3"><div id="demoid"></div></td>
				</tr>
				<tr>
					<td colspan="2" class="pt-3">
						<input type="button" class="btn btn-success" onclick="location.href='${ctp}/memMain.mem';" value="돌아가기"/>
						<input type="button" class="btn btn-warning" onclick="pwdSearch()"  value="비밀번호 변경"/>
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