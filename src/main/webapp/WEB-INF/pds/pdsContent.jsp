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

	function searchformSubmit() {
		mySearchForm.searchSw.value=1;
			mySearchForm.submit();
	}
	function replyInput(){
		let content = $("#content").val();
		
		if("${sLevel}"==99){
			alert("로그인 후 이용해 주세요.");
			return false;
		}
		
		  $.ajax({
			     url : "${ctp}/pdsReplyInput.pds",
			     type : "get",
				   data : {
							pdsIdx : "${vo.idx}",
							mid : "${sMid}${sName}",
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
	function deleteReply(idx){
		let ans = confirm("댓글을 삭제하시겠습니까?");	
		  if(ans){
			  $.ajax({
			     url : "${ctp}/pdsReplyDelete.pds",
			     type : "get",
				   data : {idx:idx}, // data:query,   ==> 서버의 전송구간
			    success: function(res){
			      if(res=="1"){
			    	  location.reload();
			      }
			      else {
					  	alert("댓글 삭제 실패~~");		
			      }
			    },
			    error: function(){
					  	alert("전송 실패~~");		
			    }
			 });
		 }
	}
	
	
</script>
<body>
<jsp:include page="/include/header.jsp"></jsp:include>
<div class="container" style="margin-top:30px;">
	<div style="height:30px"></div>
	<h2>REVEIW</h2>
	<hr style="border : 1px solid #444"/>
	<br/>
  <table class="table table-borderless">
    <tr>
      <td class="text-right">hostIp : ${vo.hostIp}</td>
    </tr>
  </table>
  <table class="table table-bordered">
    <tr>
      <th>글쓴이</th>
      <td>${vo.mid}${vo.midName}</td>
      <th>글쓴날짜</th>
      <td>${fn:substring(vo.fDate,0,fn:length(vo.fDate)-2)}</td>
    </tr>
    <tr>
      <th>글제목</th>
      <td colspan="3">${vo.title}</td>
    </tr>
    <tr>
      <th>객실</th>
      <td width="40%"><c:if test="${vo.roomName!=''}">${vo.roomName}<br/>(방문일 : ${vo.checkIn}~${vo.checkOut})</c:if></td>
      <th>조회수</th>
      <td>${vo.readNum}</td>
    </tr>
    <tr>
      <td class="p-5" width="90%" colspan="4" style="height:220px">${fn:replace(vo.content, newLine, "<br/>")}<br/>
		    <c:set var="fSNames" value="${fn:split(vo.fSName,'/')}"/>
			  <c:forEach var="fSName" items="${fSNames}" varStatus="st"><br/><br/>
			    <c:set var="fSNameLen" value="${fn:length(fSName)}"/>
			  	<c:set var="ext" value="${fn:substring(fSName,fSNameLen-3,fSNameLen)}"/>
			  	<c:set var="extUpper" value="${fn:toUpperCase(ext)}"/>
			  	<c:if test="${extUpper=='JPG' || extUpper=='GIF' || extUpper=='PNG'|| extUpper=='JFIF'}">
			  		<div class="text-center" style="width:100%"><img src="${ctp}/data/pds/${fSName}" width="80%"/></div>
			  	</c:if>
			  </c:forEach>
      </td>
    </tr>
 		<tr>
 			<td colspan="4">
 					<h5>&nbsp;&nbsp;&nbsp;&nbsp;댓글</h5>
 				<div class="bg-light ml-3 mr-3 p-3" >
			    <c:forEach var="rVo" items="${rVos}">
			 	 		<div class="row mb-1">
			 	 			<div class="col-sm-2">
			 	 				<b>${rVo.mid}</b>
			 	 			</div>
			 	 			<div class="col-sm-6">
			 	 				${rVo.content}
			 	 			</div>
			 	 			<div class="col-sm-4 text-right">
			 	 				${fn:substring(rVo.rDate,0,19)}&nbsp;&nbsp;
			 	 				<c:if test="${sMid==rVo.mid}"><a href="javascript:deleteReply(${rVo.idx})"><font color="gray">x</font></a></c:if>
			 	 				<c:if test="${sMid!=rVo.mid}">&nbsp;</c:if>
			 	 			</div>
			 	 		</div>	
			 	 		<hr/>
			    </c:forEach>
				  <table width="100%" class="table-borderless">
				  	<tr>
				  		<td width="90%">
				  			<textarea name="content" id="content" rows="3" class="form-control"></textarea>
				  		</td>
				  		<td>
				  			<input type="button" class="btn btn-success pt-1" value="작성" onclick="replyInput()"/><br/>
				  		</td>
				  	</tr>
				  </table>
		    </div>
 			</td>
 		</tr>  
    <tr>
      <td colspan="4" class="text-center">
          <input type="button" value="돌아가기" onclick="location.href='${ctp}/pdsList.pds?pageSize=${pageSize}&pag=${pag}';" class="btn btn-secondary"/>
	        <c:if test="${(sMid == vo.mid || sLevel == 0 ||sRvIdx==vo.rvIdx)&&vo.roomName!=''}">
		        <input type="button" value="수정하기" onclick="location.href='${ctp}/pdsUpdate.pds?idx=${vo.idx}&pageSize=${pageSize}&pag=${pag}';" class="btn btn-success"/>
		        <input type="button" value="삭제하기" onclick="location.href='${ctp}/pdsDelete.pds?idx=${vo.idx}&pageSize=${pageSize}&pag=${pag}';" class="btn btn-danger"/>
	        </c:if>
      </td>
    </tr>
  </table>
	
	  <!-- 이전글/다음글 처리 -->
	  <table class="table table-borderless">
	    <tr>
	      <td>
	        <c:if test="${preVo.preIdx != 0}">
	          👈 <a href="${ctp}/pdsContent.pds?idx=${preVo.preIdx}&pageSize=${pageSize}&pag=${pag}">이전글 : ${preVo.preTitle}</a><br/>
	        </c:if>
	        <c:if test="${nextVo.nextIdx != 0}">
	          👉 <a href="${ctp}/pdsContent.pds?idx=${nextVo.nextIdx}&pageSize=${pageSize}&pag=${pag}">다음글 : ${nextVo.nextTitle}</a>
	        </c:if>
	      </td>
	    </tr>
	  </table>
  
</div>
<p><br/></p>
<div style="height:100px"></div>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>