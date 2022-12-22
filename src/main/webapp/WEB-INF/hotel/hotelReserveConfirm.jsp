<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>hotelReserve.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
<!--   <link rel="stylesheet" type="text/css" href="form.css"> -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<jsp:include page="/include/hotel.jsp"></jsp:include>
  <style>
		/*=-----------------------------*/
		th {
		 width : 20%;
		 background-color: #F6EFD7;
		}
  </style>
</head>
<script>
	'use strict';
	function fCheck(){
		if(new Date()>new Date("${vo.checkIn}")){
			alert("입실 당일에는 예약을 취소하실 수 없습니다.");
			return;
		}
		
		let res = confirm("예약 내역을 취소하시겠습니까?");
		if(res){
			myform.submit();		
		}
		else{
			return;
		}
		
	}
</script>
<body data-spy="scroll" data-target="#myScrollspy" data-offset="1">
<jsp:include page="/include/header.jsp"/>
<p><br/></p>
<div class="container">
	<div style="height:30px"></div>
  <div><h2>예약내역 확인</h2></div>
	<div style="height:30px"></div>
	<hr style="border : 1px solid #444"/>
	<h6>*입실 당일 이후에는 취소하실 수 없습니다.</h6>
	<c:if test="${empty vo}">
		<h4>해당하는 예약 내역이 없습니다.</h4>
	</c:if>
	<c:if test="${!empty vo}">
  	<div><h4>예약 정보</h4></div>
	  <table class="table table-bordered">
			<tr>
				<th>예약번호</th>
				<td>${vo.rvIdx}</td>
			</tr>
			<tr>
				<th>객실</th>
				<td>${vo.roomName}</td>
			</tr>
			<tr>
				<th>예약일시</th>
				<td>${vo.rvDay}</td>
			</tr>
			<tr>
				<th>인원</th>
				<td>${vo.numOfCustom}</td>
			</tr>
			<tr>
				<th>체크인(아웃) 날짜</th>
				<td>${vo.checkIn} - ${vo.checkOut}</td>
			</tr>
			<tr>
				<th>조식</th>
				<td>성인${vo.adultF} , 어린이${vo.childF}</td>
			</tr>
			<tr>
				<th>가격</th>
				<td><fmt:formatNumber value="${vo.price}" pattern="#,##0"/></td>
			</tr>
			<tr>
				<th>상세요청사항</th>
				<td>${vo.content}</td>
			</tr>
			<tr>
				<td colspan="2" class="m-0 p-0"></td>
			</tr>
		</table>
  	<div><h4>결제 정보</h4></div>
		<table class="table table-bordered">
			<tr>
				<th>성명</th>
				<td>${vo.name}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${vo.email}</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>${vo.phoneNumber}</td>
			</tr>
			<tr>
				<th>거주지</th>
				<td>${vo.city}</td>
			</tr>
			<tr>
				<th>카드</th>
				<td>${vo.cardName}</td>
			</tr>
			<tr>
				<th>카드번호</th>
				<td>${vo.cardNumber}</td>
			</tr>
			<tr>
				<th>만료일자</th>
				<td>${vo.expiration}</td>
			</tr>
			<tr>
				<th>예약상태</th>
				<td>${vo.rvSw}</td>
			</tr>
			<tr>
				<td colspan="2" class="text-center mt-3">
					<form name="myform" method="post" action="${ctp}/hotelReserveDelete.tel">
						<input type="hidden" name="idx" value="${vo.idx}"/>
						<input type="hidden" name="rvIdx" value="${vo.rvIdx}"/>
						<input type="button" value="취소" class="btn btn-danger" onclick="fCheck()"/> <!-- 예약번호 넘겨서 삭제 처리! -->
						<a href="${ctp}/" class="btn btn-success">Home</a>
					</form>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="m-0 p-0"></td>
			</tr>
		</table>
	</c:if>
</div>
<div style="height:100px"></div>
<p><br/></p>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>