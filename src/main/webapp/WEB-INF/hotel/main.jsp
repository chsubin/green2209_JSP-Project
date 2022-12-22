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
	<jsp:include page="/include/hotel.jsp"></jsp:include>
	<style>
		.month {
	  padding: 25px 10px;
	  width: 100%;
	  background: #1abc9c;
	  text-align: center;
	}

	</style>
</head>

<body>
<jsp:include page="/include/header2.jsp"></jsp:include>
<div class="container-fluid ml-0 mr-0 pl-5 pr-5" style="margin-top:30px;margin:30px 150px">
	<form name="myform" method="post" action="${ctp}/hotel/hotelReserve1.tel">
		<table class="table table-borderless p-0 m-0" style="text-align:center;">
			<tr class=" table border-bottom">
				<th style="width:20%">  </th>
				<th><h5>체크인 <input type="date" name="checkIn" id="checkIn"  value="${checkIn}" onchange="replay()"/></h5></th>
				<th><h5><i class='bx bxs-moon' style="color:#555;font-size:30px;width:5%"></i></h5></th>
				<th><h5>체크아웃 <input type="date" name="checkOut" id="checkOut" value="${checkOut}" onchange="replay()"/></h5></th>
				<th><h5><i style="color:#555;font-size:30px" class='bx bx-male-female'></i></h5></th>
				<th><h5>
				 	<select>
				 		<option>1</option>
				 		<option selected>2</option>
				 		<option>3</option>
				 		<option>4</option>
				 	</select>명
				</h5></th>
				<th><h5><input type="submit" class="btn btn-secondary btn-lg" value="SEARCH"/></h5></th>
				<th style="width: 15%"></th>
			</tr>
		</table>
	</form>
	<table class="table table-borderless mt-5 mb-5 ml-0 mr-0 pl-5 pr-5" style="width:100%">
		<tr>

			
			<td width ='30%' >
	<div class="text-center text-white month m-0 pt-5">
    <font size="5">${yy}년 ${mm+1}월</font>
    &nbsp;&nbsp;
  </div>
  <div class="text-center m-0 p-0">
    <table class="table table-bordered m-0 p-0" style="height:450px">
      <tr class="text-center text- m-0 p-0" style="background-color:#ddd">
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
          <td style="color:#ccc;font-size:0.6em;background-color:#eee">${prevYear}-${prevMonth+1}-${preDay}</td>
          <c:set var="cnt" value="${cnt+1}"/>
        </c:forEach>
        
        <!-- 해당월에 대한 날짜를 마지막일자까지 반복 출력한다.(단, gap이 7이되면 줄바꿈한다.) -->
        <c:forEach begin="1" end="${lastDay}" varStatus="st">
          <c:set var="todaySw" value="${toYear==yy && toMonth==mm && toDay==st.count ? 1 : 0}"/>
          <td style="background-color:#eee" id="td${gap}" ${todaySw==1 ? 'class=today' : ''} style="font-size:0.9em">
            ${st.count}
            <br/>
	          <c:forEach var="vo" items="${vos}">
	          	<c:if test="${(fn:substring(vo.checkIn,8,10)<=st.count&&fn:substring(vo.checkOut,8,10)>st.count)
	          	||(fn:substring(vo.checkIn,5,7)-1==mm&& fn:substring(vo.checkIn,8,10)<=st.count&&fn:substring(vo.checkIn,8,10)>fn:substring(vo.checkOut,8,10))
	          	||(fn:substring(vo.checkOut,5,7)-1==mm&& fn:substring(vo.checkOut,8,10)>st.count&&fn:substring(vo.checkIn,8,10)>fn:substring(vo.checkOut,8,10))
	          	}">
		           	<c:if test="${fn:contains(vo.roomName,'스탠다드')}"><div class="badge badge-primary"> </div></c:if>
		           	<c:if test="${fn:contains(vo.roomName,'이그제큐티브')}"><div class="badge badge-warning"> </div></c:if>
		           	<c:if test="${fn:contains(vo.roomName,'스위트')}"><div class="badge badge-success"> </div></c:if>
	            </c:if>
       		 	</c:forEach>
          </td>
          <c:if test="${cnt % 7 == 0}"></tr><tr></c:if>  <!-- 한주가 꽉차면 줄바꾸기 한다. -->
          <c:set var="cnt" value="${cnt+ 1}"/>
        </c:forEach>

        
        
         <!-- 마지막일 이후를 다음달의 일자로 채워준다. -->
        <c:if test="${nextStartWeek != 1}">
	        <c:forEach begin="${nextStartWeek}" end="7" varStatus="nextDay">
	          <td style="color:#ccc;background-color:#eee;font-size:0.6em">${nextYear}-${nextMonth+1}-${nextDay.count}</td>
	        </c:forEach>
        </c:if>
      </tr>
    </table>
  </div>
  
			</td>
			<td>
				
					<div class="card" style="border:none">
					  <div class="card-body m-0 pt-0 pb-0">
					    <h3 class="card-title text-center m-0">REVIEW</h3>
								<table class="table table-bordered table-hover table-responsive-sm text-center mt-0">
								<c:forEach var="pdsVo" items="${pdsVos}">
									<tr class="text-center border">
										<td>
											<c:set var="fSNames" value="${fn:split(pdsVo.fSName,'/')}"></c:set>
											<img src="${ctp}/data/pds/${fSNames[fn:length(fSNames)-1]}" width="300px" height="150px"/>
										<td>
										<td class="text-left">
											 객실 : <b>${pdsVo.roomName}</b><br/>
											 방문날짜 : ${pdsVo.checkIn}~${pdsVo.checkOut}<br/>
											 제목: <a href="${ctp}/pdsContent.pds?idx=${pdsVo.idx}">${pdsVo.title}</a><br/><br/>
											 ${pdsVo.content}</<br/>
										 </td>
									</tr>
								</c:forEach>
									<tr><td colspan="7" class="m-0 p-0"></td></tr>
								</table>
					    <a href="${ctp}/hotelReserveList.tel" class="card-link">+more</a>
					  </div>
					</div>
				
				
			</td>
			
			
		</tr>
	</table>
		<div class="row">
			<div class="col sm-1"></div>
			<div class="col sm-10 padding: 0 auto">
				<iframe class="align-self-center" width="1500px" height="960px" src="https://www.youtube.com/embed/1GjgpK_nWss?controls=0&autoplay=1&mute=1;playlist=1GjgpK_nWss&start=65" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
			</div>
			<div class="col sm-1"></div>
		</div>
	</div>
</div>
<br>

	<br/>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>