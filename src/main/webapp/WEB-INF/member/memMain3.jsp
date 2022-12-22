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
	<jsp:include page="/include/hotel.jsp"></jsp:include>
</head>
<script>
	'use strict';
	function unresister(){
		
		let pwd =$("#pwd").val();
		
		$.ajax({
			url:"${ctp}/memUnresister.mem",
			data: {
				pwd: pwd,
				},
			success: function(res){
				if(res=="2") alert("현재 비밀번호가 일치하지 않습니다.");
				else if(res=="0") alert("탈퇴 실패");
				else {
					if(confirm("포인트는 복구되지 않습니다.\n정말 탈퇴하시겠습니까?")){
						alert("탈퇴 되셨습니다.");
						location.href="${ctp}/";
					}
					else {return;}
				}
			},
			error : function(){
				alert("전송오류~~");
			}
		});
					
	}
</script>
<body>
<jsp:include page="/include/header.jsp"></jsp:include>
<div class="container-fluid" style="margin-top:30px;width:90%">
	<div style="height:30px"></div>
	<h2 class="text-center">My Page</h2>
	<div class="mb-5"></div>
	<hr>
	<table class="table table-borderless">
		<tr>
			<td width="20%" class=" pt-0 ">
				<div class="bg-light text-dark border m-0">
				  <div class="card-body p-5">
				    <h4 class="card-title"><i class='bx bxs-user'></i>${vo.nameKor}님 
				    	<c:if test="${vo.level=='2'}"><div class="badge badge-warning">VIP</div></c:if>
				    	<c:if test="${vo.level=='3'}"><div class="badge badge-success">일반</div></c:if>
				    <a href="${ctp}/memUpdate.mem" ><i class='bx bxs-edit'></i></a></h4>
				    <span>그린아트와 함께한 지 <b>${vo.day_diff}</b>일째</span><br/>
				    <span>반갑습니다!</span><br/>
				    <hr/>
				    <span>아이디 : ${vo.mid}</span><br/>
				    <span> 등급 : 
				    	<c:if test="${vo.level=='0'}">관리자</c:if>
				    	<c:if test="${vo.level=='1'}">운영자</c:if>
				    	<c:if test="${vo.level=='2'}">VIP</c:if>
				    	<c:if test="${vo.level=='3'}">일반회원</c:if>
				    </span><br/>
				    <c:if test="${vo.level=='3'}"><span>vip까지  <b>${50000-vo.memPoint}</b> 포인트!</span><br/></c:if>
				    <span>사용가능 포인트 :<font color="blue"><b> ${vo.point}</b></font>점</span><br/>
				    <span>가입일 : ${fn:substring(vo.startDate,0,11)}</span><br/>
				    <span>마지막 방문 : ${fn:substring(vo.lastDate,0,11)}</span><br/>
				    <hr/>
				    <a href="${ctp}/memPwdUpdate.mem" class="card-link"><i class='bx bxs-edit-alt' ></i>password</a>
				    <a class="card-link"  data-toggle="modal" data-target="#myModal"><i class='bx bx-user-x'></i>unregister</a>
				  </div>
				</div>
				<div class="bg-light text-dark border mt-3">
				  <div class="card-body p-5">
      			<div class="card-title"><h6>내 쿠폰 내역<b> ${couCnt}</b>건</h6></div>
      			<hr/>
      			<c:if test="${couCnt==0}"><div class="card-title  mb-5"><br/><h6>최근 90일내에 쿠폰 내역이 없습니다.</h6></div></c:if>
      			<c:forEach var="couVo" items="${couVos}">
	        		<div class="card-text">
	        			<font size="5em"><i class='bx bxs-coupon'></i></font>&nbsp;&nbsp;${couVo.price}원
	        			<br/>${fn:substring(couVo.startDay,0,10)} 발급 <br>
	        			<c:if test="${couVo.useSw=='미사용'}"> <font color="red">미사용 - 만료 ${-couVo.day_diff}일 전</font></c:if>
	        			<c:if test="${couVo.useSw!='미사용'}"> <font color="blue">사용 완료</font></c:if>
	        			<br/>
	       			</div>
	       			<hr>
	      		</c:forEach>
				 </div>
			</div>
			</td>
			<td class="p-0">
				<div class="card m-0" style="border:none">
				  <div class="card-body">
				    <h4 class="card-title">Recent Reservation</h4>
							<table class="table table-bordered table-hover table-responsive-sm text-center mb-0">
								<tr class="table-dark text-dark  text-center">
									<th>예약번호</th>
									<th>객실</th>
									<th>예약일시</th>
									<th>체크인</th>
									<th>체크아웃</th>
									<th>조식</th>
									<th>가격</th>
								</tr>
								<c:if test="${empty rvVOS}"><tr><td class="text-center" colspan="7"><h6>최근 예약 내역이 없습니다.</h6></td></tr></c:if>
								<c:forEach var="rvVO" items="${rvVOS}">
									<tr class="text-center">
										<td>${rvVO.rvIdx}</td>
										<td>${rvVO.roomName}</td>
										<td>${fn:substring(rvVO.rvDay,0,19)}</td>
										<td>${rvVO.checkIn}</td>
										<td>${rvVO.checkOut}</td>
										<td>${rvVO.adultF}</td>
										<td><fmt:formatNumber value="${rvVO.price}" pattern="#,##0"/></td>
									</tr>
								</c:forEach>
								<tr><td colspan="7" class="m-0 p-0"></td></tr>
							</table>
							<table class="table table-bordered table-hover table-responsive-sm text-center mt-0">
								<tr class="table-dark text-dark text-center">
									<th>객실이름</th>
									<th>방문날짜</th>
									<th width="40%">제목</th>
									<th>작성자</th>
									<th>작성일</th>
								</tr>
									<c:if test="${empty pdsVos}"><tr><td colspan="5"><h6>후기 내역이 없습니다.</td></tr></h6></c:if>
									<c:forEach var="pdsVo" items="${pdsVos}">
									<tr class="text-center">
										<td>${pdsVo.roomName}</td>
										<td>${pdsVo.checkIn}~${pdsVo.checkOut}</td>
										<td><a href="${ctp}/pdsContent.pds?idx=${pdsVo.idx}">${pdsVo.title}<c:if test="${pdsVo.hour_diff <= 24}"><div class="badge badge-danger">N</div> </c:if></a></td>
										<td>${pdsVo.mid}${pdsVo.midName}</td>
										<td>${fn:substring(pdsVo.fDate,0,10)}</td>
									</tr>
									</c:forEach>
								<tr><td colspan="7" class="m-0 p-0"></td></tr>
							</table>
							<table class="table table-bordered table-hover table-responsive-sm">
								<tr class="table-dark text-dark  text-center">
									<th>닉네임</th>
									<th>이메일</th>
									<th>문의사항</th>
									<th>작성일</th>
									<th>hostIP</th>
								</tr>
								<c:if test="${empty qnaVos}"><tr><td class="text-center" colspan="5"><h6>Q&A 내역이 없습니다.</h6></td></tr></c:if>
								<c:forEach var="qnaVo" items="${qnaVos}">
									<tr class="text-center">
										<td>${qnaVo.nickName}</td>
										<td>${qnaVo.email==""?'없음':qnaVo.email}</td>
										<td>
											<c:if test="${qnaVo.content.length()>=60}">${fn:substring(qnaVo.content,0,60)}...</c:if>
		 							 		<c:if test="${qnaVo.content.length()<60}">${qnaVo.content}</c:if>
										</td>
										<td>${fn:substring(qnaVo.day,0,19)}</td>
										<td>${qnaVo.hostIp}</td>
									</tr>
								</c:forEach>
								<tr><td colspan="7" class="m-0 p-0"></td></tr>
							</table>
				    <a href="${ctp}/hotelReserveList.tel" class="card-link">+more</a>
				  </div>
				</div>
				<br/>
				<div class="card"  style="border:none">
				  <div class="card-body"  style="border:none">
				    <h4 class="card-title">Review</h4>
							<table class="table table-bordered table-hover table-responsive-sm text-center mt-0">
								<tr class="table-dark text-dark text-center">
									<th>객실이름</th>
									<th>방문날짜</th>
									<th width="40%">제목</th>
									<th>작성자</th>
									<th>작성일</th>
								</tr>
									<c:if test="${empty pdsVos}"><tr><td colspan="5"><h6>후기 내역이 없습니다.</td></tr></h6></c:if>
									<c:forEach var="pdsVo" items="${pdsVos}">
									<tr class="text-center">
										<td>${pdsVo.roomName}</td>
										<td>${pdsVo.checkIn}~${pdsVo.checkOut}</td>
										<td><a href="${ctp}/pdsContent.pds?idx=${pdsVo.idx}">${pdsVo.title}<c:if test="${pdsVo.hour_diff <= 24}"><div class="badge badge-danger">N</div> </c:if></a></td>
										<td>${pdsVo.mid}${pdsVo.midName}</td>
										<td>${fn:substring(pdsVo.fDate,0,10)}</td>
									</tr>
									</c:forEach>
								<tr><td colspan="7" class="m-0 p-0"></td></tr>
							</table>
				    <a href="${ctp}/hotelReserveList.tel" class="card-link">+more</a>
				  </div>
				</div>
				<br/>
				<div class="card"  style="border:none">
				  <div class="card-body">
				    <h4 class="card-title">My Q&A</h4>
							<table class="table table-bordered table-hover table-responsive-sm">
								<tr class="table-dark text-dark  text-center">
									<th>닉네임</th>
									<th>이메일</th>
									<th>문의사항</th>
									<th>작성일</th>
									<th>hostIP</th>
								</tr>
								<c:if test="${empty qnaVos}"><tr><td class="text-center" colspan="5"><h6>Q&A 내역이 없습니다.</h6></td></tr></c:if>
								<c:forEach var="qnaVo" items="${qnaVos}">
									<tr class="text-center">
										<td>${qnaVo.nickName}</td>
										<td>${qnaVo.email==""?'없음':qnaVo.email}</td>
										<td>
											<c:if test="${qnaVo.content.length()>=60}">${fn:substring(qnaVo.content,0,60)}...</c:if>
		 							 		<c:if test="${qnaVo.content.length()<60}">${qnaVo.content}</c:if>
										</td>
										<td>${fn:substring(qnaVo.day,0,19)}</td>
										<td>${qnaVo.hostIp}</td>
									</tr>
								</c:forEach>
								<tr><td colspan="7" class="m-0 p-0"></td></tr>
							</table>
				    <a href="${ctp}/qnaMain.qna" class="card-link">+more</a>
				  </div>
				</div>
			</td>
		</tr>
	</table>
</div>
  <!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">비밀번호 확인</h4>
          <button type="button" class="close" data-dismiss="modal">×</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	비밀번호 : 
        	<input type="password" name="pwd" id="pwd" class="form-control">
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-warning" onclick="unresister()">탈퇴하기</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>

<p><br/></p>
<div style="height:100px"></div>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>