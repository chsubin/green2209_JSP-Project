<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% String sMid = session.getAttribute("sMid")==null? "":(String)session.getAttribute("sMid");
	 int sLevel =session.getAttribute("sLevel")==null? 99:(int) session.getAttribute("sLevel");
	 pageContext.setAttribute("sMid", sMid);
	 pageContext.setAttribute("sLevel", sLevel);
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>hotelReserve.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
<!--   <link rel="stylesheet" type="text/css" href="form.css"> -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<jsp:include page="/include/hotel.jsp"></jsp:include>
  <style>
  ul.nav-pills {
  	position: -webkit-sticky;
  	position: sticky;
    top: 100px;
  }
.col-sm-4{
	font-weight:bold;
	text-align:right;
}
label:hover {
	cursor:pointer;
}
  </style>
</head>
<script>
	'use strict';
	function calc(gijun,buho){
		 let gi = $("#"+gijun).html();
		
    if(buho=='+'){
    	gi = gi-1+2;
    }
    else {
    	gi = gi-1;
    }
    if(gi==-1)gi=0;
    else if(gi==7)gi=6;
    
		$("#"+gijun).html(gi);
	}

 	function modalView() {
 		//체크인 체크아웃 날짜 계산
 		
 		let daydiff = parseInt(new Date("${param.checkOut}") - new Date("${param.checkIn}"))/ (24 * 60 * 60 * 1000);
 		let usePoint = myform.usePoint.value;
		
		let num = $("#num").html();
  	let numOfCustom = "${vo.numOfCustom}";
		let ad = $("#ad").html();
		let cd = $("#cd").html();
		let name = $("#name").val();
		let email = $("#email").val();
		let phoneNumber = $("#phoneNumber").val();
		let city = $("#city").val();
		let cname = $("#cname").val();
		let cnum = $("#ccnum").val();
		let expyear = $("#expyear").val();
		let expmonth = $("#expmonth").val();
		let coupon =$("#coupon").val().split('/')[1];
		let price = Number((ad*22000)+(cd*15000))+Number((num-numOfCustom)*30000)+Number(("${vo.price}"-1+1)*daydiff)-usePoint-coupon;
		let sLevel ="${sLevel}";
	  if(sLevel==2){
		  price= Math.floor(price*0.8/1000)*1000;
	  }
		let content = $("#content").val();
		
		if(coupon>0){
			content = content +"/" + coupon+"원 쿠폰 사용"
		}
		
  	$("#moroomname").html("${vo.name}");
  	$("#mocheckIn").html("${param.checkIn}");
  	$("#mocheckOut").html("${param.checkOut}");
  	$("#monumOfCustom").html(num);
  	$("#moad").html(ad);
  	$("#mocd").html(cd);
  	$("#moname").html(name);
  	$("#moemail").html(email);
  	$("#mophoneNumber").html(phoneNumber);
  	$("#moadd").html(city);
  	$("#mocname").html(cname);
  	$("#mocnum").html(cnum);
  	$("#moexp").html(expyear+"-"+expmonth);
  	$("#moprice").html(price+"원");
  	$("#mocontent").html(content);
  	
		$("#adultF").val(ad);
		$("#childF").val(cd);
  	myform.price.value=price;
  	myform.expiration.value=expyear+"-"+expmonth;
		$("#numOfCustom").val(num);

  }
  function fCheck() {
		let daydiff = parseInt(new Date("${param.checkOut}") - new Date("${param.checkIn}"))/ (24 * 60 * 60 * 1000);
 		let usePoint = myform.usePoint.value;
 	
		let num = $("#num").html();
  	let numOfCustom = "${vo.numOfCustom}";
		let ad = $("#ad").html();
		let cd = $("#cd").html();
		let name = $("#name").val();
		let email = $("#email").val();
		let phoneNumber = $("#phoneNumber").val();
		let city = $("#city").val();
		let cname = $("#cname").val();
		let cnum = $("#ccnum").val();
		let expyear = $("#expyear").val();
		let expmonth = $("#expmonth").val();
		let coupon =$("#coupon").val().split('/')[1];
	  let price = Number((ad*22000)+(cd*15000))+Number((num-numOfCustom)*30000)+Number(("${vo.price}"-1+1)*daydiff)-usePoint-coupon;
		let sLevel ="${sLevel}";
	  if(sLevel==2){
		  price= Math.floor(price*0.8/1000)*1000;
	  }
	  
		let content = $("#content").val();
  	
		$("#adultF").val(ad);
		$("#childF").val(cd);
  	myform.price.value=price;
  	myform.expiration.value=expyear+"-"+expmonth;
		$("#numOfCustom").val(num);
		
		if(coupon>0){
			$("#content").val(content+"/"+coupon+"원 쿠폰 사용");
			content = $("#content").val();
		}
		//유효성 검사		
    const regName =/^[가-힣]{2,13}$/g;
    const regNameEng =/^[a-z]{2,13}$/g;
    const regTel = /^010-[0-9]{3,4}-[0-9]{4}$/gm
    const regEmail=/^[a-z0-9]+@[a-z]+\.[a-z]+$/gm;
    const regCnum = /^[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}$/gm
    
    
    //파일 전송 전에 파일에 관한 사항 체크..(파일명이 넘어올 경우는 해당파일을 넘기고, 비었으면 'noimage.jpg'를 넘겨준다.)
    if(!name.match(regName)&&!name.match(regNameEng)){alert("이름은 2~13자의 한글이나 영어만 사용해주세요.");return;}
    else if(!email.match(regEmail)){alert("이메일은 30자 이하로 형식에 맞춰주세요.");return;}
    else if(!phoneNumber.match(regTel)){alert("연락처는 형식에 맞추어주세요.(010-0000-0000)");return;}
    else if(cname.trim()==''){alert("카드이름을 입력해주세요.");return;}
    else if(!cnum.match(regCnum)){alert("카드번호는 형식에 맞추어 입력해주세요.");return;}
    else if(expyear.trim()==''||expmonth.trim()==''){alert("카드 만료일자를 입력해주세요.");return;}
		if(usePoint%1000!=0){
			alert("포인트는 1,000단위로 사용해주세요.");return;
		}
			
		
  	
	  myform.submit(); 
		
	}


</script>
<body data-spy="scroll" data-target="#myScrollspy" data-offset="1">
<jsp:include page="/include/header.jsp"/>
<p><br/></p>
<div class="container-fluid">
  <div class="row">
    <div class="col-sm-2 col-4" id="myScrollspy">
      <ul class="nav nav-pills flex-column ml-5" >
        <li class="nav-item">
          <a class="nav-link btn-outline-secondary" href="#section1">객실</a>
        </li>
        <li class="nav-item">
          <a class="nav-link btn-outline-secondary" href="#section2">옵션선택</a>
        </li>
        <li class="nav-item">
          <a class="nav-link btn-outline-secondary" href="#section3">결제정보</a>
        </li>
      </ul>
    </div>
	   <div class="col-sm-10 col-8">
		   <form name="myform" method="post" action="${ctp}/hotelReserveOk.tel">
	      <div id="section1"><!-- 객실정보 가져오기!! -->
				<div style="margin-top:60px"><h2><b>Reservation</b></h2></div> 
				<hr style="border : 1px solid #444;width:80%" />
					<!-- ============================================== -->
	   	    <h4>객 실</h4>
	   	    <div style="height:20px"></div>
					<hr style="width:80%"/>
					<div class="row">
						<c:set var="sw" value="1"></c:set>
						<div class="col-sm-6">
							<c:set var="fSNames" value="${fn:split(vo.fSName,'/')}"></c:set>
							<img src="${ctp}/data/room/${fSNames[fn:length(fSNames)-1]}" width="100%"/>
						</div>
						<div class="col-sm-6">
							<h4><b>${vo.name}</b></h4><br/>
							<p>객실 크기 : ${vo.size}m<sup>2</sup><br/>
							가격 : <fmt:formatNumber value="${vo.price}" pattern="#,##0"/><br/>
							객실 수 : ${vo.numOfRoom}<br/>
						</div>
					</div>
	      </div>
	      <div id="section2" class=""  style="width:80%"> 
	 	    	<div style="height:20px"></div>
					<hr/>
	   	    <div style="height:20px"></div>
	        <h4>옵션 선택 및 유의사항</h4>
	   	    <div style="height:20px"></div>
	        <div class="row" style="background-color:#FAECC5;border-top:2px solid #422700;padding:5px">
	        	<div style="color:#8E8059">옵션 선택</div>
	        </div> 
	        <div class="row" style="border: 1px solid #ccc;padding:20px">
	       		<div class="col col-sm-6 text-center">
	       			<h5>옵션사항</h5>
	       			<div class='row mt-3'> 
	       				<table class="table table-borderless">
	       					<tr>
	       						<td class="text-left">인원(기준인원: ${vo.numOfCustom}명 초과 시 +30,000원/인) </td>
	       						<td width="5%" class="text-center pl-0 pr-0 m-0"><div class="btn-sm border" onclick="calc('num','-')">-</div></td>
	       						<td width="5%" class="text-center m-0"><div id="num" style="width:30px;height:30px">${vo.numOfCustom}</div></td>
	       						<td width="5%" class="text-center  pl-0 pr-0 m-0"><div class="btn-sm border" onclick="calc('num','+')">+</div></td>
	       					</tr>
	       					<tr>
	       						<td class="text-left">성인조식 / 22,000원</td>
	       						<td width="5%" class="text-center pl-0 pr-0 m-0"><div class="btn-sm border" onclick="calc('ad','-')">-</div></td>
	       						<td width="5%" class="text-center m-0"><div id="ad" style="width:30px;height:30px">0</div></td>
	       						<td width="5%" class="text-center  pl-0 pr-0 m-0"><div class="btn-sm border" onclick="calc('ad','+')">+</div></td>
	       					</tr>
	       					<tr>
	       						<td class="text-left">어린이조식 / 15,000원</td>
	       						<td width="5%" class="text-center pl-0 pr-0 m-0"><div class="btn-sm border" onclick="calc('cd','-')">-</div></td>
	       						<td width="5%" class="text-center m-0"><div id="cd" style="width:30px;height:30px">0</div></td>
	       						<td width="5%" class="text-center  pl-0 pr-0 m-0"><div class="btn-sm border" onclick="calc('cd','+')">+</div></td>
	       					</tr>
	       					<tr>
	       						<td class="text-left">포인트 / ${memVO.point}점<br/>(*10,000점 이상/1,000단위 사용)</td>
	       						<td colspan="3" class="text-center m-0">
	       							 <input type="number" name="usePoint" step="1000" value="0" ${memVO.point>=10000?'':'disabled'}/>
	       						</td>
	       					</tr>
	       					<tr>
	       						<td class="text-left">쿠폰 </td>
	       						<td colspan="3" class="text-center m-0">
											<select class="form-control" name="coupon" id="coupon">
												<option value="0/0">선택</option>
												<c:forEach var="cVo" items="${cVos}">
													<option value="${cVo.idx}/${cVo.price}">${cVo.title}</option>
												</c:forEach>
											</select>	       							
	       						</td>
	       					</tr>
	       				</table>
	       			</div>
	       		</div>
	       		<div class="col col-sm-6 text-center">
	       			<p>추가 요청사항</p>
	       			<textarea name="content" id="content" rows="5" style="width:90%"></textarea>
	     
	       		</div>
	        </div>
	        <div class="row" style="background-color:#FAECC5;border-top:1px solid #ccc;padding:5px">
	        	<div style="color:#8E8059">유의사항</div>
	        </div> 
	        <div class="row" style="border: 1px solid #ccc;padding:20px;">
		   			<ul>
		   				<li>${vo.numOfCustom}인 1실 기준</li>
		   				<li>체크인 시 등록카드 작성 및 투숙객 본인 확인을 위해 본인 사진이 포함된 신분증을 반드시 제시해 주시기 바랍니다.</li>
		   				<li>37개월 미만 유아는 조식이 무료입니다.</li>
		   				<li>숙박예정일 1일전 18시까지는 위약금 없이 취소 가능</li>
		   			</ul>
	        </div>
	      </div>        
	 	    <div style="height:20px"></div>
					<!-- ================================================== -->
				<div><br/></div>
	      <div id="section3" class=""  style="width:80%">
	      <hr/> 
	 	    <div style="height:20px"></div>
	      <h4>고객 정보 입력</h4>
	 	    <div style="height:20px"></div>
	      <!-- 결제 폼!! --> 
	      	<div class="row" style="border:1px solid #ccc;padding:20px">
	      		<div class="col col-sm-6 form-group">
	            <label for="name"><i class="fa fa-user"></i> Full Name</label>
	            <input type="text" id="name" name="name" placeholder="ex)홍길동" value="${memVO.nameKor}" class="form-control mb-3">
	            <label for="email"><i class="fa fa-envelope"></i> Email</label>
	            <input type="text" id="email" name="email" placeholder="ex)john@example.com" value="${memVO.email}" class="form-control mb-3">
	            <label for="phoneNumber"><i class='bx bxs-phone'></i> PhoneNumber</label>
	            <input type="text" id="phoneNumber" name="phoneNumber" placeholder="ex)010-0000-0000" value="${memVO.phoneNumber}"  class="form-control mb-3">
	            <label for="city"><i class="fa fa-institution"></i> City(여권기준)</label>
	            <input type="text" id="city" name="city" placeholder="ex)서울" value="서울" class="form-control mb-3">
	      		</div>
	      		<div class="col col-sm-6 form-group">
	      			<label for="fname">Accepted Cards</label>
	            <div class="icon-container">
	              <i class="fa fa-cc-visa" style="color:navy;"></i>
	              <i class="fa fa-cc-amex" style="color:blue;"></i>
	              <i class="fa fa-cc-mastercard" style="color:red;"></i>
	              <i class="fa fa-cc-discover" style="color:orange;"></i>
	            </div>
	            <label for="cname">Name on Card</label>
	            <input type="text" id="cname" name="cardName" placeholder="John More Doe" value= "John More Doe" class="form-control">
	            <label for="ccnum">Credit card number</label>
	            <input type="text" id="ccnum" name="cardNumber" placeholder="1111-2222-3333-4444" value="1111-2222-3333-4444" class="form-control">
	            <label for="expyear" style="width:100%">유효기간</label>
	            <input type="text" id="expyear" name="expyear" placeholder="2025" value="2025" style="width:50%;border:1px solid #CCC">년
	            <input type="text" id="expmonth" name="expmonth" placeholder="10" value="10" style="width:40%;border:1px solid #CCC">월
	         	</div>
	      	</div>
	<!-- 결제폼끝 -->
	      </div>
	      <!-- 버튼 -->
	      <div style="width:80%;text-align:center" class="mt-5">
	      	<input type="button" value="제출" onclick="modalView()"  data-toggle="modal" data-target="#myModal" class="btn btn-secondary">
	      	<input type="button" value="돌아가기" onclick="location.href='${ctp}/hotelReserve1.tel';" class="btn btn-secondary">
	      </div>
	      <input type="hidden" name="roomIdx" value="${vo.idx}"/>
	      <input type="hidden" name="roomName" value="${vo.name}"/>
	      <input type="hidden" name="mid" value="${sMid}"/>
	      <input type="hidden" name="checkIn" value="${param.checkIn}"/>
	      <input type="hidden" name="checkOut" value="${param.checkOut}"/>
	      <input type="hidden" name="adultF" id ="adultF"/>
	      <input type="hidden" name="childF" id="childF"/>
	      <input type="hidden" name="price"/>
	      <input type="hidden" name="expiration"/>
	      <input type="hidden" name="numOfCustom" id="numOfCustom"/>
	    </form>
	   </div>
	   
  </div>
</div>


<!-- The Modal(폼태그로 비밀번호 처리하기 위한 모달창) -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content bg-light">
    
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">예약 확인</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
			  <div class="table table-bordered">
					<div class="row  pt-1">
						<div class="col col-sm-4">객실</div>
						<div class="col"><span id = "moroomname"></span></div>
					</div>
					<div class="row pt-1">
						<div class="col col-sm-4">날짜</div>
						<div class="col"> <span id = "mocheckIn"></span> ~ <span id = "mocheckOut"></span></div>
					</div>
					<div class="row pt-1">
						<div class="col col-sm-4">인원</div>
						<div class="col"><span id = "monumOfCustom"></span> (기준인원 :${vo.numOfCustom})</div>
					</div>
					<div class="row pt-1">
						<div class="col col-sm-4">조식</div>
						<div class="col">성인 <span id="moad"></span> , 아동 <span id="mocd"></span></div>
					</div>
					<div class="row pt-1">
						<div class="col col-sm-4">예약자 이름</div>
						<div class="col"><span id="moname"></span></div>
					</div>
					<div class="row pt-1">
						<div class="col col-sm-4">이메일</div>
						<div class="col"><span id="moemail"></span></div>
					</div>
					<div class="row pt-1">
						<div class="col col-sm-4">연락처</div>
						<div class="col"><span id="mophoneNumber"></span></div>
					</div>
					<div class="row pt-1">
						<div class="col col-sm-4">거주지</div>
						<div class="col"><span id="moadd"></span></div>
					</div>
					<div class="row pt-1">
						<div class="col col-sm-4">카드번호</div>
						<div class="col"><span id="mocnum"></span></div>
					</div>
					<div class="row pt-1">
						<div class="col col-sm-4">카드이름</div>
						<div class="col"><span id="mocname"></span></div>
					</div>
					<div class="row pt-1">
						<div class="col col-sm-4">유효기간</div>
						<div class="col"><span id="moexp"></span></div>
					</div>
					<div class="row pt-1">
						<div class="col col-sm-4">가격</div>
						<div class="col"><span id="moprice"></span></div>
					</div>
					<div class="row pt-1">
						<div class="col col-sm-4">추가요청사항</div>
						<div class="col"><span id="mocontent"></span></div>
					</div>
		    </div>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-info" onclick="fCheck();">예약</button>
        <button type="button" class="btn btn-danger" id="modalClose" data-dismiss="modal">취소</button>
      </div>
      
    </div>
  </div>
</div>


<p><br/></p>
<div style="height:100px"></div>
<jsp:include page="/include/footer.jsp"/>
</body>

</html>