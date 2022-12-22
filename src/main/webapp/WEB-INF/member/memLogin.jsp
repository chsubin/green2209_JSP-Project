<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% 
	String sw =request.getParameter("sw");
	pageContext.setAttribute("sw", sw);
	
  Cookie [] cookies = request.getCookies();
  if (cookies!=null){
      for(int i=0;i<cookies.length;i++){
          if(cookies[i].getName().equals("cMid")){
              String mid=cookies[i].getValue();
              pageContext.setAttribute("cMid", mid);
          }
      }
  }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>그린아트호텔</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/include/bs4.jsp"></jsp:include> 
  <jsp:include page="/include/hotel.jsp"></jsp:include>
  <style>
		/*=-----------------------------*/
		th {
		 width : 20%;
		 background-color: #F6EFD7; 
		}
  </style>
</head>
<script>
	'use strict';
	
	function fCheck1(){
		
		let mid = myform.mid.value;
		let pwd = myform.pwd.value;
		
		if (mid.trim()==""){
			alert("아이디를 입력해주세요.");
			myform.mid.focus();
			return;
		}
		else if(pwd.trim()==""){
			alert("비밀번호를 입력해주세요.");
			myform.pwd.focus();
			return;
		}
		
		myform.loginSw.value = 0; //회원로그인
		myform.submit();
			
		}
	function fCheck2(){
		let rvIdx = myform.rvIdx.value;
		let name = myform.name.value;
		
		if (rvIdx.trim()==""){
			alert("예약번호를 입력해주세요.");
			myform.rvIdx.focus();
			return;
		}
		else if (!rvIdx.match(/^[0-9]*-[0-9]*$/g)){
			alert("예약번호는 숫자와 -으로 입력해주세요.");
			myform.rvIdx.focus();
			return;
		}
		else if(name.trim()==""){
			alert("성명을 입력해주세요.");
			myform.name.focus();
			return;
		}
		
		myform.loginSw.value = 1; //비회원로그인 
		myform.submit();
		
	}
	function searchIdx(){
		let name = $("#moname").val()
		let phoneNumber = $("#mophone").val()
		
		$.ajax({
			url:"${ctp}/memRvIdxSearchOk.mem",
			data: {
				name: name,
				phoneNumber: phoneNumber
				},
			success: function(res){
				if(res!="0") $("#moSearch").html("<b>"+res+"</b>");
				else $("#moSearch").html("<font color='red'>예약번호 찾기에 실패하였습니다.</font>");
			},
			error : function(){
				alert("전송오류~~");
			}
		});
		
	}
</script>
<body>
<jsp:include page="/include/header.jsp"></jsp:include>
<div class="container" style="margin-top:60px;">
  <h2>로그인</h2>
	<hr style="border : 1px solid #444"/>
  <div style="height:20px"></div>
  <div class="container" style="width:60%">
	 <h3 class="text-center"> 그린리워즈에 오신 것을 환영합니다.</h3><br/><br/>
	 <p class="text-center"> 그린리워즈 번호와 비밀번호를 입력해 주시기 바랍니다.</p>
	 <p class="text-center"> *그린리워즈 회원이 되시면 회원만을 위한 다양한 서비스와 혜택을 받으실 수 있습니다.</p>
	  <ul class="nav nav-tabs" role="tablist">
	    <li class="nav-item" style="width:50%">
	      <a class="nav-link active" data-toggle="tab" href="#sw0">회원</a>
	    </li>
	    <li class="nav-item" style="width:50%">
	      <a class="nav-link" data-toggle="tab" href="#sw1">비회원</a>
	    </li>
	  </ul>
		<form name="myform" method="post" action="${ctp}/memLoginOk.mem">
	 	 <div class="tab-content">
			  <div id="sw0" class="container text-center tab-pane active" style="width:100%;background-color: #F6EFD7;">
						<table class="form-group p-5" style="width:80%;margin:0 auto; padding:20px">
							<tr>
								<td class="p-1" width="80%"><input type="text" class="form-control mt-5" name="mid" value="${cMid}"  placeholder="아이디를 입력해주세요." /></td>
								<td rowspan="2" width="20%"><input type="button" class="btn btn-secondary btn-lg mt-5" onclick="fCheck1();" value="로그인" style="width:100%;height:100%;padding:20px"></td>
							</tr>			
							<tr>
								<td class="p-1" width="70%"><input type="password" name="pwd"   placeholder="비밀번호를 입력해주세요."  class="form-control"/></td>
							</tr>
							<tr>
								<td colspan="2" class="text-left">
									<input type="checkbox" name="containId" class="mb-2" value="on"/>아이디 저장
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<a href="${ctp}/memJoin.mem"><input type="button" class="btn btn-info mb-5" value="회원가입"/></a>
									<a href="${ctp}/memIdSearch.mem"><input type="button" class="btn btn-success mb-5" value="아이디 찾기"/></a>
									<a href="${ctp}/memPwdSearch.mem"><input type="button" class="btn btn-warning mb-5" value="비밀번호 찾기"/></a>
								</td>
							</tr>
						</table>
			  </div>
			  <div id="sw1" class="container text-center tab-pane fade" style="width:100%;background-color: #F6EFD7;">
						<table class="form-group p-5" style="width:80%;margin:0 auto; padding:20px">
							<tr>
								<td class="p-1 text-right" width="20%"><div class="mt-5"> 예약번호: </div></td>
								<td class="p-1" width="60%"><input type="text" class="form-control mt-5" name="rvIdx" placeholder="예약 시 받은 번호를 입력해주세요."/></td>
								<td rowspan="2" width="20%"><input type="button" class="btn btn-secondary btn-lg mt-5" onclick="fCheck2();" value="로그인" style="width:100%;height:100%;padding:20px"></td>
							</tr>			 
							<tr>
								<td class="p-1 text-right" width="20%"><div>예약자 성명:</div></td>
								<td class="p-1" width="60%"><input type="text" name="name"  placeholder="예약 시 기입한 이름을 입력해주세요." class="form-control"/></td>
							</tr>
							<tr>
								<td colspan="2" class="text-left pl-5">
									<input type="checkbox" name="containId" class="ml-5 mb-5"  data-toggle="modal" data-target="#myModal" >예약번호 찾기
								</td>
							</tr>
						</table>
			  </div>
			  <input type="hidden" name="loginSw">
			</div>
		</form>
  </div>
</div>

  <!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">예약 번호 찾기</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	예악자 성명 :
        	<input type="text" class="form-control" id="moname">
        	예약자 연락처 : 
        	<input type="text" class="form-control" id="mophone">
        	<br/><br/>
        	<h6>예약번호 검색 결과</h6>
        	<div style="width:100%;height:30px" class="border"><span id="moSearch"></span></div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-success" onclick="searchIdx()">찾기</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>


<p><br/></p>
<div style="height:100px"></div>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>