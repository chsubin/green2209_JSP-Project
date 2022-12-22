<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>그린아트호텔</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/include/bs4.jsp"></jsp:include> 
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
	<jsp:include page="/include/modalImage.jsp"/>
<style>
body {font-family: "Lato", sans-serif;}

.sidebar {
  height: 100%;
  width: 190px;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #111;
  overflow-x: hidden;
  padding-top: 16px;
}

.sidebar a {
  padding: 6px 8px 6px 16px;
  text-decoration: none;
  font-size: 20px;
  color: #818181;
  display: block;
}

.sidebar a:hover {
  color: #f1f1f1;
}

.main {
  margin-left: 190px; /* Same as the width of the sidenav */
  padding: 0px 10px;
}

@media screen and (max-height: 450px) {
  .sidebar {padding-top: 15px;}
  .sidebar a {font-size: 18px;}
}
</style>
</head>
<script>
	'use strict';
	function searchMid() {
	  $.ajax({
		     url : "${ctp}/adCouponMidSearch.ad",
		     type : "get",
			   data : {}, // data:query,   ==> 서버의 전송구간
		  	  success: function(res){
		  		  myform.mid.value=res;
		      },
		    error: function(){
				  	alert("전송 실패~~");		
		    }
		 });
	}  
	function couponInput() {
		let title = myform.title.value;
		let mid = myform.mid.value;
		let startDay = myform.startDay.value;
		let lastDay = myform.lastDay.value;
		let price = myform.price.value;
		let content = myform.content.value;
		
	  $.ajax({
		     url : "${ctp}/adCouponInput.ad",
		     type : "get",
			   data : {
				   title: title,
				   mid:mid,
				   startDay:startDay,
				   lastDay:lastDay,
				   price:price,
				   content:content
			   }, // data:query,   ==> 서버의 전송구간
		  	  success: function(res){
						alert("쿠폰 발급 완료.");
						location.reload();
		      },
		    error: function(){
				  	alert("전송 실패~~");		
		    }
		 });
	}  
	function couponCancle(idx) {
		  $.ajax({
			     url : "${ctp}/adCouponDelete.ad",
			     type : "get",
				   data : {
					   idx:idx
				   }, // data:query,   ==> 서버의 전송구간
			  	  success: function(res){
			  		  if(res==1){
								alert("쿠폰 취소 성공.");
								location.reload();
							}
			  		  else{
								alert("쿠폰 취소 실패")	;		  			  
			  		  }
			      },
			    error: function(){
					  	alert("전송 실패~~");		
			    }
			 });
	}
</script>
<body >
<jsp:include page="/include/adMenu.jsp"></jsp:include>
<p><br/></p>
<div class="main">
<div class="container-fluid" style="margin-top:30px;">
	<h2 class="text-center">랜덤 쿠폰 발급</h2>
	<div style="height:30px"></div>
	<br/>
	<h4>발급하기</h4>
	<form name="myform" method="post" action="${ctp}/adCouponInput.ad">
		 <table class="table table-bordered">
			<tr>
			  <th style="width:20%;">이름</th>
			  <td style="width:25%;"><input type="text" name="title" class="form-control"/></td>
			  <th style="width:20%;">아이디</th>
			  <td style="width:35%;">
			  	<input type="text" name="mid" readonly="readonly"/>
			  	<input type="button" value="돌리기" onclick="searchMid()"/>
			 	</td>
			</tr>
			<tr>
			  <th style="width:20%;">기간</th>
			  <td style="width:25%;">
			  	<input type="date" name="startDay"/> ~ 
			  	<input type="date" name="lastDay"/>
			  </td>
			  <th style="width:20%;">가격</th>
			  <td style="width:35%;"><input type="number" name="price" class="form-control"/></td>
			</tr>
			<tr>
			  <th>상세 설명</th>
			  <td colspan="3"><textarea name="content" rows="3"  class="form-control"></textarea></td>
			</tr>
	  </table>
	  <table class="table table-borderless">
	  	<tr class="text-center">
	  		<td><input type="button" class="btn btn-success" value="발급하기" onclick="couponInput()"/>
	  		<input type="button" class="btn btn-warning" value="다시쓰기"/></td>
	  	</tr>
	  </table>
	 </form>
	<br/><br/>
	<h4>쿠폰 현황</h4>
	<table class="table mb-0">
 	 <tr style="background-color:lavender" class="text-center">
	  	<th width="5%">쿠폰번호</th>
	  	<th width="15%">쿠폰이름</th>
	  	<th width="15%">가격</th>
	  	<th width="15%">발급일</th>
	  	<th width="15%">만료일</th>
	  	<th width="10%">사용여부</th>
	  	<th>당첨자</th>
	  	<th width="10%"></th>
	  	<th></th>
  	</tr>
  </table>
	<c:forEach var="vo" items="${vos}" varStatus="st">
	  <table class="table table mb-0 text-center">
	  	<tr>
		  	<td width="5%" class="text-center">${vo.idx}</td>
		  	<td width="15%">${vo.title}</td>
		  	<td width="15%">${vo.price}</td>
		  	<td width="15%" class="text-center">${fn:substring(vo.startDay,0,11)}</td>
		  	<td width="15%" class="text-center">${fn:substring(vo.lastDay,0,11)}</td>
		  	<td width="10%">${vo.useSw}</td>
		  	<td data-toggle="modal" data-target="#myModal">${vo.mid}</td>
		  	<td width="10%"><input type="button" class="btn badge-danger btn-sm" value="발급 취소" onclick="couponCancle(${vo.idx})"></td>
	  	</tr>
	  </table>

	</c:forEach>
	<hr class="m-0 p-0"/>
	  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3(6) / 다음블록 / 마지막페이지 -->
  <div class="text-center mt-5">
    <ul class="pagination justify-content-center">
	    <c:if test="${pag > 1}">
	      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/adCoupon.ad?pag=1"><i class='bx bx-first-page' ></i></a></li>
	    </c:if>
	    <c:if test="${curBlock > 0}">
	      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/adCoupon.ad?pag=${(curBlock-1)*blockSize + 1}"><i class='bx bx-chevron-left' ></i></a></li>
	    </c:if>
	    <c:forEach var="i" begin="${(curBlock)*blockSize + 1}" end="${(curBlock)*blockSize + blockSize}" varStatus="st">
	      <c:if test="${i <= totPage && i == pag}">
	    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/adCoupon.ad?pag=${i}">${i}</a></li>
	    	</c:if>
	      <c:if test="${i <= totPage && i != pag}">
	    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/adCoupon.ad?pag=${i}">${i}</a></li>
	    	</c:if>
	    </c:forEach>
	    <c:if test="${curBlock < lastBlock}">
	      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/adCoupon.ad?pag=${(curBlock+1)*blockSize + 1}"><i class='bx bx-chevron-right' ></i></a></li>
	    </c:if>
	    <c:if test="${pag < totPage}">
	      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/adCoupon.ad?pag=${totPage}"><i class='bx bx-last-page'></i></a></li>
	    </c:if>
    </ul>
  </div>
	
	</div>
</div>
<p><br/></p>
</body>
<script>
function myFunction(imgs,idx) {
	  var expandImg = document.getElementById("expandedImg"+idx);
	  expandImg.src = imgs.src;
	}
</script>
</html>
