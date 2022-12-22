package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;

public class AdMemberDelCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null?0 : Integer.parseInt(request.getParameter("idx"));
		
		MemberDAO dao = new MemberDAO();
		String res = dao.memDelete(idx);
		
		response.getWriter().write(res);
		

	}

}
