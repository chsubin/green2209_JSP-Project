<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
int sLevel =session.getAttribute("sLevel")==null? 99:(int) session.getAttribute("sLevel");
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>그린아트호텔</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/include/bs4.jsp"></jsp:include> 
  <jsp:include page="/include/hotel.jsp"></jsp:include>
  <style>
		/* ===================================================== */
		.container ul>li {
			font-size: 14pt;
		}
  </style>
</head>
<body>
<jsp:include page="/include/header.jsp"></jsp:include>
<div class="container" style="margin-top:60px;">
  <h2>멤버십 혜택</h2>
	<hr style="border : 1px solid #444"/>
  <h4>회원가입을 통해 아래 혜택을 누려보세요.</h4>
</div>
<div class="container-fluid" style="margin-top:30px;">
  <div style="height:20px"></div>
   <div class="row text-center p-5" style="background-color:lavender;">
    <div class="col p-2 pt-5 pb-5"><font style="font-size:40px"><i class='bx bxs-coupon'></i></font><h3>매달 말일 추첨을<br/> 통한 쿠폰 증정<br><br><br><a href="${ctp}/memCoupon.mem"  class="btn btn-outline-danger">참여하기</a></h3></div>
    <div class="col p-2 pt-5 pb-5"><font style="font-size:40px"><i class='bx bx-calendar-check' ></i></font><h3>객실 예약 시 <br/> 1%의 포인트 적립<br><br><br><a href="${ctp}/hotelReserve1.tel" class="btn btn-outline-warning">예약하러 가기</a></h3></div> <!-- 예약 -->
    <div class="col p-2 pt-5 pb-5"><font style="font-size:40px"><i class='bx bx-edit-alt' ></i></font><h3>후기 등록 시<br/> 1,000포인트 적립<br><br><br><a href="${ctp}/pdsList.pds" class="btn btn-outline-info">작성하러 가기</a></h3></div> <!-- 후기작성 -->
    <div class="col p-2 pt-5 pb-5"><font style="font-size:40px"><i class='bx bxs-discount'></i></font><h3>(VIP 회원)객실 예약 시 <br/>20% 할인<br><br><br></h3></div>
  </div>
  <div class="row text-center">
  	<div class="col">
  		<c:if test="${sLevel==99||sLevel==4}">
  			<h2 class="p-5"><a href="${ctp}/memJoin.mem" class="p-3 btn btn-lg btn-outline-success">가입하러가기<i class='bx bx-log-in'></i></a></h2>
  		</c:if>
  	</div>
  </div>
</div>

<div class="container" style="margin-top:30px;">
	<h3>유의사항</h3>
	<ul>
		<li>첫 회원가입시 1,000점이 적립됩니다. </li>
		<li>포인트는 10,000점 이상부터 객실 예약시 사용 가능합니다.</li>
		<li>객실 예약 취소 시 해당 예약건의 포인트는 자동 반환됩니다.</li>
		<li>포인트는 50,000점 이상 적립 시, 1년간 VIP회원으로 유지됩니다.</li>
		<li>매월 말, 경품추첨을 통해 3명의 회원에게 조식쿠폰이 증정됩니다.</li>
	</ul>
</div>
<p><br/></p>
<div style="height:100px"></div>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>