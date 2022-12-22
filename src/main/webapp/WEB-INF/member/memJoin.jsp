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
let idFlag=0;

	function fCheck(){
    //폼의 유효성 검사~~~
  	let tel1=myform.tel1.value;
    let tel2=myform.tel2.value;
    let tel3=myform.tel3.value;
    let tel = tel1 +"-" + tel2 + "-" + tel3;
    
  	let hometel1=myform.hometel1.value;
    let hometel2=myform.hometel2.value;
    let hometel3=myform.hometel3.value;
    let hometel = hometel1 +"-" + hometel2 + "-" + hometel3+" ";
    
    let firstName = myform.firstName.value;
    let lastName = myform.lastName.value;
    
    
    //정규식
    let nameKor = myform.nameKor.value; const nameKorregx =/^[가-힣]{2,20}$/g;
    let nameEng = firstName+" "+lastName; const nameEngregx =/^[A-Za-z]{2,20}$/g;
    let mid = myform.mid.value;const midregx =/^[0-9a-z_]{4,12}$/g;
		let pwd = myform.pwd.value;const pwdregx=/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$/g;
    const regTel = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/gm
    const regHomeTel = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}\s$/gm
    let email1 = myform.email1.value;const emailregx=/^[0-9a-zA-Z]{2,45}/g;
    
    
    if(!nameKor.match(nameKorregx)){alert("한글 이름은 한글만 사용해주세요.");myform.nameKor.focus();return;}
    else if(!firstName.match(nameEngregx)||!lastName.match(nameEngregx)){
    	if(firstName==""||lastName==""){alert("영어 이름을 입력해주세요.");myform.firstName.focus();return;}
    	alert("영어 이름은 영어만 사용해주세요.");
    	return;}
    else if(!mid.match(midregx)){alert("아이디는 4~12자의 영문소문자,숫자,밑줄만 사용해주세요.");myform.mid.focus();return;}
    else if(!pwd.match(pwdregx)){alert("비밀번호는 8~20자, 하나이상의 영문 대/소문자,숫자,특수문자를 입력해주세요.");myform.pwd.focus();return;}
    else if(!tel.match(regTel)){alert("전화번호는 형식에 맞추어주세요.(010-0000-0000)");myform.tel1.focus();return;}
    else if(hometel2.length>0||hometel3.length>0){
    	if(!hometel.match(regHomeTel)){alert("전화번호는 형식에 맞추어주세요.지역번호-0000-0000");myform.homeTel1.focus();return;}
    }
    else if(!email1.match(emailregx)){alert("이메일은 45자 이하의 영문 대/소문자, 숫자만 입력해주세요.");myform.email1.focus();return;}
    else if(myform.pwd.value!=myform.pwdConfirm.value){alert("비밀번호 확인이 일치하지 않습니다.");myform.pwdConfirm.focus();return;}
    
    
    //아이디와 닉네임 중복체크 버튼에 대한 체크...
    if(idFlag==0){
        alert("아이디 중복체크를 먼저 해주세요.");return;
    }
    
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
//id 중복체크
	function idCheck(){
    let mid = myform.mid.value;
    let url = "${ctp}/memIdCheck.mem?mid="+mid;
    
    if (mid.trim() ==""){
        alert("아이디를 입력하세요!");
        myform.mid.focus();
    }
    else {
        idFlag=1;
        window.open(url,"nWin","width=500px,height=250px");
    }
	}
	//
	function idChange(e){
		spaceCheck(e);
		idFlag=0;
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
  <h2>회원가입</h2>
  <hr/>
  <div style="height:20px"></div>
  <div style="margin:0 auto;width:100%"><h4>기본 입력</h4></div>
  <form name="myform" method="post" action="${ctp}/memJoinOk.mem">
	  <table class="table form-group">
				<tr>
					<th><font color="red">*</font>성명(국문)</th>
					<td><input type="text" name="nameKor" id="nameKor" onkeyup="spaceCheck(this)" class="form-control" ></td>
				</tr>
				<tr>
					<th><font color="red">*</font>성명(영문)</th>
					<td>
						First name(이름) <input type="text" name="firstName" id="firstName" onkeyup="spaceCheck(this)" class="form-control" style="width:30%;display:inline"> 
						Last name(성) <input type="text" name="lastName" id="lastName" onkeyup="spaceCheck(this)" class="form-control" style="width:30%;display:inline"> 
					</td>
				</tr>
				<tr>
					<th><font color="red">*</font>성별</th>
					<td>
						<input type="radio" id="gender1" name="gender" value="남자" checked>남자
						<input type="radio" id="gender2" name="gender" value="여자">여자
					</td>
				</tr>
				<tr>
					<th><font color="red">*</font>생년월일</th>
					<td><input type="date" name="birthday" id="birth" value="2000-01-01" class="form-control"></td>
				</tr>
				<tr>
					<th><font color="red">*</font>이메일</th>
					<td>
						<input type="text" name="email1" id="email1" class="form-control" onkeyup="spaceCheck(this)" style="width:30%;display:inline"> 
						@<input type="text" name="email2" id="email2" class="form-control" onkeyup="spaceCheck(this)"  style="width:30%;display:inline">
						<select name="email3" id="email3" class="form-control" style="width:30%;display:inline" onchange="fEmailChange()">
							<option value="직접입력">직접입력</option>
							<option value="naver.com">naver.com</option>
							<option value="daum.net">daum.net</option>
							<option value="gmail.com">gmail.com</option>
							<option value="hanmail.net">hanmail.net</option>
						</select>
					</td>
				</tr>
				<tr>
					<th><font color="red">*</font>휴대전화</th>
					<td><div class="form-inline">
			      <input type="text" name="tel1" id="tel1" size=2 maxlength=3 value="010" readonly class="form-control"/>-
			      <input type="text" name="tel2" id="tel2" size=4 maxlength=4 onkeyup="spaceCheck(this)" class="form-control"/>-
			      <input type="text" name="tel3" id="tel3" size=4 maxlength=4 onkeyup="spaceCheck(this)" class="form-control"/>
					</div></td>
				</tr>
				<tr>
					<th>자택전화</th>
					<td><div class="form-inline">
						<select name="hometel1" id="hometel1">
					    <option value="02">서울</option>
					    <option value="031">경기</option>
					    <option value="032">인천</option>
					    <option value="041">충남</option>
					    <option value="042">대전</option>
					    <option value="043">충북</option>
			        <option value="051">부산</option>
			        <option value="052">울산</option>
			        <option value="061">전북</option>
			        <option value="062">광주</option>
					  </select>-
			      <input type="text" name="hometel2" size=4 maxlength=4 class="form-control"  onkeyup="spaceCheck(this)" />-
			      <input type="text" name="hometel3" size=4 maxlength=4 class="form-control"  onkeyup="spaceCheck(this)"/>
					</div></td>
				</tr>
				<tr>
					<th>자택주소</th>
					<td>
						<div class="form-inline">
							<input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control mb-1">
							<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary mb-1"><br/>
						</div>
							<input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
						<div class="form-inline">
							<input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
							<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
						</div>
					</td>
				</tr>
	  </table>
	   <div style="height:20px"></div>
	  <div style="margin:0 auto;width:100%"><h4>비밀번호 입력</h4></div>
	  <table class="table form-group">
			<tr>
				<th><font color="red">*</font>아이디</th>
				<td style="width:20%"><input type="text" name="mid" id="mid"  class="form-control" onkeyup="idChange(this)"></td>
				<td><button type="button"  onclick="idCheck()">아이디 중복확인</button> 5~12자 이내 영문 또는 영문/숫자 조합</td>
			</tr>
			<tr>
				<th><font color="red">*</font>비밀번호</th>
				<td style="width:20%"><input type="password" name="pwd" id="pwd" onkeyup="spaceCheck(this)" class="form-control"></td>
				<td>비밀번호입력안내❓ 8~20자 이내 영문/숫자 조합(특수문자 입력 필수)</td>
			</tr>
			<tr>
				<th><font color="red">*</font>비밀번호 확인</th>
				<td style="width:20%"><input type="password" name="pwdConfirm" id="pwdConfirm" onkeyup="spaceCheck(this)" class="form-control" ></td>
				<td></td>
			</tr>
			<tr>
			<tr>
				<td colspan="3" class="text-center mt-3">
					<input type="button" value="회원가입" class="btn btn-info" onclick="fCheck()"/>
					<input type="button" value="돌아가기" class="btn btn-secondary"/>
				</td>
			</tr>
	  </table>
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
