<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String sMid = session.getAttribute("sMid")==null? "":(String)session.getAttribute("sMid");
	 int sLevel =session.getAttribute("sLevel")==null? 99:(int) session.getAttribute("sLevel");
	 pageContext.setAttribute("sMid", sMid);
	 pageContext.setAttribute("sLevel", sLevel);
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<nav id="lightnav" class="navbar-light bg-light">
  <ul class="nav justify-content-end">
	  <li class="nav-item dropdown">
	    <a class="nav-link  dropbtn"  href="${ctp}/hotelInfor.tel">ROOM</a>
	    <%-- <div class="dropdown-menu dropdown-content">
	      <a class="dropdown-item" href="${ctp}/hotelInfor.tel">객실</a>
	      <a class="dropdown-item" href="#">Link 2</a>
	      <a class="dropdown-item" href="#">Link 3</a>
	   </div> --%>
	  </li>
	  <li class="nav-item dropdown">
	    <div class="nav-link  dropbtn" >RESERVATION</div>
	    <div class="dropdown-menu dropdown-content">
	      <a class="dropdown-item" href="${ctp}/hotelReserve1.tel">실시간 예약</a>
		     <c:if test="${sLevel<=3}"><a class="dropdown-item" href="${ctp}/hotelReserveList.tel">예약확인</a></c:if>
		     <c:if test="${sLevel==4}"><a class="dropdown-item" href="${ctp}/hotelReserveConfirm.tel">예약확인</a></c:if>
		     <c:if test="${sLevel==99}"><a class="dropdown-item" href="${ctp}/memLogin.mem">예약확인</a></c:if>
	   </div>
	  </li>
	  <li class="nav-item dropdown">
	    <div class="nav-link  dropbtn"  href="#">SERVICE</div>
	    <div class="dropdown-menu dropdown-content">
	      <a class="dropdown-item" href="${ctp}/qnaMain.qna">Q&A</a>
	      <a class="dropdown-item" href="${ctp}/pdsList.pds">REVEIW</a>
	   </div>
	</ul>
</nav>
<script>
$(function() {
	if ($(window).scrollTop() >= 150) {
	  	$("#lightnav").slideDown();
		}

	$(window).scroll(function(){
		if ($(window).scrollTop() >= 150) {
	  	$("#lightnav").slideDown();
		}
		else {
			$("#lightnav").slideUp();
		}

	});
}); 
</script>