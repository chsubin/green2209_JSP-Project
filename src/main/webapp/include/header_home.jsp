<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String sMid = session.getAttribute("sMid")==null? "":(String)session.getAttribute("sMid");
	 int sLevel =session.getAttribute("sLevel")==null? 99:(int) session.getAttribute("sLevel");
	 pageContext.setAttribute("sMid", sMid);
	 pageContext.setAttribute("sLevel", sLevel);
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<div class="jumbotron text-center" style="margin-bottom:0;height:970px;padding:0;">
	<div id="demo" class="carousel slide" data-ride="carousel"  style="z-index:0">
  <!-- Indicators -->
  <ul class="carousel-indicators">
    <li data-target="#demo" data-slide-to="0" class="active"></li>
    <li data-target="#demo" data-slide-to="1"></li>
    <li data-target="#demo" data-slide-to="2"></li>
  </ul>
  <!-- The slideshow -->
  <div class="carousel-inner" style="z-index:0">
    <div class="carousel-item active" style="z-index:0">
      <img src="${ctp}/image/메인화면1.jpg" alt="Chicago" width="100%" height="970">
      <div class="carousel-caption" style="width:100%">
<!--         <h1 class="m-5 p-5 text-left" style="position:relative;top:300px;"><b>A Space For Relaxes In Winter</b></h1> -->
        <h1><b>A Space For Relaxes In Winter</b></h1>
      </div>   
    </div>
    <div class="carousel-item">
      <img src="${ctp}/image/메인화면2.jpg" alt="Chicago" width="100%" height="970" style="z-index:0">
      <div class="carousel-caption" style="width:100%">
        <h1><b>Infinity Pool with DongHea</b></h1>
      </div>   
    </div>
    <div class="carousel-item">
      <img src="${ctp}/image/메인화면3.jpg" alt="New York" width="100%" height="970" />
      <div class="carousel-caption" style="width:100%">
        <h1><b>Rest With Nature</b></h1>
      </div>   
    </div>
  </div>
  <!-- Left and right controls -->
  <a class="carousel-control-prev" href="#demo" data-slide="prev">
    <span class="carousel-control-prev-icon" style="height:40px"></span>
  </a>
  <a class="carousel-control-next" href="#demo" data-slide="next">
    <span class="carousel-control-next-icon"></span>
  </a>
</div>
	<div class="title" style="position: relative;
    bottom: 970px;
    color: white;
    width:100%;
    padding : 10px 30px;
    text-align : left">
	  <div style="font-size:18px;width:50%"><a href="${ctp}/"><h5><i class='bx bxs-leaf'></i>Green Art Hotel</h5></a></div>
	  <ul class="nav justify-content-end" style="margin-top:-40px;z-index:2;font-size:16px;width:100%">
	  	<c:if test="${sLevel<2}">
		    <li class="nav-item" style="z-index:2">
		      <a class="nav-link" href="${ctp}/member/adMain.ad" style="z-index:2">Admin</a>
		    </li>
		   </c:if>
	  	<c:if test='${sLevel==99}'>
		    <li class="nav-item" style="z-index:2">
		      <a class="nav-link" href="${ctp}/member/memLogin.mem" style="z-index:2">LogIn</a>
		    </li>
		    <li class="nav-item" style="z-index:2">
		      <a class="nav-link" href="${ctp}/member/memJoin.mem" style="z-index:2">Join</a>
		    </li>
	    </c:if>
	    <li class="nav-item" style="z-index:2">
	      <a class="nav-link" href="${ctp}/member/memMemberShip.mem" style="z-index:2">MemberShip</a>
	    </li>
	    <c:if test="${sLevel!=99&&sLevel!=4}">
		    <li class="nav-item" style="z-index:2">
		      <a class="nav-link" href="${ctp}/memMain.mem" style="z-index:2">MyPage</a>
		    </li>
	    </c:if>
	    <c:if test="${sLevel!=99}">
		    <li class="nav-item" style="z-index:2">
		      <a class="nav-link" href="${ctp}/member/memLogout.mem" style="z-index:2">LogOut<i class='bx bx-log-out'></i></a>
		    </li>
		  </c:if>
  	</ul>
  	<!-- 메인메뉴!!!!!!!! -->
		<nav id="mainnav">
  <ul class="nav justify-content-end">
	  <li class="nav-item dropdown">
	    <a class="nav-link  dropbtn"  href="${ctp}/hotelInfor.tel">ROOM</a>
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
		<hr  class="m-0"/>
		<div id="watch" style="font-size:25px;margin-top:50px"></div>
	</div>
	<div style="z-index:5;position:absolute;bottom:200px;color:#fff">
	</div>
</div>

<script>
	'use strict';
	let statusTime;
	
	function clock() {
	  let today = new Date();
	  watch.innerHTML="";
	  let hh=("0"+today.getHours()).slice(-2);
	  let mm=("0"+today.getMinutes()).slice(-2);
	  let ss=("0"+today.getSeconds()).slice(-2);
		
	  if (hh>=12){
		  watch.innerHTML= "PM ";
		  if(hh!=12){
		  hh = hh-12;
		  }
/* 	  	hh=("0"+hh).slice(-2); */
	  }
	  else {
		  watch.innerHTML= "AM ";
	  }
	  
	  watch.innerHTML += hh+":";
	  watch.innerHTML += mm+":";
	  watch.innerHTML += ss;
		}
	
	function clockStart() {
	  clock();
	  statusTime=setInterval(clock,1000);
	}
	clockStart();

		    
</script>

