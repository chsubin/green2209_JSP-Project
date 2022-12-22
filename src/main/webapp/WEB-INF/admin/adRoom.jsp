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
  function partCheck() {
  	let part = partForm.part.value;
  	location.href = "${ctp}/adRoom.ad?part="+part;
  }
</script>
<body >
<jsp:include page="/include/adMenu.jsp"></jsp:include>
<p><br/></p>
<div class="main">
	<h2 class="text-center">객 실 리 스 트</h2>
	  <table class="table table-borderless m-0 p-0">
    <tr class=" m-0 p-0">
      <td style="width:20%" class="text-left m-0 p-0" >
        <form name="partForm">
        	<select name="part" onchange="partCheck()" class="form-control">
        	  <option value="스탠다드" ${part == '스탠다드' ? 'selected' : ''}>스탠다드</option>
        	  <option value="이그제큐티브" ${part == '이그제큐티브' ? 'selected' : ''}>이그제큐티브</option>
        	  <option value="스위트" ${part == '스위트' ? 'selected' : ''}>스위트</option>
        	</select>
        </form>
      </td>
      <td class="text-right m-0 p-0">
      	<a href="${ctp}/adRoomInput.ad?part=${part}&pag=${pag}" class="btn btn-success">객실 등록</a>
      </td>
    </tr>
  </table>
	<hr/>
	<c:forEach var="vo" items="${vos}" varStatus="st">
		<div class="row  m-0 p-0">
			
			<div class="col-sm-5  m-0 p-0">
				<button class="btn" data-toggle="modal" data-target="#myModal${vo.idx}">
          <c:set var="fSNames" value="${fn:split(vo.fSName,'/')}"></c:set>
					<img src="${ctp}/data/room/${fSNames[fn:length(fSNames)-1]}" width="100%"/>
				</button>
			</div>
			<div class="col-sm-5">
				<h4><b>${vo.name}</b></h4><br/>
				<p>객실 크기 : ${vo.size}m<sup>2</sup><br/>
				가격 : <fmt:formatNumber value="${vo.price}" pattern="#,##0"/><br/>
				객실 수 : ${vo.numOfRoom}<br/>
				전망 : ${vo.roomView}<br/>
			</div>
			<div class="col-sm-2  m-0 p-0">
				<input type="button" value="수정하기" class="btn btn-secondary" onclick="location.href='${ctp}/ad/adRoomUpdate.ad?idx=${vo.idx}';" style="margin-top:80px">
			</div>
		</div>
		<hr/>
  <!-- The Modal -->
  <div class="modal fade" id="myModal${vo.idx}">
    <div class="modal-dialog modal-lg"> 
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">${vo.name}</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        <div class="row ml-5 mb-3">
		      <c:forEach var="fSName" items="${fSNames}">
	        	<div class="column">
			        	<img src="${ctp}/data/room/${fSName}" width="100%" onclick="myFunction(this,'${vo.idx}');"/>
	        	</div>
	        </c:forEach>
        </div>
        	<div class="container mb-5">
					  <img src="${ctp}/data/room/${fSNames[0]}" id="expandedImg${vo.idx}" style="width:100%">
					  <div id="imgtext"></div>
					<hr/>
					</div>
          <span><h4>${vo.content}</h4></span><br/><br/>
          <span><b>전망 </b>: ${vo.roomView} | <b>크기</b> : ${vo.size}m<sup>2</sup> |<b>침대</b> : ${vo.bed} | <b>룸 구성</b> : ${vo.formation}  </span>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  <!-- modal!!!!  -->
	</c:forEach>
</div>
<!-- 블록 페이지 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pag > 1}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/hotelInfor.tel?part=${part}&pag=1">첫페이지</a></li>
    </c:if>
    <c:if test="${curBlock > 0}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/hotelInfor.tel?part=${part}&pag=${(curBlock-1)*blockSize + 1}">이전블록</a></li>
    </c:if>
    <c:forEach var="i" begin="${(curBlock)*blockSize + 1}" end="${(curBlock)*blockSize + blockSize}" varStatus="st">
      <c:if test="${i <= totPage && i == pag}">
    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/hotelInfor.tel?part=${part}&pag=${i}">${i}</a></li>
    	</c:if>
      <c:if test="${i <= totPage && i != pag}">
    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/hotelInfor.tel?part=${part}&pag=${i}">${i}</a></li>
    	</c:if>
    </c:forEach>
    <c:if test="${curBlock < lastBlock}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/hotelInfor.tel?part=${part}&pag=${(curBlock+1)*blockSize + 1}">다음블록</a></li>
    </c:if>
    <c:if test="${pag < totPage}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/hotelInfor.tel?part=${part}&pag=${totPage}">마지막페이지</a></li>
    </c:if>
  </ul>
</div>
<!-- 블록 페이지 끝 -->
<p><br/></p>
</body>
<script>
function myFunction(imgs,idx) {
	  var expandImg = document.getElementById("expandedImg"+idx);
	  expandImg.src = imgs.src;
	}
</script>
</html>
