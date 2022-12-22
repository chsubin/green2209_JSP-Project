package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemLogoutCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		String mid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		String name = session.getAttribute("sName")==null?"":(String)session.getAttribute("sName");
		session.invalidate();
		
		
		request.setAttribute("val", mid+name);
		request.setAttribute("msg", "logout");
		request.setAttribute("url", request.getContextPath()+"/");
	}

}
