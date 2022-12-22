<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>그린아트호텔</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="include/bs4.jsp"></jsp:include> 
	<jsp:include page="/include/hotel.jsp"></jsp:include>
</head>
<script>
'use strict';
	location.href ="${ctp}/main.tel"


</script>
<body>
<jsp:include page="/include/header2.jsp"></jsp:include>
<div class="container-fluid pl-5 pr-5" style="margin-top:30px;">
	<form name="myform" method="post" action="${ctp}/hotel/hotelReserve1.tel">
		<table class="table table-borderless p-0 m-0" style="text-align:center;">
			<tr class=" table border-bottom">
				<th style="width: 15%">  </th>
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
	<div class="row">
    <div class="col-sm-4">
      <h2>About Me</h2>
      <h5>Photo of me:</h5>
      <div class="fakeimg">Fake Image</div>
      <p>Some text about me in culpa qui officia deserunt mollit anim..</p>
      <h3>Some Links</h3>
      <p>Lorem ipsum dolor sit ame.</p>
      <ul class="nav nav-pills flex-column">
        <li class="nav-item">
          <a class="nav-link active" href="#">Active</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#">Disabled</a>
        </li>
      </ul>
      <hr class="d-sm-none">
    </div>
    <div class="col-sm-8">
      <h2>TITLE HEADING</h2>
      <h5>Title description, Dec 7, 2017</h5>
      <div class="fakeimg">Fake Image</div>
      <p>Some text..</p>
      <p>Sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
      <br>
      <h2>TITLE HEADING</h2>
      <h5>Title description, Sep 2, 2017</h5>
      <div class="fakeimg">Fake Image</div>
      <p>Some text..</p>
      <p>Sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
    </div>
  </div>
</div>
	<div>
		<div class="row">
			<div class="col sm-1"></div>
			<div class="col sm-10 padding: 0 auto">
				<iframe class="align-self-center" width="1400px" height="1000px" src="https://www.youtube.com/embed/1GjgpK_nWss?controls=0&autoplay=1&mute=1;playlist=1GjgpK_nWss&start=65" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
			</div>
			<div class="col sm-1"></div>
		</div>
	</div>
	<br/>

<div style="height:100px"></div>
<jsp:include page="/include/footer.jsp"/>
</body>
<script>
	'use strict';
	location.href ="${ctp}/main.tel"
	

</script>
</html>