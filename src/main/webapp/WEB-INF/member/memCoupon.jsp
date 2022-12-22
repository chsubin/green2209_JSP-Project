<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<% String sMid = session.getAttribute("sMid")==null? "":(String)session.getAttribute("sMid");
	 int sLevel =session.getAttribute("sLevel")==null? 99:(int) session.getAttribute("sLevel");
	 pageContext.setAttribute("sMid", sMid);
	 pageContext.setAttribute("sLevel", sLevel);
	 String sName = session.getAttribute("sName")==null? "":(String)session.getAttribute("sName");
	 String sRvIdx = session.getAttribute("sRvIdx")==null? "":(String)session.getAttribute("sRvIdx");
	 pageContext.setAttribute("sName", sName);
	 pageContext.setAttribute("sRvIdx", sRvIdx);
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
		th{
			background-color:#ddd;		
		}
	</style>
</head>
<script>
	'use strict';

</script>
<body>
<jsp:include page="/include/header.jsp"></jsp:include>
<div class="container" style="margin-top:30px;">
	<div style="height:30px"></div>
	<h2>랜덤 쿠폰 발급</h2>
	<hr style="border-top : 2px solid #444"/>
	<br/>
	<h6>* 당첨여부를 확인하시려면 당첨 확인을 눌러주세요.</h6>
	<h6>* 당첨 확인은 회원 로그인 후 이용 가능합니다.</h6>
	<h6>* 쿠폰은 발급일부터 만료일까지 사용 가능합니다.</h6><br/>
	<table class="table table mb-0">
 	 <tr style="background-color:lavender" class="text-center">
	  	<th width="15%">쿠폰번호</th>
	  	<th width="20%">쿠폰이름</th>
	  	<th width="20%">가격</th>
	  	<th width="15%">발급일</th>
	  	<th width="15%">만료일</th>
	  	<th>비고</th>
  	</tr>
  </table>
	<c:forEach var="vo" items="${vos}" varStatus="st">
	  <table class="table table mb-0 text-center">
	  	<tr>
		  	<td width="15%" class="text-center">${vo.idx}</td>
		  	<td width="20%">${vo.title}</td>
		  	<td width="20%">${vo.price}</td>
		  	<td width="15%" class="text-center">${fn:substring(vo.startDay,0,11)}</td>
		  	<td width="15%" class="text-center">${fn:substring(vo.lastDay,0,11)}</td>
		  	<td data-toggle="modal" data-target="#myModal">당첨 확인</td>
	  	</tr>
	  </table>
	  
	  
	  <!-- The Modal -->
<div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">당첨확인</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body text-center">
      	<c:if test="${sMid==vo.mid}">${sMid}님 당첨 되셨습니다. <br/><br/><img src="${ctp}/image/쿠폰${vo.price}.PNG"/><br/><br/>쿠폰이 발급되었습니다.</c:if>
      	<c:if test="${sMid!=vo.mid&&!empty sMid}">${sMid}님 당첨 되지 않았습니다.<br/><br/>다음기회에..</c:if>
      	<c:if test="${empty sMid}">회원 로그인 후 확인 가능합니다. </c:if>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
	</c:forEach>
	<hr class="m-0 p-0"/>
	  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3(6) / 다음블록 / 마지막페이지 -->
  <div class="text-center mt-5">
    <ul class="pagination justify-content-center">
	    <c:if test="${pag > 1}">
	      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/qnaMain.qna?pag=1"><i class='bx bx-first-page' ></i></a></li>
	    </c:if>
	    <c:if test="${curBlock > 0}">
	      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/qnaMain.qna?pag=${(curBlock-1)*blockSize + 1}"><i class='bx bx-chevron-left' ></i></a></li>
	    </c:if>
	    <c:forEach var="i" begin="${(curBlock)*blockSize + 1}" end="${(curBlock)*blockSize + blockSize}" varStatus="st">
	      <c:if test="${i <= totPage && i == pag}">
	    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/qnaMain.qna?pag=${i}">${i}</a></li>
	    	</c:if>
	      <c:if test="${i <= totPage && i != pag}">
	    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/qnaMain.qna?pag=${i}">${i}</a></li>
	    	</c:if>
	    </c:forEach>
	    <c:if test="${curBlock < lastBlock}">
	      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/qnaMain.qna?pag=${(curBlock+1)*blockSize + 1}"><i class='bx bx-chevron-right' ></i></a></li>
	    </c:if>
	    <c:if test="${pag < totPage}">
	      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/qnaMain.qna?pag=${totPage}"><i class='bx bx-last-page'></i></a></li>
	    </c:if>
    </ul>
  </div>
	
	
</div>
<p><br/></p>
<div style="height:100px"></div>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>