<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
</style>
</head>
<script>
	'use strict';

  function fCheck() {
	  let fName1 = $("#fName1").val();
	  let fName2 = $("#fName2").val();
	  let fName3 = $("#fName3").val();
	  let maxSize = 1024 * 1024 * 30;
	  let title = $("#title").val();
	  let pwd = $("#pwd").val();
	  
	  if(fName1.trim() == ""||fName2.trim()==""||fName3.trim()=="") {
		  alert("업로드할 파일명을 모두 선택해주세요.");
		  return false;
	  }
	  
	  // 파일 사이즈 처리...
	  let fileSize = 0;
	  for(let i=1; i<=3; i++) {
		  let imsiName = 'fName' + i;
		  if(isNaN(document.getElementById(imsiName))) {	// 내용이 있을경우만 해당 if블록을 처리한다. 즉 파일이 없으면 수행하지 않는다.
			  let fName = document.getElementById(imsiName).value;
			  if(fName != "") {
				  fileSize += document.getElementById(imsiName).files[0].size;
				  let ext = fName.substring(fName.lastIndexOf(".")+1);
				  let uExt = ext.toUpperCase();
				  if(uExt != "JPG" && uExt != "PNG" && uExt != "JFIF" && uExt != "GIF") {
					  alert("업로드 가능한 파일은 'JPG/PNG/JFIF/GIF' 입니다.");
					  return false;
			    }
			  }
			  /* 
			  else {
				  alert("빈 파일박스에 파일을 선택해 주세요");
				  return false;
			  }
			   */
		  }
	  }
	  if(fileSize > maxSize) {
		  alert("업로드할 파일의 최대용량은 30MByte 입니다.");
		  return false;
	  }
	  else {
		  myform.submit();
	  }
  }
  
</script>
<body >
<jsp:include page="/include/adMenu.jsp"></jsp:include>
<p><br/></p>
<div class="main" >
	<h2 class="text-center">객 실 등 록</h2>
	<div style="height:30px"></div>
  <form name="myform" method="post" action="${ctp}/adRoomInputOk.ad" enctype="multipart/form-data">
	 	<div class="container" style="width:90%">
	  	<div class="row">
		  	<div class="col">
				  <div class="mb-2">
				    분류 :
				    <select name="part" id="part" class="form-control">
				  	  <option value="스탠다드" ${part == '스탠다드' ? 'selected' : ''}>스탠다드</option>
				  	  <option value="이그제큐티브" ${part == '이그제큐티브' ? 'selected' : ''}>이그제큐티브</option>
				  	  <option value="스위트" ${part == '스위트' ? 'selected' : ''}>스위트</option>
				  	</select>
				  </div>
				  <div class="mb-2">
				    객실명 :
				    <input type="text" name="name" id="name" placeholder="ex)스탠다드 디럭스" class="form-control" required />
				  </div>
				  <div class="mb-2">
				    내용 : 
				    <textarea rows="8" name="content" id="content" class="form-control"  placeholder="객실소개를 자세하게 적어주세요!"  required></textarea>
				  </div>
		  	</div>
		  	<div class="col">
				  <div class="mb-2">
				  	가격 : (ex)200000
				    <input type="number" name="price" id="price" placeholder="가격을 입력하세요." class="form-control" required />
				  </div>
				  <div class="mb-2">
				    전망 : (ex)남산 또는 시티뷰
				    <input type="text" name="roomView" id="roomView" placeholder="전망을 입력하세요." class="form-control" required />
				  </div>
				  <div class="mb-2">
				    침대 : (ex)더블(킹 사이즈), 트윈
				    <input type="text" name="bed" id="bed" placeholder="침대 사이즈를 입력하세요." class="form-control" required />
				  </div>
				  <div class="mb-2">
				    크기 :	(ex) 36
				    <input type="number" name="size" id="size" placeholder="객실 크기를 입력하세요." class="form-control" required />
				  </div>
				  <div class="mb-2">
				    구성 :(ex) 침실1, 욕실1, 화장실1
				    <input type="text" name="formation" id="formation" placeholder="룸 구성을 입력하세요." class="form-control" required />
				  </div>
				  <div class="mb-2 form-inline">
				    룸 개수  &nbsp;&nbsp;
				    <input type="number" name="numOfRoom" id="numOfRoom" placeholder="ex) 10" class="form-control"  required /> 
				    기준인원  
				    <select name="numOfCustom" class="form-control">
				    	<option selected>2</option><option>3</option><option>4</option><option>5</option><option>6</option> 
				    </select>
				  </div>
		  	</div>
	  	</div>
			<div>
		    <input type="file" name="fName1" id="fName1" class="form-control-file border mb-2"/>
		    <input type="file" name="fName2" id="fName2" class="form-control-file border mb-2"/>
		    <input type="file" name="fName3" id="fName3" class="form-control-file border mb-2"/>
		  </div>
		  <div class="mb-2 text-center form">
		    <input type="button" value="등록하기" onclick="fCheck()" class="btn btn-primary"/> &nbsp;
		    <input type="reset" value="다시쓰기" class="btn btn-warning"/> &nbsp;
		    <input type="button" value="돌아가기" onclick="location.href='${ctp}/adRoom.ad?part=${part}';" class="btn btn-secondary"/> &nbsp;    
		  </div>
		</div>
		<input type="hidden" name="pag" value="${pag}" >
		<input type="hidden" name="part" value="${part}" >
  </form>
</div>
<p><br/></p>
</body>
</html>