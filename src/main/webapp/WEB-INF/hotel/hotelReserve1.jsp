<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>hotelReserve1</title>
  <%@ include file="/include/bs4.jsp" %>
	<jsp:include page="/include/hotel.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/include/header.jsp"/>
<p><br/></p>
<div class="container">
	<div style="margin-top:60px"><h2>호텔 날짜 선택</h2></div>
  	<div style="height:20px"></div>
	<form name="myform" method="post" action="${ctp}/hotel/hotelReserve1.tel">
		<table class="table" style="text-align:center; border-top: 2px solid #444">
			<tr>
				<th><h5>체크인 <input type="date" name="checkIn" id="checkIn" style="font-weight:bold" value="${checkIn}" onchange="replay()"/></h5></th>
				<th><h5><i class='bx bxs-moon' style="color:#555;font-size:30px;width:5%"></i></h5></th>
				<th><h5>체크아웃 <input type="date" name="checkOut" id="checkOut" style="font-weight:bold" value="${checkOut}" onchange="replay()"/></h5></th>
				<th><h5><i style="color:#555;font-size:30px" class='bx bx-male-female'></i></h5></th>
				<th><h5>
				 	<select>
				 		<option>1</option>
				 		<option selected>2</option>
				 		<option>3</option>
				 		<option>4</option>
				 	</select>명
				</h5></th>
				<th style="width: 10%"></th>
				<th><h5><input type="submit" class="btn btn-outline-secondary" style="width:100px" value="검색"/></h5></th>
			</tr>
			<tr><td colspan="7"></td></tr>
		</table>
	</form>
	<c:set var="sw" value="0"></c:set>
	<c:forEach var="vo" items="${vos}" varStatus="st">
	<div class="row">
		<c:set var="sw" value="1"></c:set>
		<div class="col-sm-5">
			<c:set var="fSNames" value="${fn:split(vo.fSName,'/')}"></c:set>
			<img src="${ctp}/data/room/${fSNames[fn:length(fSNames)-1]}" width="100%"/>
		</div>
		<div class="col-sm-6">
			<h4><b>${vo.name}</b></h4><br/>
			<p>객실 크기 : ${vo.size}m<sup>2</sup><br/>
			가격 : <fmt:formatNumber value="${vo.price}" pattern="#,##0"/><br/>
			객실 수 : ${vo.numOfRoom}<br/>
		</div>
		<div class="col-sm-1">
			<form name="myform2" method="get" action="${ctp}/hotel/hotelReserve2.tel">
				<input type="button" value="예약하기" class="btn btn-secondary" onclick="fReserve(${vo.idx})" style="margin-top:80px">
			</form>
		</div>
	</div>
	<hr/>
</c:forEach>
	<c:if test="${sw==0}">
		<div class="row" style="height:300px;padding:30px">
			<div class="col-sm-12 text-center">
				<h3><font style="color:gray">날짜와 인원을 선택해주세요.</font></h3>
			</div>
		</div>
	</c:if>
</div>
<p><br/></p>
<div style="height:100px"></div>
<jsp:include page="/include/footer.jsp"/>
<script>
	'use strict';
	let sCheck=1;
	
	function replay() {
		sCheck=0;
	}
	
	
	function fReserve(idx){
		let checkIn = myform.checkIn.value;
		let checkOut = myform.checkOut.value;
		
		if(new Date(checkIn)>new Date(checkOut)){
			alert("체크인(아웃) 날짜를 확인해주세요.");
			return;
		}
		else if(new Date()>new Date(checkIn)){
			alert("체크인 날짜는 오늘 이전일 수 없습니다.");
			return;
		}
		else if(sCheck==0){
			alert("검색 버튼을 눌러주세요.");
			return;
		}

		location.href='${ctp}/hotel/hotelReserve2.tel?idx='+idx+'&checkIn='+checkIn+'&checkOut='+checkOut;
	}
	
	if(myform.checkIn.value==""){
		let today = new Date();
		let year = today.getFullYear(); // 연도 4자리 
		let month = today.getMonth() + 1; //월(기존월보다 1자리 작다.)
		let day = today.getDate()+1; //일
		let lastday = new Date(year,month,0).getDate();
		console.log(lastday);
		console.log(day);
		let date1;
		let date2;
		if (day==lastday){
			date1 = year+"-"+month+"-"+day;
			if(month==12){
				date2 = year+1+"-01-01";
			}
			else{date2 = year+"-"+(month+1)+"-"+"01";}
			
		}
		else if (day>lastday){
			if(month==12){
				date1 = year+"-01-01";
				date2 = year+"-01-02";
			}
			else{
				date1 = year+"-"+(month+1)+"-"+"01";
				date2 = year+"-"+(month+1)+"-"+"02";
			}
		}
		else {
			date1 = year+"-"+("0"+month).slice(-2)+"-"+("0"+day).slice(-2);
			date2 = year+"-"+("0"+month).slice(-2)+"-"+("0"+(day+1)).slice(-2);
		}
		console.log(date1);
		console.log(date2);
		
		myform.checkIn.value =date1;
		myform.checkOut.value =date2;
	}
//제이쿼리 사용!!!!
	$(function(){
		$("#checkOut").click(function(){
			myform.checkOut.value="";
			let date = new Date(myform.checkIn.value);
			let year = date.getFullYear(); // 연도 4자리 
			let month = date.getMonth() + 1; //월(기존월보다 1자리 작다.)
			let day= date.getDate(); //일
	    let lastday = new Date(year,month,0).getDate();
			let seldate;
			
			if (day==lastday){
				if(month!=12){
				seldate = year+"-"+("0"+month).slice(-2)+"-"+	"01";
				}
				else{
				seldate = year+1+"-01-01";
				}
			}
			else {
				seldate = year+"-"+("0"+month).slice(-2)+"-"+("0"+(day+1)).slice(-2);
			}
			console.log(seldate);
			myform.checkOut.value= seldate;
		});
	});
	
</script>
</body>
</html>