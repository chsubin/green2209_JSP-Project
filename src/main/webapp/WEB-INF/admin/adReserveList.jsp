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
td{
	height : 150x;
}
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
 function fCheck(idx,sw){
		let ans = confirm("체크인(아웃) 하시겠습니까?");
		if(ans) {
			$.ajax({
				type  : "post",
				url   : "${ctp}/adReserveCheck.ad",
				data  : {idx:idx,
								sw : sw	
				},
				success:function(res) {
					if(res=="1"){
						alert("성공");
						location.reload();
					}
					else{
						alert("실패");
					}
				},
				error : function() {
					alert("전송 오류~~");
				}
			});
		}
 }
	 function changeDate(idx){
		 let rcheckIn = $("#rcheckIn"+idx).val();
		 let rcheckOut = $("#rcheckOut"+idx).val();
			$.ajax({
				type  : "post",
				url   : "${ctp}/adChangeDate.ad",
				data  : {idx:idx,
								rcheckIn:rcheckIn,
								rcheckOut:rcheckOut,
				},
				success:function(res) {
					if(res=="1"){
						alert("성공");
						location.reload();
					}
					else{
						alert("실패");
					}
				},
				error : function() {
					alert("전송 오류~~");
				}
			});
	 }
	 function DeleteDate(idx){
			$.ajax({
				type  : "post",
				url   : "${ctp}/adChangeDate.ad",
				data  : {idx:idx},
				success:function(res) {
					if(res=="1"){
						alert("성공");
						location.reload();
					}
					else{
						alert("실패");
					}
				},
				error : function() {
					alert("전송 오류~~");
				}
			});
	 }
	function dateSearch(){
		let startDate=$("#startDate").val();
		let lastDate=$("#lastDate").val();
		
		location.href= "${ctp}/adReserveList.ad?startDate="+startDate+"&lastDate="+lastDate;
	}
	function fSearch(){
		let startDate=$("#startDate").val();
		let lastDate=$("#lastDate").val();
		let searchName=$("#searchName").val();
		let rvSw=$("#rvSw").val();
		let part=$("#part").val();
		
		location.href= "${ctp}/adReserveSearchList.ad?startDate="+startDate+"&lastDate="+lastDate+"&rvSw="+rvSw+"&searchName="+searchName+"&part="+part;
	}
	function reserveDelete(idx){
		$.ajax({
			type  : "post",
			url   : "${ctp}/adReserveDelete.ad",
			data  : {idx:idx},
			success:function(res) {
				if(res=="1"){
					alert("삭제 성공");
					location.reload();
				}
				else{
					alert("삭제 실패");
				}
			},
			error : function() {
				alert("전송 오류~~");
			}
		});
	}

</script>
<body>
<jsp:include page="/include/adMenu.jsp"></jsp:include>
<p><br/></p>
<div class="main">
<div class="container-fluid">
  <div><h2 class="text-center">예약 현황</h2></div>
	<div style="height:60px"></div>
		<table width="100%">
			<tr class="text-right">
				<td>
					예약상태 :
					<select name="rvSw" id="rvSw">
						<option ${rvSw=='예약'?'selected':''}>예약</option>
						<option ${rvSw=='취소'?'selected':''}>취소</option>
					</select> 
				</td>
				<td>
					객실 :
					<select name="part" id="part">
						<option ${part=='스탠다드'?'selected':''}>스탠다드</option>
						<option ${part=='이그제큐티브'?'selected':''}>이그제큐티브</option>
						<option ${part=='스위트'?'selected':''}>스위트</option>
					</select> 
				</td>
				<td >
					예약자 : <input type="text" name="searchName" id="searchName" value="${searchName}" autofocus/>
				</td>
				<td >
					<input type="button" value="검색" onclick="fSearch()"/>
				</td>
				<th style="width:60%">
					<h5>
						<input type="date" name="startDate" id="startDate" style="font-weight:bold" value="${startDate}${yymmdd}"/> - 
						<input type="date" name="lastDate" id="lastDate" style="font-weight:bold" value="${lastDate}${yymmdd}"/>
						<input type="button" value="전체검색" onclick="dateSearch()" >
					</h5>
				</th>
			</tr>
		</table>
	

		<table class="table  table-hover search" id="searchTable">
			<tr class="bg-light text-center">
				<th>예약상태</th>
				<th>예약번호</th>
				<th>객실</th>
				<th>예약일시</th>
				<th>예약자</th>
				<th>아이디</th>
				<th>예약날짜</th>
				<th>체크인</th>
				<th>체크아웃</th>
				<th>가격</th>
				<th colspan="2">상세내역</th>
			</tr>
		<c:if test="${empty yymmdd&&empty startDate}">
			<tr><td colspan="10" class="text-center"><h4>날짜를 선택해주세요.</h4></td></tr>
		</c:if>
		<c:if test="${empty vos&&!empty yymmdd&&!empty startDate}">
			<tr><td colspan="10" class="text-center"><h4>해당 날짜에 예약 내역이 없습니다.</h4></td></tr>
		</c:if>
		<c:if test="${!empty vos}">		
			<tbody>
			<c:forEach var="vo" items="${vos}">
			
			
														  <!-- The Modal -->
					  <div class="modal fade" id="myModal${vo.idx}">
					    <div class="modal-dialog modal-md"> 
					      <div class="modal-content bg-light">
					      
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
						          <button type="button" class="btn btn-danger" onclick="reserveDelete('${vo.idx}','${vo.rvIdx}')">예약취소</button> <!-- AJAX처리 -->
						          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					          </form>
					        </div>
					      </div>
					    </div>
					  </div>
					  <!-- modal!!!!  -->
  <!-- modal!!!!  -->
	  <!-- The Modal -->
  <div class="modal fade" id="myCheckModal${vo.idx}">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">체크인(아웃) 시간변경</h4>
          <button type="button" class="close" data-dismiss="modal">×</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        <form name="myform${vo.idx}">
	        체크인 : <input type="text" class="form-control" placeholder="2022-01-01 15:00:00" name="rcheckIn${vo.idx}" id="rcheckIn${vo.idx}" value="${vo.rcheckIn}"/>
	        체크아웃 : <input type="text" class="form-control" placeholder="2022-01-02 14:00:00" name="rcheckOut${vo.idx}" id="rcheckOut${vo.idx}" value="${vo.rcheckOut}"/>
	        ex)2022-01-01 15:00:00<br/>
        </form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-warning" onclick="changeDate(${vo.idx})">수정</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="DeleteDate(${vo.idx})">삭제</button>
        </div>
        
      </div>
    </div>
  </div>
				
						<tr class="text-center">
							<td>
								<c:if test="${vo.rvSw=='취소'}"><font color="red">취소</font></c:if>
								<c:if test="${vo.rvSw=='예약'}"><font color="blue">예약</font></c:if>
							</td>
							<td>${vo.rvIdx}</td>
							<td>${vo.roomName}</td>
							<td>${fn:substring(vo.rvDay,0,19)}</td>
							<td>${vo.name}</td>
							<td>${vo.mid}
								<c:if test="${empty vo.mid}">비회원</c:if>
							</td>
							<td>${vo.checkIn}~${vo.checkOut}</td>
							<td><font color="blue"><b>${fn:substring(vo.rcheckIn,0,19)}</b></font>
								<c:if test="${vo.rcheckIn==null}"><button onclick="fCheck(${vo.idx},'rcheckIn')">checkIn</button></c:if>
								<c:if test="${vo.rcheckIn!=null}"><button class="badge badge-sm" data-toggle="modal" data-target="#myCheckModal${vo.idx}">수정</button></c:if>
							 </td>
							<td><font color="red"><b>${fn:substring(vo.rcheckOut,0,19)}</b></font>
								<c:if test="${vo.rcheckIn!=null&&vo.rcheckOut==null}"><button onclick="fCheck(${vo.idx},'rcheckOut')">checkOut</button></c:if>
							</td>
							<td><fmt:formatNumber value="${vo.price}" pattern="#,##0"/></td>
							<td><button class="badge btn-outline-warning" data-toggle="modal" data-target="#myModal${vo.idx}">보기</button></td>
							<td><button class="badge btn-outline-danger" onclick="reserveDelete(${vo.idx})">삭제</button></td>
						</tr>
						
				</c:forEach>
				<tr><td colspan="11"  class="m-0 p-0 text-center"></td></tr>
			</c:if>
		</table>
</div>
<div style="height:100px"></div>
<p><br/></p>
<p><br/></p>
</div>
</html>