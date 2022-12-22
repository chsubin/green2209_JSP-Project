package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conn.SecurityUtil;

public class MemUnresisterCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pwd = request.getParameter("pwd")==null?"":request.getParameter("pwd");
		HttpSession session = request.getSession();
		
		String mid= session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getLoginCheck(mid);
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		if(!pwd.equals(vo.getPwd())) { //비밀번호를 못맞췃을때
			response.getWriter().write("2");
			return;
		}
		System.out.println("통과!!");
		
		String res = dao.memUnresister(mid);
		System.out.println(res);
		response.getWriter().write(res);
		System.out.println(res);
		
		if(res.equals("1")) {
			session.invalidate();
		}
		
	}

}
