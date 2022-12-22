package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;

public class MemJoinOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nameKor = request.getParameter("nameKor")==null? "":request.getParameter("nameKor");
		String nameEng = request.getParameter("nameEng")==null? "":request.getParameter("nameEng");
		String gender = request.getParameter("gender");
		String birthday = request.getParameter("birthday")==null? "":request.getParameter("birthday");
		String email = request.getParameter("email")==null? "":request.getParameter("email");
		String phoneNumber = request.getParameter("tel")==null? "":request.getParameter("tel");
		String homeNumber = request.getParameter("hometel")==null? "":request.getParameter("hometel");
		String address = request.getParameter("address")==null? "":request.getParameter("address");
		String mid = request.getParameter("mid")==null? "":request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null? "":request.getParameter("pwd");
		
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo = new MemberVO();
		vo.setNameKor(nameKor);
		vo.setNameEng(nameEng);
		vo.setGender(gender);
		vo.setBirthday(birthday);
		vo.setEmail(email);
		vo.setPhoneNumber(phoneNumber);
		vo.setHomeNumber(homeNumber);
		vo.setAddress(address);
		vo.setMid(mid);
		vo.setPwd(pwd);
		
		System.out.println("통과~~");
		
		String res = dao.memJoinOk(vo);
		String url;
		String msg;
		
		if(res.equals("1")) {//회원가입 성공
			url=request.getContextPath()+"/member/memLogin.mem";
			msg="memJoinOk";
		}
		else { //회원가입 실패
			url=request.getContextPath()+"/member/memJoin.mem";
			msg="memJoinNo";
			
		}
		
		request.setAttribute("url", url);
		request.setAttribute("msg", msg);
		

	}
}
