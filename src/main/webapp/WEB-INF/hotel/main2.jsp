<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<body>
<jsp:include page="/include/header2.jsp"></jsp:include>
<div class="container-fluid ml-0 mr-0 pl-0 pr-0" style="margin-top:30px;">
	<form name="myform" method="post" action="${ctp}/hotel/hotelReserve1.tel">
		<table class="table table-borderless p-0 m-0" style="text-align:center;">
			<tr class=" table border-bottom">
				<th style="width: 15%">  </th>
				<th><h5>체크인 <input type="date" name="checkIn" id="checkIn"  value="${checkIn}" onchange="replay()"/></h5></th>
				<th><h5><i class='bx bxs-moon' style="color:#555;font-size:30px;width:5%"></i></h5></th>
				<th><h5>체크아웃 <input type="date" name="checkOut" id="checkOut" value="${checkOut}" onchange="replay()"/></h5></th>
				<th><h5><i style="color:#555;font-size:30px" class='bx bx-male-female'></i></h5></th>
				<th><h5>
				 	<select>
				 		<option>1</option>
				 		<option selected>2</option>
				 		<option>3</option>
				 		<option>4</option>
				 	</select>명
				</h5></th>
				<th><h5><input type="submit" class="btn btn-secondary btn-lg" value="SEARCH"/></h5></th>
				<th style="width: 15%"></th>
			</tr>
		</table>
	</form>
	<table class="table table-borderless mt-0 mb-5 ml-0 mr-0" style="width:100%">
		<tr>
			<td width=30%>
				<div class="">
				  <div class="card-body pl-5">
						<a href="${ctp}/hotelInfor.tel"><img width="100%" src="${ctp}/image/크리스마스.jpg"/></a>			    	
				  	<h6 class="text-center">크리스마스를 그린아트와 함께</h6>
				  </div>
				</div>
			</td>
			<td>
				<div class="border">
					<div class="card" style="border:none">
					  <div class="card-body m-0 pt-0 pb-0">
					    <h3 class="card-title text-center">REVIEW</h3>
								<table class="table table-bordered table-hover table-responsive-sm text-center mt-0">
									<tr class="table-dark text-dark text-center">
										<th>객실이름</th>
										<th>방문날짜</th>
										<th width="40%">제목</th>
										<th>작성자</th>
										<th>작성일</th>
									</tr>
										<c:forEach var="pdsVo" items="${pdsVos}">
										<tr class="text-center bg-white">
											<td>${pdsVo.roomName}</td>
											<td>${pdsVo.checkIn}~${pdsVo.checkOut}</td>
											<td><a href="${ctp}/pdsContent.pds?idx=${pdsVo.idx}">${pdsVo.title}<c:if test="${pdsVo.hour_diff <= 24}"><div class="badge badge-danger">N</div> </c:if></a></td>
											<td>${pdsVo.mid}${pdsVo.midName}</td>
											<td>${fn:substring(pdsVo.fDate,0,10)}</td>
										</tr>
										</c:forEach>
									<tr><td colspan="7" class="m-0 p-0"></td></tr>
								</table>
					    <a href="${ctp}/hotelReserveList.tel" class="card-link">+more</a>
					  </div>
					</div>
					<br/>
					<div class="card"  style="border:none">
					  <div class="card-body m-0  pt-0">
					    <h3 class="card-title text-center">Q&A</h3>
								<table class="table table-bordered table-hover table-responsive-sm mt-0">
									<tr class="table-dark text-dark text-center">
										<th>닉네임</th>
										<th>문의사항</th>
										<th>작성일</th>
										<th>hostIP</th>
									</tr>
									<c:forEach var="qnaVo" items="${qnaVos}">
										<tr class="text-center bg-white">
											<td>${qnaVo.nickName}</td>
											<td>
												<c:if test="${qnaVo.content.length()>=40}">${fn:substring(qnaVo.content,0,60)}...</c:if>
			 							 		<c:if test="${qnaVo.content.length()<40}">${qnaVo.content}</c:if>										
											</td>
											<td>${fn:substring(qnaVo.day,0,10)}</td>
											<td>${qnaVo.hostIp}</td>
										</tr>
									</c:forEach>
									<tr><td colspan="7" class="m-0 p-0"></td></tr>
								</table>
					    <a href="${ctp}/qnaMain.qna" class="card-link">+more</a>
					  </div>
					</div>
				</div>
			</td>
		</tr>
	</table>
	<div>
		<div class="row">
			<div class="col sm-1"></div>
			<div class="col sm-10 padding: 0 auto">
				<iframe class="align-self-center" width="1400px" height="1000px" src="https://www.youtube.com/embed/1GjgpK_nWss?controls=0&autoplay=1&mute=1;playlist=1GjgpK_nWss&start=65" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
			</div>
			<div class="col sm-1"></div>
		</div>
	</div>
	<br/>

<div style="height:100px"></div>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>