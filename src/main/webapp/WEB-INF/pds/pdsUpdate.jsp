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
		th{
			background-color : #ddd;
		}
	</style>
</head>
<script>
	'use strict';
	  function fCheck() {
		  let fName = $("#fName").val();
		  let maxSize = 1024 * 1024 * 30;
		  let title = $("#title").val();
		  let pwd = $("#pwd").val();
	  
  		if(fName == null) {
  			myform.photo.value = "noimage"
  		}
		  
		  // 멀티플 파일 사이즈 처리...
		  else{
	    	let fileLength = document.getElementById("fName").files.length; //선택한 파일의 개수(fName안에 들어있는 파일의 개수!)
	    	let fileSize=0;
		    	for(let i=0;i<fileLength;i++){
						fName = document.getElementById("fName").files[i].name;
			     	let ext = fName.substring(fName.lastIndexOf(".")+1);	// 확장자 발췌
			    	let uExt = ext.toUpperCase();
			     	fileSize += document.getElementById("fName").files[i].size; //파일사이즈를 다 더한다...
			     	myform.fileSize.value =fileSize;
			     	$("#fileSize").val(fileSize);

				    	if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "ZIP" && uExt != "HWP" && uExt != "PPT" && uExt != "PPTX"&& uExt != "JFIF") {
				    		alert("업로드 가능한 파일은 'JPG/GIF/PNG/ZIP/HWP/PPT/PPTX/JFIF' 입니다.");
				    		return;
				    	}
			    	}
		    	if(fileSize > maxSize) {
		    		alert("업로드할 파일의 최대용량은 30MByte 입니다.");
		    		return;
		    	}
		  }
			 myform.submit();

	  }
</script>
<body>
<jsp:include page="/include/header.jsp"></jsp:include>
<div class="container" style="margin-top:30px;">
	<div style="height:30px"></div>
	<h2>REVEIW</h2>
	<hr style="border : 1px solid #444;"/>
 		<form name="myform" method="post" action="${ctp}/pdsUpdateOk.pds"  enctype="multipart/form-data">
	    <table class="table">
      <tr>
        <th>작성자</th>
        <td>
        	${sName}${sMid}
        </td>
      </tr>
      <tr>
        <th>객실</th>
        <td>${vo.roomName} (방문일 ${vo.checkIn} ~ ${vo.checkOut})</td>
      </tr>
      <tr>
        <th>글제목</th>
        <td><input type="text" name="title" placeholder="글제목을 입력하세요" value="${vo.title}" autofocus required class="form-control"/></td>
      </tr>
      <tr>
        <th>글내용</th>
        <td><textarea rows="6" name="content" class="form-control" required>${vo.content}</textarea></td>
      </tr>
      <tr>
      	<th>파일</th>
      	<td><input type="file" name="fName" class="form-control-file" multiple/></td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="button" value="글올리기" onclick="fCheck()" class="btn btn-success"/> &nbsp;
          <input type="reset" value="다시입력" class="btn btn-warning"/> &nbsp;
          <input type="button" value="돌아가기" onclick="location.href='${ctp}/boList.bo';" class="btn btn-secondary"/>
        </td>
      </tr>
    </table>
    <input type="hidden" name="pag" value="${pag}"/>
    <input type="hidden" name="idx" value="${vo.idx}"/>
    <input type="hidden" name="rvIdx" value="${vo.rvIdx}"/>
    <input type="hidden" name="fileSize" id="fileSize"/>
    <input type="hidden" name="photo"/>
    <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
  </form>
  
</div>
<p><br/></p>
<div style="height:100px"></div>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>