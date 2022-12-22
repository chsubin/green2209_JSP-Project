package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;

public class AdMemLevelUpdateCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null?0 : Integer.parseInt(request.getParameter("idx"));
		int level = request.getParameter("level")==null?0 : Integer.parseInt(request.getParameter("level"));
		
		MemberDAO dao = new MemberDAO();
		String res = dao.memLevelUpdate(idx,level);
		
		response.getWriter().write(res);
		
	}

}
