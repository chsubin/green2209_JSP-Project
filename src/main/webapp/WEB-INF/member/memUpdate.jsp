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
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <style>
		/*=-----------------------------*/
		th {
		 width : 20%;
 		 background-color: #eee;
		}
  </style>
</head>
<script>
'user strict';
//회원가입폼 체크후 서버로 전송(submit) 
	let submitFlag=0;

	function fCheck(){
    //폼의 유효성 검사~~~
  	let tel1=myform.tel1.value;
    let tel2=myform.tel2.value;
    let tel3=myform.tel3.value;
    let tel = tel1 +"-" + tel2 + "-" + tel3;
    
  	let hometel1=myform.hometel1.value.trim();
    let hometel2=myform.hometel2.value.trim();
    let hometel3=myform.hometel3.value.trim();
    let hometel = hometel1 +"-" + hometel2 + "-" + hometel3+" ";
    
    let firstName = myform.firstName.value;
    let lastName = myform.lastName.value;
    
    //정규식
    let nameKor = myform.nameKor.value; const nameKorregx =/^[가-힣]*$/g;
    let nameEng = firstName+" "+lastName; const nameEngregx =/^[A-Za-z]*$/g;
    const regTel = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/gm
    const regHomeTel = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}\s$/gm
    let email1 = myform.email1.value;const emailregx=/^[0-9a-zA-Z]{2,45}/g;
    
    if(!nameKor.match(nameKorregx)){alert("한글 이름은 한글만 사용해주세요.");return;}
    else if(!firstName.match(nameEngregx)||!lastName.match(nameEngregx)){
    	if(firstName==""||lastName==""){alert("영어 이름을 입력해주세요.");return;}
    	alert("영어 이름은 영어만 사용해주세요.");
    	return;}
    else if(!tel.match(regTel)){alert("전화번호는 형식에 맞추어주세요.(010-0000-0000)");return;}
    else if(hometel2.length>0||hometel3.length>0){
    	if(!hometel.match(regHomeTel)){alert("전화번호는 형식에 맞추어주세요.지역번호-0000-0000");return;}
    }
    else if(!email1.match(emailregx)){alert("이메일은 45자 이하의 영문 대/소문자, 숫자만 입력해주세요.");return;}
    
    
	  submitFlag=1;
    //전송전에 모든체크가 끝났다면 submitFlage가 1이 되도록 처리 후 서버로 전송한다.
    if(submitFlag==1){
      myform.tel.value=tel;
      myform.hometel.value=hometel;
  
  //이메일을 하나로 묶어준다.
      email1 = myform.email1.value;
      let email2 = myform.email2.value;
      myform.email.value= email1+"@"+email2;
      
      //전송전에 '주소를 하나로 묶어서 전송처리'
      let postcode = myform.postcode.value + " ";
      let roadAddress= myform.roadAddress.value +" ";
      let detailAddress = myform.detailAddress.value +" ";
      let extraAddress = myform.extraAddress.value;
      myform.address.value= postcode+"/"+roadAddress+"/"+detailAddress+"/"+extraAddress;
      //영어이름 처리
      nameEng = nameEng.toUpperCase("nameEng");
      myform.nameEng.value=nameEng;
      
      
      myform.submit();
    }
    else{
	    alert("회원가입 실패~~");
    }
	}
//공백체크
	function spaceCheck(e){
		let spacecheck = e.value;
		e.value= spacecheck.replace(" ","");
		e.focus();
	}
	function fEmailChange(){
		semail = myform.email3.value;
		if(semail!='직접입력'){
			myform.email2.value=semail;
		}
		else {
			myform.email2.value="";
		}
	}
</script>
<body>
<jsp:include page="/include/header.jsp"></jsp:include>
<div class="container" style="margin-top:60px;">
  <h2>프로필 수정</h2>
  <hr style="border : 1px solid #444"/>
  <div style="height:60px"></div>
  <form name="myform" method="post" action="${ctp}/memUpdateOk.mem">
	  <table class="table form-group">
				<tr>
					<th>아이디</th>
					<td>${vo.mid}</td>
				</tr>
				<tr>
					<th>성명(국문)</th>
					<td><input type="text" name="nameKor" id="nameKor" value="${vo.nameKor}" onkeyup="spaceCheck(this)" class="form-control"></td>
				</tr>
				<tr>
					<th>성명(영문)</th>
					<td>
						First name(이름) <input type="text" name="firstName" id="firstName" value="${fn:split(vo.nameEng,' ')[0]}" onkeyup="spaceCheck(this)" class="form-control" style="width:30%;display:inline"> 
						Last name(성) <input type="text" name="lastName" id="lastName" value="${fn:split(vo.nameEng,' ')[1]}" onkeyup="spaceCheck(this)" class="form-control" style="width:30%;display:inline"> 
					</td>
				</tr>
				<tr>
					<th>성별</th>
					<td>
						<input type="radio" id="gender1" name="gender" value="남자" ${vo.gender=='남자'?'checked':''}>남자
						<input type="radio" id="gender2" name="gender" value="여자" ${vo.gender=='여자'?'checked':''}>여자
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type="date" name="birthday" id="birth" value="${vo.birthday}" class="form-control"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<input type="text" name="email1" id="email1" value="${fn:split(vo.email,'@')[0]}" class="form-control" onkeyup="spaceCheck(this)" style="width:30%;display:inline"> 
						@<input type="text" name="email2" id="email2" value="${fn:split(vo.email,'@')[1]}"  class="form-control" onkeyup="spaceCheck(this)"  style="width:30%;display:inline">
						<select name="email3" id="email3" class="form-control" style="width:30%;display:inline" onchange="fEmailChange()">
							<option value="직접입력">직접입력</option>
							<option value="naver.com" ${fn:split(vo.email,'@')[1]=='naver.com'?'selected':''}>naver.com</option>
							<option value="daum.net" ${fn:split(vo.email,'@')[1]=='daum.net'?'selected':''}>daum.net</option>
							<option value="gmail.com" ${fn:split(vo.email,'@')[1]=='gmail.com'?'selected':''}>gmail.com</option>
							<option value="hanmail.net"  ${fn:split(vo.email,'@')[1]=='hanmail.net'?'selected':''}>hanmail.net</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>휴대전화</th>
					<td><div class="form-inline">
			      <input type="text" name="tel1" id="tel1"  size=2 maxlength=3 value="010" readonly class="form-control"/>-
			      <input type="text" name="tel2" id="tel2" value="${fn:split(vo.phoneNumber,'-')[1]}" size=4 maxlength=4 onkeyup="spaceCheck(this)" class="form-control"/>-
			      <input type="text" name="tel3" id="tel3" value="${fn:split(vo.phoneNumber,'-')[2]}"" size=4 maxlength=4 onkeyup="spaceCheck(this)" class="form-control"/>
					</div></td>
				</tr>
				<tr>
					<th>자택전화</th>
					<td><div class="form-inline">
						<select name="hometel1" id="hometel1">
					    <option value="02" ${fn:split(vo.homeNumber,'-')[0]=='02'?'selected':''}>서울</option>
					    <option value="031" ${fn:split(vo.homeNumber,'-')[0]=='031'?'selected':''}>경기</option>
					    <option value="032" ${fn:split(vo.homeNumber,'-')[0]=='032'?'selected':''}>인천</option>
					    <option value="041"  ${fn:split(vo.homeNumber,'-')[0]=='041'?'selected':''}>충남</option>
					    <option value="042" ${fn:split(vo.homeNumber,'-')[0]=='042'?'selected':''}>대전</option>
					    <option value="043" ${fn:split(vo.homeNumber,'-')[0]=='043'?'selected':''}>충북</option>
			        <option value="051" ${fn:split(vo.homeNumber,'-')[0]=='051'?'selected':''}>부산</option>
			        <option value="052" ${fn:split(vo.homeNumber,'-')[0]=='052'?'selected':''}>울산</option>
			        <option value="061" ${fn:split(vo.homeNumber,'-')[0]=='061'?'selected':''}>전북</option>
			        <option value="062" ${fn:split(vo.homeNumber,'-')[0]=='062'?'selected':''}>광주</option>
					  </select>-
			      <input type="text" name="hometel2" value="${fn:split(vo.homeNumber,'-')[1]}" size=4 maxlength=4 class="form-control"/>-
			      <input type="text" name="hometel3" value="${fn:split(vo.homeNumber,'-')[2]}" size=4 maxlength=4 class="form-control"/>
					</div></td>
				</tr>
				<tr>
					<th>자택주소</th>
					<td>
						<div class="form-inline">
							<input type="text" name="postcode" id="sample6_postcode" value="${fn:split(vo.address,'/')[0]}" placeholder="우편번호" class="form-control mb-1">
							<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary mb-1"><br/>
						</div>
							<input type="text" name="roadAddress" id="sample6_address"  value="${fn:split(vo.address,'/')[1]}" size="50" placeholder="주소" class="form-control mb-1">
						<div class="form-inline">
							<input type="text" name="detailAddress" id="sample6_detailAddress"  value="${fn:split(vo.address,'/')[2]}" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
							<input type="text" name="extraAddress" id="sample6_extraAddress"  value="${fn:split(vo.address,'/')[3]}" placeholder="참고항목" class="form-control">
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="text-center mt-5">
						<input type="button" value="정보수정" class="btn btn-info" onclick="fCheck()"/>
						<input type="button" value="돌아가기" class="btn btn-warning"/>
					</td>
				</tr>
	  </table>
	  <div style="height:20px"></div>
	  <input type="hidden" name="nameEng">
	  <input type="hidden" name="tel">
	  <input type="hidden" name="hometel">
	  <input type="hidden" name="email">
	  <input type="hidden" name="address">
  </form>
</div>
<div style="height:100px"></div>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>
