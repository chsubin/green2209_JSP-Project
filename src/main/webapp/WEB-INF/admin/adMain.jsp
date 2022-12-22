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
</style>
</head>
<body>
<jsp:include page="/include/adMenu.jsp"></jsp:include>
<p><br/></p>
<div class="main">
  <div class="text-center">
    <button type="button" onclick="location.href='${ctp}/adMain.ad?yy=${yy-1}&mm=${mm}';" class="btn btn-secondary btn-sm" title="이전년도">◁◁</button>
    <button type="button" onclick="location.href='${ctp}/adMain.ad?yy=${yy}&mm=${mm-1}';" class="btn btn-secondary btn-sm" title="이전월">◀</button>
    <font size="5">${yy}년 ${mm+1}월</font>
    <button type="button" onclick="location.href='${ctp}/adMain.ad?yy=${yy}&mm=${mm+1}';" class="btn btn-secondary btn-sm" title="다음월">▶</button>
    <button type="button" onclick="location.href='${ctp}/adMain.ad?yy=${yy+1}&mm=${mm}';" class="btn btn-secondary btn-sm" title="다음년도">▷▷</button>
    &nbsp;&nbsp;
    <button type="button" onclick="location.href='${ctp}/adMain.ad';" class="btn btn-secondary btn-sm" title="오늘날짜"><i class="fa fa-home"></i></button>
  </div>
  <br/>
  <div class="text-center">
    <table class="table table-bordered" style="height:450px">
      <tr class="text-center" style="background-color:#eee">
        <th style="width:13%; color:red; vertical-align:middle">일</th>
        <th style="width:13%; vertical-align:middle">월</th>
        <th style="width:13%; vertical-align:middle">화</th>
        <th style="width:13%; vertical-align:middle">수</th>
        <th style="width:13%; vertical-align:middle">목</th>
        <th style="width:13%; vertical-align:middle">금</th>
        <th style="width:13%; color:blue; vertical-align:middle">토</th>
      </tr>
      <tr>
        <c:set var="cnt" value="${1}"/>
        <!-- 시작일 이전의 공백을 이전달의 날짜로 채워준다. -->
        <c:forEach var="preDay" begin="${preLastDay-startWeek+2}" end="${preLastDay}">
          <td style="color:#ccc;font-size:0.6em">${prevYear}-${prevMonth+1}-${preDay}</td>
          <c:set var="cnt" value="${cnt+1}"/>
        </c:forEach>
        
        <!-- 해당월에 대한 날짜를 마지막일자까지 반복 출력한다.(단, gap이 7이되면 줄바꿈한다.) -->
        <c:forEach begin="1" end="${lastDay}" varStatus="st">
          <c:set var="todaySw" value="${toYear==yy && toMonth==mm && toDay==st.count ? 1 : 0}"/>
          <td id="td${gap}" ${todaySw==1 ? 'class=today' : ''} style="font-size:0.9em">
	         <a href="${ctp}/adReserveList.ad?yy=${yy}&mm=${mm+1}&dd=${st.count}">
            ${st.count}
	          <c:forEach var="vo" items="${vos}">
	          	<c:if test="${(fn:substring(vo.checkIn,8,10)<=st.count&&fn:substring(vo.checkOut,8,10)>st.count)
	          	||(fn:substring(vo.checkIn,5,7)-1==mm&& fn:substring(vo.checkIn,8,10)<=st.count&&fn:substring(vo.checkIn,8,10)>fn:substring(vo.checkOut,8,10))
	          	||(fn:substring(vo.checkOut,5,7)-1==mm&& fn:substring(vo.checkOut,8,10)>st.count&&fn:substring(vo.checkIn,8,10)>fn:substring(vo.checkOut,8,10))
	          	}">
		           	<br/>
		           	<c:if test="${fn:contains(vo.roomName,'스탠다드')}"><div class="badge badge-primary">${vo.roomName}</div></c:if>
		           	<c:if test="${fn:contains(vo.roomName,'이그제큐티브')}"><div class="badge badge-warning">${vo.roomName}</div></c:if>
		           	<c:if test="${fn:contains(vo.roomName,'스위트')}"><div class="badge badge-success">${vo.roomName}</div></c:if>
	            </c:if>
       		 	</c:forEach>
	         </a>
          </td>
          <c:if test="${cnt % 7 == 0}"></tr><tr></c:if>  <!-- 한주가 꽉차면 줄바꾸기 한다. -->
          <c:set var="cnt" value="${cnt+ 1}"/>
        </c:forEach>

        
        
         <!-- 마지막일 이후를 다음달의 일자로 채워준다. -->
        <c:if test="${nextStartWeek != 1}">
	        <c:forEach begin="${nextStartWeek}" end="7" varStatus="nextDay">
	          <td style="color:#ccc;font-size:0.6em">${nextYear}-${nextMonth+1}-${nextDay.count}</td>
	        </c:forEach>
        </c:if>
      </tr>
    </table>
  </div>


  <br/><br/>
   <div class="card-deck">
    <div class="card  bg-light">
      <div class="card-body text-center">
      	<div class="card-title mb-5"><h4><a href="${ctp}/adReserveList.ad?yy=${toYear}&mm=${toMonth+1}&dd=${toDay}">TODAY CHECKIN(전체 <b>${tCnt}</b>건)</a></h4></div>
	        <div class="card-text text-left">
      		<hr/>
      		<c:forEach var="tVo" items="${tVos}">
	       		${tVo.name}(${tVo.mid})----
	       	 <c:if test="${empty tVo.rcheckIn}">
	       		<font color="red">미입실</font>
	       		</c:if>
	       	 <c:if test="${!empty tVo.rcheckIn}">
	       		<font color="blue">입실</font>
	       		</c:if>
	       		<br>
	        </c:forEach>
	       	</div>
	       <br/>

      </div>
    </div>
    <div class="card bg-light">
      <div class="card-body text-center">
      	<div class="card-title  mb-5"><h4><a href="${ctp}/adMemList.ad">탈퇴 신청 <b>${memCnt}</b>건</a></h4></div>
      		<c:forEach var="mVo" items="${memVos}">
      		<hr/>
	        <p class="card-text text-left">
	        	<b>${mVo.mid}(${mVo.nameKor})</b><br/>
	        	등급 : <c:if test="${mVo.level==0}">관리자</c:if>
	        	<c:if test="${mVo.level==1}">운영자</c:if>
	        	<c:if test="${mVo.level==2}">VIP</c:if>
	        	<c:if test="${mVo.level==3}">일반회원</c:if>
	        	<br/>
	       		포인트: ${mVo.point}
	       	</p>
	        <hr/>
	        </c:forEach>
      </div>
    </div>
    <div class="card  bg-light">
      <div class="card-body text-center">
      	<div class="card-title  mb-5"><h4><a href="${ctp}/adMemList.ad">등급 상향 대상자<b> ${uCnt}</b>건</a></h4></div>
      	<hr/>
      	<c:if test="${uCnt==0}"><div class="card-title  mb-5"><br/><h4>등급 상향 대상자가 없습니다.</h4></div></c:if>
      		<c:forEach var="uVo" items="${uVos}">
	        <p class="card-text text-left">
      		<b>${uVo.mid}(${uVo.nameKor})</b><br/>
	        	등급 : <c:if test="${uVo.level==0}">관리자</c:if>
	        	<c:if test="${uVo.level==1}">운영자</c:if>
	        	<c:if test="${uVo.level==2}">VIP</c:if>
	        	<c:if test="${uVo.level==3}">일반회원</c:if>
	        	<br/>
	       		포인트: ${uVo.point}
	       	</p>
	        </c:forEach>
      </div>
    </div>
    <div class="card  bg-light">
      <div class="card-body text-center">
      	<div class="card-title  mb-5"><h4><a href="${ctp}/qnaMain.qna">TODAY Q&A <b>${qCnt}</b>건</a></h4></div>
      	<c:if test="${qCnt==0}"><div class="card-title  mb-5"><br/><h4>오늘 작성된 Q&A가 없습니다.</h4></div></c:if>
      		<c:forEach var="qVo" items="${qVos}">
	        <p class="card-text text-left">
	        	<b>${qVo.nickName}(${qVo.mid}<c:if test="${empty qVo.mid}">비회원</c:if>)</b><br/>
						문의사항: 			<c:if test="${qVo.content.length()>=40}">${fn:substring(qVo.content,0,40)}...</c:if>
			 							 		<c:if test="${qVo.content.length()<40}">${qVo.content}</c:if>			
	        	<br/>
	       	</p>
	        <hr/>
	        </c:forEach>
      </div>
    </div>
  </div>



</div>
<p><br/></p>
</body>
</html>