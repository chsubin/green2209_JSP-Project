package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;

public class MemPwdSearchOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null?"":request.getParameter("mid");
		String name = request.getParameter("name")==null?"":request.getParameter("name");
		String email = request.getParameter("email")==null?"":request.getParameter("email");

		
		MemberDAO dao = new MemberDAO();
	  MemberVO vo = dao.getLoginCheck(mid);
	  
	  String res;
	  
	  if(vo.getMid()==null||!name.equals(vo.getNameKor())||!email.equals(vo.getEmail())) {
	  	res="0";
	  	response.getWriter().write(res);
	  	return;
	  }
	  
	  int intPwd = (int)((Math.random()*8999)+1000);
	  SecurityUtil security = new SecurityUtil();
	  String strPwd = String.valueOf(intPwd) ;
	  String resetPwd=security.encryptSHA256(strPwd);
	  
	  res =dao.getPwdReset(mid,resetPwd);
	  
	  if(res.equals("0")) {
	  	res="2";
	  }
	  else {
	  	res=strPwd;
	  }
	 
	  response.getWriter().write(res);
	}

}
