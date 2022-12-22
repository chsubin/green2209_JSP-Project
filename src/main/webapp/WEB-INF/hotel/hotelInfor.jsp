<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>HotelInfor.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
	<jsp:include page="/include/hotel.jsp"/>
	<jsp:include page="/include/modalImage.jsp"/>
</head>
<script>
	'use strict';
  function partCheck() {
  	let part = partForm.part.value;
  	location.href = "${ctp}/hotelInfor.tel?part="+part+"#section1";
  }
</script>
<body data-spy="scroll" data-target="#myScrollspy" data-offset="1">
<jsp:include page="/include/header.jsp"/>
<p><br/></p>
<div class="container"  id="myScrollspy">
  <div id="section1" style="margin-top:60px"><h2>객실  소개</h2></div>
	<hr style="border : 1px solid #444"/>
	  <table class="table table-borderless">
    <tr>
      <td style="width:20%" class="text-left">
        <form name="partForm">
        	<select name="part" onchange="partCheck()" class="form-control">
        	  <option value="스탠다드" ${part == '스탠다드' ? 'selected' : ''}>스탠다드</option>
        	  <option value="이그제큐티브" ${part == '이그제큐티브' ? 'selected' : ''}>이그제큐티브</option>
        	  <option value="스위트" ${part == '스위트' ? 'selected' : ''}>스위트</option>
        	</select>
        </form>
      </td>
      <td></td>
    </tr>
  </table>
	<h5>*사진을 클릭하시면 객실 상세 페이지를 확인하실 수 있습니다.</h5>
	<hr/>
	<c:forEach var="vo" items="${vos}" varStatus="st">
		<div class="row">
			<div class="col-sm-5">
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
			<div class="col-sm-2">
				<input type="button" value="예약하러가기" class="btn btn-secondary" onclick="location.href='${ctp}/hotel/hotelReserve1.tel';" style="margin-top:80px">
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
          <c:set var="fSNames" value="${fn:split(vo.fSName,'/')}"/>
		      <c:forEach var="fSName" items="${fSNames}">
	        	<div class="column">
			        	<img src="${ctp}/data/room/${fSName}" width="100%" onclick="myFunction(this,'${vo.idx}');"/>
	        	</div>
	        </c:forEach>
        </div>
        	<div class="container mb-5 imgcontainer">
					  <img src="${ctp}/data/room/${fSNames[0]}" id="expandedImg${vo.idx}" style="width:100%">
					  <div id="imgtext"></div>
					</div>
          <span><h4>${vo.content}</h4></span><br/><br/>
          <span><b>전망 </b>: ${vo.roomView} | <b>크기</b> : ${vo.size}m<sup>2</sup> |<b>침대</b> : ${vo.bed} | <b>룸 구성</b> : ${vo.formation}  </span>
        </div>
        <div class=" border m-3" style="background-color:  #F6EFD7 ; ">
         <pre>
          	
▶ 체크인/체크아웃 시간

- 체크인 : 오후 2시 이후
- 체크아웃 : 오전 11시까지

▶ 취소/변경 및 노쇼(No-show) 안내

- 숙박 예정일 1일 전 18시까지는 위약금 없음
- 숙박 예정일 1일 전 18시 이후 취소/변경/노쇼 발생 시

▷성수기(5월~10월, 12월 24일~31일) :
최초 1일 숙박 요금의 80%가 위약금으로 부과
▷비수기(성수기 외 기간) :
최초 1일 숙박 요금의 10%가 위약금으로 부과
</pre>
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
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/hotelInfor.tel?part=${part}&pag=1"><i class='bx bx-first-page' ></i></a></li>
    </c:if>
    <c:if test="${curBlock > 0}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/hotelInfor.tel?part=${part}&pag=${(curBlock-1)*blockSize + 1}"><i class='bx bx-chevron-left' ></i></a></li>
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
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/hotelInfor.tel?part=${part}&pag=${(curBlock+1)*blockSize + 1}"><i class='bx bx-chevron-right' ></i></a></li>
    </c:if>
    <c:if test="${pag < totPage}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/hotelInfor.tel?part=${part}&pag=${totPage}"><i class='bx bx-last-page'></i></a></li>
    </c:if>
  </ul>
</div>
<!-- 블록 페이지 끝 -->
<p><br/></p>
<div style="height:100px"></div>
<jsp:include page="/include/footer.jsp"/>
</body>
<script>
function myFunction(imgs,idx) {
  var expandImg = document.getElementById("expandedImg"+idx);
  expandImg.src = imgs.src;
}
</script>
</html>