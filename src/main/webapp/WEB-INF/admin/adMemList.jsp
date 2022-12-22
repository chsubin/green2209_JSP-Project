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
.detail{
	display:none;
}

</style>
</head>
<script>
'use strict';
	
	function showDetail(idx){
    if ($("#detail"+idx).is(':visible')){
			$("#detail"+idx).hide();
			$("#sel"+idx).css('text-decoration','none');

    }
    else
    {
			$("#detail"+idx).show();
			$("#sel"+idx).css('text-decoration','underline');

  	}
	}
	
	function midSearch() {
	  let mid = myform.mid.value;
	  if(mid.trim() == "") {
		  alert("아이디를 입력하세요!");
		  myform.mid.focus();
	  }
	  else {
		  myform.submit();
	  }
	}
	
	function delCheck(idx) { /*ajax처리 */
		let ans = confirm("탈퇴처리 시키겠습니까?");
		if(ans) {
			$.ajax({
				type  : "post",
				url   : "${ctp}/adMemberDel.ad",
				data  : {idx:idx},
				success:function(res) {
					if(res=="1"){
						alert("탈퇴 처리 성공");
						location.reload();
					}
					else{
						alert("탈퇴 처리 실패");
					}
				},
				error : function() {
					alert("전송 오류~~");
				}
			});
		}
	}
	
	function searCheck(e) {
		let ans = confirm("등급을 수정하시겠습니까?");
		if(!ans) return false;
		
		let items = e.value.split("/");
		
		let query = {
				idx : items[1],
				level : items[0]
		}
		
		$.ajax({
			type  : "post",
			url   : "${ctp}/adMemLevelUpdate.ad",
			data  : query,
			success:function(res) {
				if(res=="1"){
					alert("등급 수정완료!");
					location.reload();
				}
				else{
					alert("등급 수정 실패");
				}
			},
			error : function() {
				alert("전송 오류~~");
			}
		});
	}
</script>
<body >
<jsp:include page="/include/adMenu.jsp"></jsp:include>
<div class="main">
<p><br/></p>
	<div class="container-fluid">
	  <div><h2 class="text-center">회원 조회</h2></div>
		<div style="height:60px"></div>
	  <br/>
	  <form name="myform" method="post" action="${ctp}/adMemList.ad">
	  	<div class="row mb-2">
	  	  <div class="col form-inline">
	  	    <input type="text" name="mid" class="form-control" autofocus />&nbsp;
	  	    <input type="button" value="아이디개별검색" onclick="midSearch();" class="btn btn-secondary" />
	  	  </div>
	  	  <div class="col text-right"><button type="button" onclick="location.href='${ctp}/adMemList.ad';" class="btn btn-secondary">전체검색</button></div>
	  	</div>
	  </form>
	  <table width="90%" class="table table-hover text-center">
	    <tr class="bg-light text-dark">
	      <th>번호</th>
	      <th>아이디</th>
	      <th>성명</th>
	      <th>최초가입일</th>
	      <th>마지막접속일</th>
	      <th>누적포인트</th>
	      <th>등급</th>
	      <th>탈퇴유무</th>
	    </tr>
	    <c:forEach var="vo" items="${vos}" varStatus="st">
	      <tr>
	        <td>${vo.idx}</td>
	        <td><a href="javascript:showDetail(${vo.idx})">${vo.mid}</a></td>
	        <td>${vo.nameKor}</td>
	        <td>${vo.startDate}</td>
	        <td>${vo.lastDate}</td>
	        <td>${vo.memPoint}
	  				<c:if test="${vo.memPoint>=50000&&vo.level==3}">
	  					<div class="badge badge-danger">N</div>
	  				</c:if>      
	        </td>
	        <td>
	          <form name="levelForm" method="post" action="${ctp}/adMemberLevel.ad">
	            <!-- <select name="level" onchange="javascript:alert('회원정보를 변경하시려면, 등급변경버튼을 클릭하세요.');"> -->
	            <select name="level" onchange="searCheck(this)">
	              <option value="0/${vo.idx}" <c:if test="${vo.level==0}">selected</c:if>>관리자</option>
	              <option value="1/${vo.idx}" <c:if test="${vo.level==1}">selected</c:if>>운영자</option>
	              <option value="2/${vo.idx}" <c:if test="${vo.level==2}">selected</c:if>>VIP</option>
	              <option value="3/${vo.idx}" <c:if test="${vo.level==3}">selected</c:if>>일반회원</option>
	            </select>
	          </form>
	        </td>
	        <td>
	          <c:if test="${vo.userDel=='OK'}"><a href="javascript:delCheck(${vo.idx})"><font color="red">탈퇴신청</font></a></c:if>
	          <c:if test="${vo.userDel!='OK'}">활동중</c:if>
	        </td>
	      </tr>
	      <tr class="m-0 t-0">
	      	<td colspan="8" id="detail${vo.idx}" class="detail">
	      		<div class="border container bg-light">
	     	 			<h4>회원 상세 정보</h4>
	      			<div class="row">
	  						<div class="col">
									<table class="table">
										<tr>
											<th>고유번호</th>										
											<td>${vo.idx}</td>										
										</tr>									
										<tr>
											<th>아이디</th>										
											<td>${vo.mid}</td>										
										</tr>									
										<tr>
											<th>한글이름</th>										
											<td>${vo.nameKor}</td>										
										</tr>									
										<tr>
											<th>영어이름</th>										
											<td>${vo.nameEng}</td>										
										</tr>									
										<tr>
											<th>성별</th>										
											<td>${vo.gender}</td>										
										</tr>									
										<tr>
											<th>생일</th>										
											<td>${vo.birthday}</td>										
										</tr>	
										<tr>
											<th>email</th>										
											<td>${vo.email}</td>										
										</tr>									
									</table>
	  						</div>    			
	  						<div class="col">
									<table class="table">
										<tr>
											<th>연락처</th>										
											<td>${vo.phoneNumber}</td>										
										</tr>									
										<tr>
											<th>자택전화</th>										
											<td>${vo.homeNumber}</td>										
										</tr>									
										<tr>
											<th>주소</th>										
											<td>${vo.address}</td>										
										</tr>									
										<tr>
											<th>현재포인트</th>										
											<td>${vo.point}</td>										
										</tr>									
										<tr>
											<th>누적포인트</th>										
											<td>${vo.memPoint}</td>										
										</tr>									
										<tr>
											<th>가입일</th>										
											<td>${vo.startDate}</td>										
										</tr>									
										<tr>
											<th>마지막 방문일</th>										
											<td>${vo.lastDate}</td>										
										</tr>									
									</table>
	  						</div>    			
	      			</div>
	      		</div>
	      	</td>
	      </tr>
	    </c:forEach>
	    <tr><td colspan="8" class="m-0 p-0"></td></tr>
	  </table>
	</div>
	<br/>
	<!-- 블록 페이지 시작 -->
	<div class="text-center">
	  <ul class="pagination justify-content-center">
	    <c:if test="${pag > 1}">
	      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/adMemList.ad?pag=1"><i class='bx bx-first-page' ></i></a></li>
	    </c:if>
	    <c:if test="${curBlock > 0}">
	      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/adMemList.ad?pag=${(curBlock-1)*blockSize + 1}"><i class='bx bx-chevron-left' ></i></a></li>
	    </c:if>
	    <c:forEach var="i" begin="${(curBlock)*blockSize + 1}" end="${(curBlock)*blockSize + blockSize}" varStatus="st">
	      <c:if test="${i <= totPage && i == pag}">
	    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/adMemList.ad?pag=${i}">${i}</a></li>
	    	</c:if>
	      <c:if test="${i <= totPage && i != pag}">
	    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/adMemList.ad?pag=${i}">${i}</a></li>
	    	</c:if>
	    </c:forEach>
	    <c:if test="${curBlock < lastBlock}">
	      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/adMemList.ad?pag=${(curBlock+1)*blockSize + 1}"><i class='bx bx-chevron-right' ></i></a></li>
	    </c:if>
	    <c:if test="${pag < totPage}">
	      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/adMemList.ad?pag=${totPage}"><i class='bx bx-last-page'></i></a></li>
	    </c:if>
	  </ul>
  </div>
</div>
<!-- 블록 페이지 끝 -->
<p><br/></p>
</body>
</html>
