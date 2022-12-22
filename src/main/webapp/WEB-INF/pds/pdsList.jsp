<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	</style>
</head>
<script>


	function searchformSubmit() {
		mySearchForm.searchSw.value=1;
			mySearchForm.submit();
	}
</script>
<body>
<jsp:include page="/include/header.jsp"></jsp:include>
<div class="container" style="margin-top:30px;">
	<div style="height:30px"></div>
	<h2>REVEIW</h2>
	<hr style="border-top : 2px solid #444"/>
   <table class="table table-borderless">
    <tr>
  	  <c:if test="${sLevel!=99}">
	      <td class="text-right">
	        <c:if test="${sLevel==4}"><a href="${ctp}/pdsInput.pds?pag=${pag}" class="btn btn-success">글쓰기</a></c:if>
	        <c:if test="${sLevel!=4}"><a href="${ctp}/hotelReserveList.tel?pag=${pag}" class="btn btn-success">글쓰기</a></c:if>
	      </td>
      </c:if>
  	  <c:if test="${sLevel==99}">
	      <td class="text-left">
	      	*로그인하시면 후기를 작성하실 수 있습니다.
	      </td>
      </c:if>
    </tr>
  </table>
  <table class="table table-hover text-center">
    <tr class="table bg-light text-dark">
      <th>번호</th>
      <th>이용객실</th>
      <th width="45%">제목</th>
      <th>작성자</th>
      <th>작성일</th>
      <th>조회수</th>
    </tr>
    <c:forEach var="vo" items="${vos}">
      <tr>
        <td>${curScrStartNo}</td>
        <td>${vo.roomName}</td>
        <td>
          <a href="${ctp}/pdsContent.pds?idx=${vo.idx}&pag=${pag}">${vo.title}</a>
    	    <c:if test="${vo.hour_diff <= 24}"><div class="badge badge-danger">N</div> </c:if>
    	    [${vo.replyCnt}]
        </td>
        <td>${vo.mid}${vo.midName}</td>
        <td>
          <%-- ${vo.fDate} --%>
          <c:if test="${vo.hour_diff >= 12}">${fn:substring(vo.fDate,0,10)}</c:if>
          <c:if test="${vo.hour_diff < 12&&vo.hour_diff>=1}">		<!-- 24시간이 지나지 않았지만 현재시간~자정까찌는 '날짜:시간', 나머지는 '시간'만 출력 -->
    	      ${vo.hour_diff}시간 전
    	    </c:if>
          <c:if test="${vo.hour_diff < 1}">방금 전</c:if>
        </td>
      	<td>${vo.readNum}</td>
      </tr>
      <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
    </c:forEach>
    <tr>
    	<td colspan="8" class="text-center">
	    	<form name="mySearchForm" method="post" action="${ctp}/pdsList.pds">
		    	<select name="searchfield">
		    		<option value="title" ${searchfield == 'title' ? 'selected' : ''}>제목</option>
		    		<option value="nickName" ${searchfield == 'nickName' ? 'selected' : ''}>작성자</option>
		    		<option value="roomName" ${searchfield == 'roomName' ? 'selected' : ''}>객실</option>
		    		<option value="content"  ${searchfield == 'content' ? 'selected' : ''}>본문</option>
		    	</select>
		    	<input type="text" name="search" id = "search" value="${search}"/>
		    	<input type="button" onclick="searchformSubmit()"  class="btn-sm btn-primary" value="검색">
		    	<input type ="hidden" name="pag" value="${pag}"/>
		    	<input type ="hidden" name="searchSw" value="0"/>
	    	</form>
    	</td>
    </tr>
  </table>
 
 <!-- 블록 페이지 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pag > 1}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/pdsList.pds?pag=1&searchfield=${searchfield}&search=${search}"><i class='bx bx-first-page' ></i></a></li>
    </c:if>
    <c:if test="${curBlock > 0}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/pdsList.pds?pag=${(curBlock-1)*blockSize + 1}&searchfield=${searchfield}&search=${search}"><i class='bx bx-chevron-left' ></i></a></li>
    </c:if>
    <c:forEach var="i" begin="${(curBlock)*blockSize + 1}" end="${(curBlock)*blockSize + blockSize}" varStatus="st">
      <c:if test="${i <= totPage && i == pag}">
    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/pdsList.pds?pag=${i}&searchfield=${searchfield}&search=${search}">${i}</a></li>
    	</c:if>
      <c:if test="${i <= totPage && i != pag}">
    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/pdsList.pds?pag=${i}&searchfield=${searchfield}&search=${search}">${i}</a></li>
    	</c:if>
    </c:forEach>
    <c:if test="${curBlock < lastBlock}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/pdsList.pds?pag=${(curBlock+1)*blockSize + 1}&searchfield=${searchfield}&search=${search}"><i class='bx bx-chevron-right' ></i></a></li>
    </c:if>
    <c:if test="${pag < totPage}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/pdsList.pds?pag=${totPage}&searchfield=${searchfield}&search=${search}"><i class='bx bx-last-page'></i></a></li>
    </c:if>
  </ul>
</div>
<!-- 블록 페이지 끝 -->
 
 
  
</div>
<p><br/></p>
<div style="height:100px"></div>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>