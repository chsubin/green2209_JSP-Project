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
</head>
<script>

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
	function qnaDelete(idx){
		
	  $.ajax({
		     url : "${ctp}/qnaDelete.qna",
		     type : "get",
			   data : {idx:idx}, // data:query,   ==> 서버의 전송구간
		    success: function(res){
		      if(res=="1"){
		    	  alert("Q&A 삭제 완료되었습니다.");
		    	  location.reload();
		      }
		      else {
				  	alert("삭제 실패~~");		
		      }
		    },
		    error: function(){
				  	alert("전송 실패~~");		
		    }
		 });
		}
	
	function answerInput(idx){
		let content = $("#replyContent"+idx).val();
			
	  $.ajax({
		     url : "${ctp}/qnaReplyInput.qna",
		     type : "get",
			   data : {
						qnaIdx : idx,
						mid : "${sMid}",
			   		content : content
			   }, // data:query,   ==> 서버의 전송구간
		    success: function(res){
		      if(res=="1"){
		    	  alert("댓글 작성 완료.");
		    	  location.reload();
		      }
		      else {
				  	alert("댓글 작성 실패~~");		
		      }
		    },
		    error: function(){
				  	alert("전송 실패~~");		
		    }
		 });
		
	}
	//댓글 삭제
	function qnaReplyDelete(idx){
		
		  $.ajax({
			     url : "${ctp}/qnaReplyDelete.qna",
			     type : "get",
				   data : {idx:idx}, // data:query,   ==> 서버의 전송구간
			    success: function(res){
			      if(res=="1"){
			    	  alert("Q&A 답변 삭제 완료되었습니다.");
			    	  location.reload();
			      }
			      else {
					  	alert("답변 삭제 실패~~");		
			      }
			    },
			    error: function(){
					  	alert("전송 실패~~");		
			    }
			 });
			}
</script>
<body>
<jsp:include page="/include/header.jsp"></jsp:include>
<div class="container" style="margin-top:30px;">
	<div style="height:30px"></div>
	<h2>Q & A</h2>
	<hr style="border-top : 2px solid #444"/>
	<h4>글 쓰기</h4>
	<form name="myform" method="post" action="${ctp}/qnaInput.qna">
		 <table class="table table-bordered">
			<tr>
			  <th style="width:20%;">성명</th>
			  <td style="width:25%;"><input type="text" name="nickName" class="form-control"/></td>
			  <th style="width:20%;">아이디</th>
			  <td style="width:35%;"><input type="text" name="mid" value="${sMid}" readonly/></td>
			</tr>
			<tr>
			  <th style="width:20%;">전자우편</th>
			  <td style="width:25%;"><input type="email" name="email" class="form-control"/></td>
			  <th style="width:20%;">IP</th>
			  <td style="width:35%;"><%=request.getRemoteAddr()%></td>
			</tr>
			<tr>
			  <th>문의사항</th>
			  <td colspan="3"><textarea name="content" rows="3"  class="form-control"></textarea></td>
			</tr>
	  </table>
	  <table class="table table-borderless">
	  	<tr class="text-center">
	  		<td><input type="submit" class="btn btn-success" value="작성완료"/>
	  		<input type="button" class="btn btn-danger" value="다시쓰기"/></td>
	  	</tr>
	  </table>
	<br/><br/>
  <c:set var="curScrStartNo" value="${curScrStartNo}"/>
  	<hr class="m-0 p-0" style="border-top: solid #ccc 2px"/>
	  <table class="table table mb-0">
	 	 <tr style="background-color:lavender;" class="text-center">
		  	<th width="15%">작성자</th>
		  	<th width="50%">제목<span id="replySw${vo.idx}"></span></th>
		  	<th width="5%"></th>
		  	<th width="15%">작성일</th>
		  	<th width="15%">Ip</th>
	  	</tr>
	  	</table>
 		 <c:forEach var="vo" items="${vos}" varStatus="st">
	  <table class="table table mb-0 ">
	  	<tr>
		  	<td width="15%" class="text-center">${vo.nickName}(${vo.mid}<c:if test="${empty vo.mid}">비회원</c:if>)</td>
		  	<td width="50%"><a href="javascript:showDetail('${vo.idx}')" id="sel${vo.idx}">
		  		<c:if test="${vo.content.length()>=40}">${fn:substring(vo.content,0,40)}...</c:if>
		  		<c:if test="${vo.content.length()<40}">${vo.content}</c:if>
		  	</a></td>
		  	<th width="5%"><c:if test="${sMid==vo.mid||sLevel<2}"><button type="button" class="badge" onclick="qnaDelete(${vo.idx})">삭제</button></c:if></th>
		  	<td width="15%" class="text-center">${fn:substring(vo.day,0,11)}</td>
		  	<td width="15%" class="text-center">${vo.hostIp}</td>
	  	</tr>
	  </table>
  </form>
	  <div id="detail${vo.idx}" style="display:none;"class="pb-3 bg-light">
	  	<table width="100%" class="table mt-1"> <!-- 댓글 작성한 부분 -->
	  		<tr class="m-0 p-0">
	  			<th width="10%" class="text-right pb-0 mb-0"></th>
	  			<td class="pb-0 mb-0">
	  				${vo.content}
	  			</td>
	  			<td width="15%" class="pb-0 mb-0">
	  			</td>
	  		</tr>
	  	</table>
    <c:set var="sw" value="0"/>
	   <c:forEach var="qrVo" items="${qrVos}" varStatus="st">
	    <c:if test="${vo.idx==qrVo.qnaIdx}"> 
	    <c:set var="sw" value="1"/>
		  	<table width="100%" class="table mt-1"> <!-- 댓글 작성한 부분 -->
		  		<tr class="m-0 p-0">
		  			<th width="15%" class="text-right pb-0 mb-0">답변 완료</th>
		  			<td class="pb-0 mb-0">
		  				<i class='bx bxs-hand-right'></i>${qrVo.content}
		  			</td>
		  			<td width="15%" class="pb-0 mb-0">
		  				<c:if test="${sLevel<2}"><button type="button" class="badge" onclick="qnaReplyDelete(${qrVo.idx})">답변 삭제</button></c:if>
		  			</td>
		  		</tr>
		  	</table>
	   	</c:if>
	  	</c:forEach>
 			<c:if test="${sw==0}">
				<table width="100%" class="table mt-1">
		  		<tr class="m-0 p-0">
		  			<th width="15%" class="text-right pb-0 mb-0"></th>
		  			<td class="pb-0 mb-0" colspan="2">아직 답변이 작성되지 않았습니다.</td>
		  		</tr>
		  	</table>
  		</c:if>
	  <c:if test="${sLevel<2}">
		  <table width="100%" class="bg-light">
		  	<tr>
		  		<td width="90%" class="pl-5 pt-3">
		  			<textarea name="replyContent${vo.idx}" id="replyContent${vo.idx}" rows="3" class="form-control"></textarea>
		  		</td>
		  		<td>
		  			<input type="button" class="btn btn-success pt-1" value="작성" onclick="answerInput(${vo.idx})"/>
		  		</td>
		  	</tr>
		  </table>
	  </c:if>
	  </div>
	  <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
	</c:forEach>
	<hr class="m-0 p-0"/>
	<br/>
  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3(6) / 다음블록 / 마지막페이지 -->
  <div class="text-center">
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