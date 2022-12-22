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
		.col-sm-4{
			font-weight:bold;
		}
	  label:hover {
	  	cursor:pointer;
	  }
  </style>
</head>
<script>
	'use strict';
	function sumitIdx(idx){
		myform.rvIdx.value=idx;
		let res = confirm("후기를 작성하시겠습니까?");
		if(res){
			myform.submit();
		}
	}
	function reserveDelete(idx,rvIdx,checkIn) {
			if(new Date()>new Date(checkIn)){
				alert("입실 당일 이후에는 예약을 취소하실 수 없습니다.");
				return;
			}
			
			let ans = confirm("예약 내역을 취소하시겠습니까?");
		  if(ans){$.ajax({
			    url : "${ctp}/memReserveDelete.mem",
			    type : "get",
				  data : {idx : idx , rvIdx:rvIdx}, // data:query,   ==> 서버의 전송구간
				  success: function(res){
			      if(res=="1"){
			    	  alert("예약이 취소되었습니다.");
			    	  location.reload();
			      }
			      else {
					  	alert("예약 취소 실패");		
			      }
			    },
			    error: function(){
					  	alert("전송 실패~~");		
			    }
			 });
		  }
		
		
	}

</script>
<body data-spy="scroll" data-target="#myScrollspy" data-offset="1">
<jsp:include page="/include/header.jsp"/>
<p><br/></p>
<div class="container-fluid pl-5 pr-5">
	<div style="height:60px"></div>
  <h2 class="text-center">예약내역 확인</h2>
  <hr style="border : 1px solid #444"/>
	<div style="height:60px"></div>
	<c:if test="${empty vos}">
		<h4 class=" pl-5 ml-5" style="height:150px">예약 내역이 없습니다.</h4>
		<h6  class=" pl-5 ml-5"><a href="${ctp}/hotelReserve1.tel">예약하러 가기</a></h6>
	</c:if>
	<c:if test="${!empty vos}">
		<h6>*예약번호를 체크하시면 후기를 등록하실 수 있습니다.</h6>
		<h6>*입실 당일 이후에는 취소하실 수 없습니다.</h6>
	</div>
	<div class="container-fluid p-5 text-center">
		<table class="table  table-hover" style="width:9s0%;margin:0 auto">
			<tr class="bg-light text-center">
			<th>예약상태</th>
			<th>예약번호</th>
			<th>객실</th>
			<th>예약일시</th>
			<th>예약자</th>
			<th>예약날짜</th>
			<th>체크인</th>
			<th>체크아웃</th>
			<th>가격</th>
			<th>상세내역</th>
			</tr>
			<c:forEach var="vo" items="${vos}">
			
														  <!-- The Modal -->
					  <div class="modal fade" id="myModal${vo.idx}">
					    <div class="modal-dialog modal-md"> 
					      <div class="modal-content">
					      
					        <!-- Modal Header -->
					        <div class="modal-header">
					          <h4 class="modal-title"><b>예약 상세 내역</b></h4>
					          <button type="button" class="close" data-dismiss="modal">&times;</button>
					        </div>
					        
					        <!-- Modal body -->
					        <div class="modal-body">
					        	<div class="table table-bordered">
											<div class="row pt-1">
												<div class="col col-sm-4">예약번호</div>
												<div class="col">${vo.rvIdx}</div>
											</div>
											<div class="row  pt-1">
												<div class="col col-sm-4">객실</div>
												<div class="col">${vo.roomName}</div>
											</div>
											<div class="row pt-1">
												<div class="col col-sm-4">예약일시</div>
												<div class="col">${vo.rvDay}</div>
											</div>
											<div class="row pt-1">
												<div class="col col-sm-4">인원</div>
												<div class="col">${vo.numOfCustom}</div>
											</div>
											<div class="row pt-1">
												<div class="col col-sm-4">체크인(아웃) 날짜</div>
												<div class="col">${vo.checkIn} ~ ${vo.checkOut}</div>
											</div>
											<div class="row pt-1">
												<div class="col col-sm-4">조식</div>
												<div class="col">성인${vo.adultF} , 어린이${vo.childF}</div>
											</div>
											<div class="row pt-1">
												<div class="col col-sm-4">성명</div>
												<div class="col">${vo.name}</div>
											</div>
											<div class="row pt-1">
												<div class="col col-sm-4">이메일</div>
												<div class="col">${vo.email}</div>
											</div>
											<div class="row pt-1">
												<div class="col col-sm-4">연락처</div>
												<div class="col">${vo.phoneNumber}</div>
											</div>
											<div class="row pt-1">
												<div class="col col-sm-4">거주지</div>
												<div class="col">${vo.city}</div>
											</div>
											<div class="row pt-1">
												<div class="col col-sm-4">예약상태</div>
												<div class="col">${vo.rvSw}</div>
											</div>
											<div class="row pt-1">
												<div class="col col-sm-4">추가요청사항</div>
												<div class="col">${vo.content}</div>
											</div>
						        </div>
					        </div>
					        <!-- Modal footer -->
					        <div class="modal-footer">
					        	<form>
						          <button type="button" class="btn btn-danger" onclick="reserveDelete('${vo.idx}','${vo.rvIdx}','${vo.checkIn}')">예약취소</button> <!-- AJAX처리 -->
						          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					          </form>
					        </div>
					      </div>
					    </div>
					  </div>
					  <!-- modal!!!!  -->
			
			
					<tr class="text-center">
						<td>
							<c:if test="${vo.rvSw=='취소'}"><font color="red">취소</font></c:if>
							<c:if test="${vo.rvSw=='예약'}"><font color="blue">예약</font></c:if>
						</td>
						<c:if test="${vo.rvSw=='예약'&&!empty vo.rcheckIn}"><td><input type="radio" name="idx" id="idx${vo.rvIdx}" value="${vo.rvIdx}" onclick="sumitIdx('${vo.rvIdx}')"><label for= "idx${vo.rvIdx}">&nbsp;${vo.rvIdx}</label></td></c:if>
						<c:if test="${vo.rvSw=='취소'||empty vo.rcheckIn}"><td>&nbsp;${vo.rvIdx}</td></c:if>
						<td class="text-left">${vo.roomName}</td>
						<td>${fn:substring(vo.rvDay,0,19)}</td>
						<td>${vo.name}</td>
						<td>${vo.checkIn}~${vo.checkOut}</td>
						<td><font color="red">${vo.rcheckIn}</font></td>
						<td><font color="blue">${vo.rcheckOut}</font></td>
						<td><fmt:formatNumber value="${vo.price}" pattern="#,##0"/></td>
						<td><button class="badge" data-toggle="modal" data-target="#myModal${vo.idx}">보기</button></td>
					</tr>

			</c:forEach>
			<tr><td colspan="11"  class="m-0 p-0 text-center"></td></tr>
		</table>
</c:if>
		<table class=" text-center mt-5" width="100%">
			<tr class="text-center"><td>
				<form name="myform" action="${ctp}/pdsInput.pds" method="post">
					<input type="button" value="MYPAGE" onclick="location.href='${ctp}/memMain.mem';" class="btn btn-info"/>
					<input type="button" value="REVIEW" onclick="location.href='${ctp}/pdsList.pds';" class="btn btn-secondary"/>
					<input type="hidden" name="rvIdx">
				</form>
			</td></tr>
		</table>
</div>
<div style="height:100px"></div>
<p><br/></p>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>