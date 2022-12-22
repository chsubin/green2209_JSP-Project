package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conn.SecurityUtil;

public class MemPwdUpdateOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String originPwd = request.getParameter("originPwd")==null?"":request.getParameter("originPwd");
		String newPwd = request.getParameter("newPwd")==null?"":request.getParameter("newPwd");
		
		
		HttpSession session = request.getSession();
		
		String mid= session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getLoginCheck(mid);
		
		SecurityUtil security = new SecurityUtil();
		originPwd = security.encryptSHA256(originPwd);
		
		
		if(!originPwd.equals(vo.getPwd())) { //비밀번호를 못맞췃을때
			response.getWriter().write("2");
			return;
		}
		
		newPwd = security.encryptSHA256(newPwd);
		
		String res = dao.getPwdReset(mid, newPwd);
		response.getWriter().write(res);
		

	}

}
